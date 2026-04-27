// =============================================================
// File: nat_upboard_top.v
// Description: 
//   NAT 模块上板验证顶层。
//   通过 VIO（Virtual I/O）从 Vivado Hardware Manager 注入
//   测试激励，通过 ILA 抓取 NAT_Mgr 内部信号。
//   不依赖外部以太网接口，专用于验证 NAT 核心逻辑的硬件
//   功能正确性。
// 
// Clock:
//   sys_clk: 200 MHz 差分晶振 (BADJ_CLK1_P/N)
//   nat_clk: 125 MHz (由 MMCM 从 sys_clk 分频得到)
// =============================================================
`timescale 1ns / 1ps

module nat_upboard_top (
    // 板载 200 MHz 差分晶振
    input  wire sys_clk_p,
    input  wire sys_clk_n
    // 板载复位按钮（高电平复位，需取反；如果板子是低电平复位则去掉取反）
    // input  wire sys_rst
);

    // =========================================================
    // 时钟与复位
    // =========================================================
    wire sys_clk_buf;       // 200 MHz 单端时钟（IBUFDS 输出）
    wire nat_clk;           // 125 MHz NAT 工作时钟（MMCM 输出）
    wire mmcm_locked;       // MMCM 锁定指示
    wire rst_n_sync;        // 同步释放的复位信号

    // 差分时钟缓冲
    IBUFDS #(
        .DIFF_TERM("FALSE"),
        .IBUF_LOW_PWR("FALSE"),
        .IOSTANDARD("LVDS")
    ) u_ibufds_sysclk (
        .I  (sys_clk_p),
        .IB (sys_clk_n),
        .O  (sys_clk_buf)
    );

    // MMCM: 200 MHz → 125 MHz
    // 用 Vivado 的 Clocking Wizard IP 生成（见后文说明）
    clk_wiz_0 u_clk_wiz (
        .clk_in1  (sys_clk_buf),
        .reset    (1'b0),
        .locked   (mmcm_locked),
        .clk_out1 (nat_clk)
    );

    // 复位同步释放：MMCM 锁定后才释放复位
    reg [3:0] rst_sync_reg = 4'b0000;
    always @(posedge nat_clk or negedge mmcm_locked) begin
        if (!mmcm_locked)
            rst_sync_reg <= 4'b0000;
        else
            rst_sync_reg <= {rst_sync_reg[2:0], 1'b1};
    end
    assign rst_n_sync = rst_sync_reg[3];

    // =========================================================
    // VIO 输出信号（由 VIO IP 驱动，可在 Hardware Manager 设置）
    // =========================================================
    // 出网通路输入
    wire [31:0] vio_IP_lan;
    wire [15:0] vio_TCPPort_lan;
    wire [15:0] vio_UDPPort_lan;
    wire [15:0] vio_icmpID_lan;
    wire        vio_TCPPort_lan_vld;
    wire        vio_UDPPort_lan_vld;
    wire        vio_icmpID_lan_vld;
    wire        vio_lan_vld;
    wire [2:0]  vio_TCP_lan_flag;
    wire        vio_TCP_lan_flag_vld;
    wire        vio_outbound_ack;
    wire        vio_outbound_drop;

    // 入网通路输入
    wire [15:0] vio_TCPPort_wan;
    wire [15:0] vio_UDPPort_wan;
    wire [15:0] vio_icmpID_wan;
    wire        vio_TCPPort_wan_vld;
    wire        vio_UDPPort_wan_vld;
    wire        vio_icmpID_wan_vld;
    wire        vio_wan_vld;
    wire [2:0]  vio_TCP_wan_flag;
    wire        vio_TCP_wan_flag_vld;
    wire        vio_inbound_ack;
    wire        vio_inbound_drop;

    // 配置寄存器（保持默认值即可）
    wire [11:0] vio_ram_dp_cfg_register;
    wire [9:0]  vio_ram_2p_cfg_register;
    wire [6:0]  vio_rf_2p_cfg_register;

    // CPU 配置接口（可暂时不用，固定为 0）
    wire [31:0] vio_np_cpu_data_in;
    wire [18:0] vio_np_cpu_addr;
    wire [1:0]  vio_np_cpu_ctr;

    // =========================================================
    // NAT_Mgr 输出信号（供 VIO 监测和 ILA 抓取）
    // =========================================================
    wire [15:0] Port_lan_NAT;
    wire        otb_fifo_empty;
    wire [15:0] Port_wan_NAT;
    wire [31:0] IP_wan_NAT;
    wire        inbound_fail;
    wire        ib_fifo_empty;
    wire        nat_table_init_end;
    wire [31:0] np_cpu_data_out;
    wire        data_out_vld;

    // =========================================================
    // VIO 例化
    // =========================================================
    // VIO IP 的输入/输出宽度需要在 IP Catalog 里配置匹配
    // 详见 README 配置说明
    vio_nat u_vio (
        .clk           (nat_clk),
        // VIO 输出（probe_out）：由 Hardware Manager 设置，输入到 NAT_Mgr
        .probe_out0    (vio_IP_lan),
        .probe_out1    (vio_TCPPort_lan),
        .probe_out2    (vio_UDPPort_lan),
        .probe_out3    (vio_icmpID_lan),
        .probe_out4    (vio_TCPPort_lan_vld),
        .probe_out5    (vio_UDPPort_lan_vld),
        .probe_out6    (vio_icmpID_lan_vld),
        .probe_out7    (vio_lan_vld),
        .probe_out8    (vio_TCP_lan_flag),
        .probe_out9    (vio_TCP_lan_flag_vld),
        .probe_out10   (vio_outbound_ack),
        .probe_out11   (vio_outbound_drop),
        .probe_out12   (vio_TCPPort_wan),
        .probe_out13   (vio_UDPPort_wan),
        .probe_out14   (vio_icmpID_wan),
        .probe_out15   (vio_TCPPort_wan_vld),
        .probe_out16   (vio_UDPPort_wan_vld),
        .probe_out17   (vio_icmpID_wan_vld),
        .probe_out18   (vio_wan_vld),
        .probe_out19   (vio_TCP_wan_flag),
        .probe_out20   (vio_TCP_wan_flag_vld),
        .probe_out21   (vio_inbound_ack),
        .probe_out22   (vio_inbound_drop),
        // VIO 输入（probe_in）：由 NAT_Mgr 输出，在 Hardware Manager 中观测
        .probe_in0     (Port_lan_NAT),
        .probe_in1     (otb_fifo_empty),
        .probe_in2     (Port_wan_NAT),
        .probe_in3     (IP_wan_NAT),
        .probe_in4     (inbound_fail),
        .probe_in5     (ib_fifo_empty),
        .probe_in6     (nat_table_init_end)
    );

    // 配置寄存器固定为 0（默认配置）
    assign vio_ram_dp_cfg_register = 12'b0;
    assign vio_ram_2p_cfg_register = 10'b0;
    assign vio_rf_2p_cfg_register  = 7'b0;
    assign vio_np_cpu_data_in      = 32'b0;
    assign vio_np_cpu_addr         = 19'b0;
    assign vio_np_cpu_ctr          = 2'b0;

    // =========================================================
    // NAT_Mgr 例化
    // =========================================================
    NAT_Mgr u_NAT_Mgr (
        .clk                (nat_clk),
        .rst_n              (rst_n_sync),
        // 出网通路
        .IP_lan             (vio_IP_lan),
        .TCPPort_lan        (vio_TCPPort_lan),
        .UDPPort_lan        (vio_UDPPort_lan),
        .icmpID_lan         (vio_icmpID_lan),
        .TCPPort_lan_vld    (vio_TCPPort_lan_vld),
        .UDPPort_lan_vld    (vio_UDPPort_lan_vld),
        .icmpID_lan_vld     (vio_icmpID_lan_vld),
        .lan_vld            (vio_lan_vld),
        .TCP_lan_flag       (vio_TCP_lan_flag),
        .TCP_lan_flag_vld   (vio_TCP_lan_flag_vld),
        .outbound_ack       (vio_outbound_ack),
        .outbound_drop      (vio_outbound_drop),
        .Port_lan_NAT       (Port_lan_NAT),
        .otb_fifo_empty     (otb_fifo_empty),
        // 入网通路
        .TCPPort_wan        (vio_TCPPort_wan),
        .UDPPort_wan        (vio_UDPPort_wan),
        .icmpID_wan         (vio_icmpID_wan),
        .TCPPort_wan_vld    (vio_TCPPort_wan_vld),
        .UDPPort_wan_vld    (vio_UDPPort_wan_vld),
        .icmpID_wan_vld     (vio_icmpID_wan_vld),
        .wan_vld            (vio_wan_vld),
        .TCP_wan_flag       (vio_TCP_wan_flag),
        .TCP_wan_flag_vld   (vio_TCP_wan_flag_vld),
        .inbound_ack        (vio_inbound_ack),
        .inbound_drop       (vio_inbound_drop),
        .Port_wan_NAT       (Port_wan_NAT),
        .IP_wan_NAT         (IP_wan_NAT),
        .inbound_fail       (inbound_fail),
        .ib_fifo_empty      (ib_fifo_empty),
        // 配置寄存器
        .ram_dp_cfg_register(vio_ram_dp_cfg_register),
        .ram_2p_cfg_register(vio_ram_2p_cfg_register),
        .rf_2p_cfg_register (vio_rf_2p_cfg_register),
        // 状态输出
        .nat_table_init_end (nat_table_init_end),
        // CPU 配置接口
        .np_cpu_data_in     (vio_np_cpu_data_in),
        .np_cpu_addr        (vio_np_cpu_addr),
        .np_cpu_ctr         (vio_np_cpu_ctr),
        .np_cpu_data_out    (np_cpu_data_out),
        .data_out_vld       (data_out_vld)
    );

    // 注意：原有 NAT 模块内部 `ifdef DEBUG 保护的 ILA
    // (ila_nat_lookup_result, ila_nat_cfg, ila_map_cnt, ila_avail_pool)
    // 会在 DEBUG 宏开启时自动综合进来，无需在此重复例化

endmodule