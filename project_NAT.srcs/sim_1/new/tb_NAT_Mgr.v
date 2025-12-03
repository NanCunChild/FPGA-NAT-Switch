`timescale 1ns / 1ps
`include "top_define.v" 

module tb_NAT_Mgr;

    // ==========================================
    // 1. 信号声明
    // ==========================================
    reg clk;
    reg rst_n;

    // Outbound 
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
    
    reg        outbound_ack; 
    reg        outbound_drop;

    wire [15:0] Port_lan_NAT;
    wire        otb_fifo_empty;

    // Inbound
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

    wire [15:0] Port_wan_NAT;
    wire [31:0] IP_wan_NAT;
    wire        inbound_fail;
    wire        ib_fifo_empty;

    reg [11:0] ram_dp_cfg_register;
    reg [9:0]  ram_2p_cfg_register;
    reg [6:0]  rf_2p_cfg_register;
    
    reg [31:0] np_cpu_data_in;
    reg [18:0] np_cpu_addr;
    reg [1:0]  np_cpu_ctr;
    wire [31:0] np_cpu_data_out;
    wire        data_out_vld;

    wire nat_table_init_end;

    // 结果暂存
    reg [15:0] captured_port; 
    // 超时计数器
    integer timeout_cnt;

    // ==========================================
    // 2. 实例化 DUT
    // ==========================================
    NAT_Mgr u_NAT_Mgr (
        .clk(clk),
        .rst_n(rst_n),
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
        .Port_lan_NAT(Port_lan_NAT),
        .otb_fifo_empty(otb_fifo_empty),
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
        .Port_wan_NAT(Port_wan_NAT),
        .IP_wan_NAT(IP_wan_NAT),
        .inbound_fail(inbound_fail),
        .ib_fifo_empty(ib_fifo_empty),
        .ram_dp_cfg_register(ram_dp_cfg_register),
        .ram_2p_cfg_register(ram_2p_cfg_register),
        .rf_2p_cfg_register(rf_2p_cfg_register),
        .nat_table_init_end(nat_table_init_end),
        .np_cpu_data_in(np_cpu_data_in),
        .np_cpu_addr(np_cpu_addr),
        .np_cpu_ctr(np_cpu_ctr),
        .np_cpu_data_out(np_cpu_data_out),
        .data_out_vld(data_out_vld)
    );

    // ==========================================
    // 3. 时钟生成
    // ==========================================
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // ==========================================
    // 4. 测试流程
    // ==========================================
    initial begin
        // --- 初始化 ---
        rst_n = 0;
        IP_lan = 0; TCPPort_lan = 0; UDPPort_lan = 0; icmpID_lan = 0;
        TCPPort_lan_vld = 0; UDPPort_lan_vld = 0; icmpID_lan_vld = 0;
        lan_vld = 0;
        TCP_lan_flag = 0; TCP_lan_flag_vld = 0;
        outbound_ack = 0; outbound_drop = 0;
        
        TCPPort_wan = 0; UDPPort_wan = 0; icmpID_wan = 0;
        TCPPort_wan_vld = 0; UDPPort_wan_vld = 0; icmpID_wan_vld = 0;
        wan_vld = 0; TCP_wan_flag = 0; TCP_wan_flag_vld = 0;
        inbound_ack = 0; inbound_drop = 0;
        
        ram_dp_cfg_register = 0; ram_2p_cfg_register = 0; rf_2p_cfg_register = 0;
        np_cpu_data_in = 0; np_cpu_addr = 0; np_cpu_ctr = 0;
        captured_port = 0;
        timeout_cnt = 0;

        $display("=== Simulation Start ===");

        // --- 复位释放 ---
        #100;
        rst_n = 1;
        $display("[Time %t] Reset Released. Waiting for Initialization...", $time);

        // --- 等待 NAT 表初始化 ---
        wait(nat_table_init_end == 1);
        #100; 
        $display("[Time %t] NAT Table Initialized!", $time);

        // ==========================================
        // 测试用例: 内网发起 TCP 连接
        // ==========================================
        
        @(posedge clk);
        lan_vld = 1;              
        IP_lan = 32'hC0A8010A;    
        TCPPort_lan = 16'h1F90;   
        TCPPort_lan_vld = 1;      
        TCP_lan_flag_vld = 1;     
        TCP_lan_flag = 3'b010;    
        
        $display("[Time %t] Requesting NAT mapping...", $time);

        @(posedge clk);
        lan_vld = 0;
        TCPPort_lan_vld = 0;
        TCP_lan_flag_vld = 0;

        // ★★★ 修改后的智能等待逻辑 (使用 While 循环) ★★★
        timeout_cnt = 0;
        
        // 循环检查 FIFO 状态，直到有数据 或 超过 200 个周期 (2000ns)
        while (otb_fifo_empty == 1 && timeout_cnt < 200) begin
            @(posedge clk); // 等待一个时钟周期
            timeout_cnt = timeout_cnt + 1;
        end

        if (otb_fifo_empty == 0) begin
            // 数据来了！
            @(posedge clk); // 再等一拍稳定
            captured_port = Port_lan_NAT; // 抓拍
            
            $display("[Time %t] Data Detected! Captured: 0x%h", $time, captured_port);
            
            // 读确认
            outbound_ack = 1;
            @(posedge clk);
            outbound_ack = 0;
        end else begin
            // 超时了
            $display("[ERROR] Timeout waiting for NAT response!");
        end

        // --- 结果验证 ---
        #50;
        if (captured_port == 16'hE001) begin
            $display("-------------------------------------------------------");
            $display(" [SUCCESS] Test Passed! NAT Assigned Port: 0x%h", captured_port);
            $display(" Explanation: 0xE001 matches expected logic.");
            $display("-------------------------------------------------------");
        end else if (captured_port != 0 && captured_port !== 16'bx) begin
            $display("[WARNING] Port Assigned (0x%h) but not 0xE001.", captured_port);
        end else begin
            $display("[FAILURE] No valid port captured.");
        end

        #200;
        $stop;
    end

endmodule