`timescale 1ns / 1ps
`include "top_define.v" // 引用头文件

module tb_NAT_Mgr;

    // ==========================================
    // 1. 信号声明
    // ==========================================
    reg clk;
    reg rst_n;

    // Outbound (内网 -> 外网) 接口
    reg [31:0] IP_lan;
    reg [15:0] TCPPort_lan;
    reg [15:0] UDPPort_lan;
    reg [15:0] icmpID_lan;
    reg        TCPPort_lan_vld;
    reg        UDPPort_lan_vld;
    reg        icmpID_lan_vld;
    reg        lan_vld;
    reg [2:0]  TCP_lan_flag;
    reg        TCP_lan_flag_vld;
    
    // 模拟外围电路给 NAT 的反馈
    reg        outbound_ack; 
    reg        outbound_drop;

    // 输出观察
    wire [15:0] Port_lan_NAT;
    wire        otb_fifo_empty;

    // Inbound (外网 -> 内网) 接口 (暂时闲置，设为0)
    reg [15:0] TCPPort_wan;
    reg [15:0] UDPPort_wan;
    reg [15:0] icmpID_wan;
    reg        TCPPort_wan_vld;
    reg        UDPPort_wan_vld;
    reg        icmpID_wan_vld;
    reg        wan_vld;
    reg [2:0]  TCP_wan_flag;
    reg        TCP_wan_flag_vld;
    reg        inbound_ack;
    reg        inbound_drop;

    // 输出观察
    wire [15:0] Port_wan_NAT;
    wire [31:0] IP_wan_NAT;
    wire        inbound_fail;
    wire        ib_fifo_empty;

    // 配置接口
    reg [11:0] ram_dp_cfg_register;
    reg [9:0]  ram_2p_cfg_register;
    reg [6:0]  rf_2p_cfg_register;
    
    // CPU 接口 (本次测试暂不使用)
    reg [31:0] np_cpu_data_in;
    reg [18:0] np_cpu_addr;
    reg [1:0]  np_cpu_ctr;
    wire [31:0] np_cpu_data_out;
    wire        data_out_vld;

    // 状态监视
    wire nat_table_init_end;

    // ==========================================
    // 2. 实例化 DUT (Device Under Test)
    // ==========================================
    NAT_Mgr u_NAT_Mgr (
        .clk(clk),
        .rst_n(rst_n),
        // Outbound Inputs
        .IP_lan(IP_lan),
        .TCPPort_lan(TCPPort_lan),
        .UDPPort_lan(UDPPort_lan),
        .icmpID_lan(icmpID_lan),
        .TCPPort_lan_vld(TCPPort_lan_vld),
        .UDPPort_lan_vld(UDPPort_lan_vld),
        .icmpID_lan_vld(icmpID_lan_vld),
        .lan_vld(lan_vld),
        .TCP_lan_flag(TCP_lan_flag),
        .TCP_lan_flag_vld(TCP_lan_flag_vld),
        .outbound_ack(outbound_ack),
        .outbound_drop(outbound_drop),
        // Outbound Outputs
        .Port_lan_NAT(Port_lan_NAT),
        .otb_fifo_empty(otb_fifo_empty),
        
        // Inbound Inputs
        .TCPPort_wan(TCPPort_wan),
        .UDPPort_wan(UDPPort_wan),
        .icmpID_wan(icmpID_wan),
        .TCPPort_wan_vld(TCPPort_wan_vld),
        .UDPPort_wan_vld(UDPPort_wan_vld),
        .icmpID_wan_vld(icmpID_wan_vld),
        .wan_vld(wan_vld),
        .TCP_wan_flag(TCP_wan_flag),
        .TCP_wan_flag_vld(TCP_wan_flag_vld),
        .inbound_ack(inbound_ack),
        .inbound_drop(inbound_drop),
        // Inbound Outputs
        .Port_wan_NAT(Port_wan_NAT),
        .IP_wan_NAT(IP_wan_NAT),
        .inbound_fail(inbound_fail),
        .ib_fifo_empty(ib_fifo_empty),
        
        // Config & Status
        .ram_dp_cfg_register(ram_dp_cfg_register),
        .ram_2p_cfg_register(ram_2p_cfg_register),
        .rf_2p_cfg_register(rf_2p_cfg_register),
        .nat_table_init_end(nat_table_init_end),
        
        // CPU Interface
        .np_cpu_data_in(np_cpu_data_in),
        .np_cpu_addr(np_cpu_addr),
        .np_cpu_ctr(np_cpu_ctr),
        .np_cpu_data_out(np_cpu_data_out),
        .data_out_vld(data_out_vld)
    );

    // ==========================================
    // 3. 时钟生成 (100MHz, 周期10ns)
    // ==========================================
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // ==========================================
    // 4. 测试流程
    // ==========================================
    initial begin
        // --- 初始化信号 ---
        rst_n = 0;
        IP_lan = 0; TCPPort_lan = 0; UDPPort_lan = 0; icmpID_lan = 0;
        TCPPort_lan_vld = 0; UDPPort_lan_vld = 0; icmpID_lan_vld = 0;
        lan_vld = 0;
        TCP_lan_flag = 0; TCP_lan_flag_vld = 0;
        outbound_ack = 0; outbound_drop = 0;
        
        // Inbound 暂不使用
        TCPPort_wan = 0; UDPPort_wan = 0; icmpID_wan = 0;
        TCPPort_wan_vld = 0; UDPPort_wan_vld = 0; icmpID_wan_vld = 0;
        wan_vld = 0; TCP_wan_flag = 0; TCP_wan_flag_vld = 0;
        inbound_ack = 0; inbound_drop = 0;
        
        // 模拟配置寄存器给个默认值
        ram_dp_cfg_register = 0; ram_2p_cfg_register = 0; rf_2p_cfg_register = 0;
        np_cpu_data_in = 0; np_cpu_addr = 0; np_cpu_ctr = 0;

        $display("=== Simulation Start ===");

        // --- 复位释放 ---
        #100;
        rst_n = 1;
        $display("[Time %t] Reset Released. Waiting for Initialization...", $time);

        // --- 等待 NAT 表初始化完成 ---
        // 代码逻辑显示初始化需要遍历1024个地址，需要一些时间
        wait(nat_table_init_end == 1);
        #100; // 再多等一会儿稳妥
        $display("[Time %t] NAT Table Initialized!", $time);

        // --- 测试用例 1: 内网发起 TCP 连接请求 ---
        // 场景: 内网 IP 192.168.1.10 (C0A8010A), 端口 8080 (1F90), 协议 TCP
        
        @(posedge clk);
        lan_vld = 1;              // 告诉 NAT 有数据来了
        IP_lan = 32'hC0A8010A;    // Source IP
        TCPPort_lan = 16'h1F90;   // Source Port
        TCPPort_lan_vld = 1;      // 是 TCP 包
        TCP_lan_flag_vld = 1;     
        TCP_lan_flag = 3'b010;    // SYN 包 (假设 010 代表 SYN，参考代码推断)
        
        $display("[Time %t] Requesting NAT mapping for 192.168.1.10:8080 (TCP)", $time);

        @(posedge clk);
        // 脉冲信号，下一拍拉低
        lan_vld = 0;
        TCPPort_lan_vld = 0;
        TCP_lan_flag_vld = 0;

        // --- 等待结果 ---
        // 真实硬件中，后续模块处理完会给 outbound_ack，这里我们模拟后续模块立刻收到了
        // NAT 模块查表需要几个周期
        #50; 
        
        // 模拟外部模块确认读取输出FIFO
        outbound_ack = 1;
        @(posedge clk);
        outbound_ack = 0;

        // 观察波形上的 Port_lan_NAT 是否有值
        #50;
        if (Port_lan_NAT != 0) begin
            $display("[SUCCESS] NAT Assigned Public Port: %d", Port_lan_NAT);
        end else begin
            $display("[WARNING] No Port assigned yet, check waveforms.");
        end

        // --- 仿真结束 ---
        #200;
        $stop;
    end

endmodule
