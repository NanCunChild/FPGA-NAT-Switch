`timescale 1ns / 1ps
`include "top_define.v"

module tb_NAT_Outbound;

    // --- 1. 信号声明 ---
    reg clk, rst_n;
    reg [31:0] IP_lan;
    reg [15:0] TCPPort_lan, UDPPort_lan, icmpID_lan;
    reg TCPPort_lan_vld, UDPPort_lan_vld, icmpID_lan_vld, lan_vld;
    reg [2:0] TCP_lan_flag;
    reg TCP_lan_flag_vld;
    reg outbound_ack, outbound_drop;
    wire [15:0] Port_lan_NAT;
    wire otb_fifo_empty;
    
    // Inbound 关键信号
    reg [15:0] TCPPort_wan, UDPPort_wan, icmpID_wan;
    reg TCPPort_wan_vld, UDPPort_wan_vld, icmpID_wan_vld, wan_vld;
    reg [2:0] TCP_wan_flag;
    reg TCP_wan_flag_vld;
    reg inbound_ack, inbound_drop;
    wire [15:0] Port_wan_NAT;
    wire [31:0] IP_wan_NAT;
    wire inbound_fail, ib_fifo_empty;

    // 配置与监控
    reg [11:0] ram_dp_cfg_register;
    reg [9:0] ram_2p_cfg_register;
    reg [6:0] rf_2p_cfg_register;
    reg [31:0] np_cpu_data_in;
    reg [18:0] np_cpu_addr;
    reg [1:0] np_cpu_ctr;
    wire [31:0] np_cpu_data_out;
    wire data_out_vld;
    wire nat_table_init_end;

    integer timeout_cnt;
    reg [15:0] assigned_public_port; // 记录系统分配的公网端口

    // --- 2. 实例化 DUT ---
    NAT_Mgr u_NAT_Mgr (
        .clk(clk), .rst_n(rst_n),
        .IP_lan(IP_lan), .TCPPort_lan(TCPPort_lan), .UDPPort_lan(UDPPort_lan), .icmpID_lan(icmpID_lan),
        .TCPPort_lan_vld(TCPPort_lan_vld), .UDPPort_lan_vld(UDPPort_lan_vld), .icmpID_lan_vld(icmpID_lan_vld),
        .lan_vld(lan_vld), .TCP_lan_flag(TCP_lan_flag), .TCP_lan_flag_vld(TCP_lan_flag_vld),
        .outbound_ack(outbound_ack), .outbound_drop(outbound_drop),
        .Port_lan_NAT(Port_lan_NAT), .otb_fifo_empty(otb_fifo_empty),
        .TCPPort_wan(TCPPort_wan), .UDPPort_wan(UDPPort_wan), .icmpID_wan(icmpID_wan),
        .TCPPort_wan_vld(TCPPort_wan_vld), .UDPPort_wan_vld(UDPPort_wan_vld), .icmpID_wan_vld(icmpID_wan_vld),
        .wan_vld(wan_vld), .TCP_wan_flag(TCP_wan_flag), .TCP_wan_flag_vld(TCP_wan_flag_vld),
        .inbound_ack(inbound_ack), .inbound_drop(inbound_drop),
        .Port_wan_NAT(Port_wan_NAT), .IP_wan_NAT(IP_wan_NAT),
        .inbound_fail(inbound_fail), .ib_fifo_empty(ib_fifo_empty),
        .ram_dp_cfg_register(ram_dp_cfg_register), .ram_2p_cfg_register(ram_2p_cfg_register), .rf_2p_cfg_register(rf_2p_cfg_register),
        .nat_table_init_end(nat_table_init_end),
        .np_cpu_data_in(np_cpu_data_in), .np_cpu_addr(np_cpu_addr), .np_cpu_ctr(np_cpu_ctr),
        .np_cpu_data_out(np_cpu_data_out), .data_out_vld(data_out_vld)
    );

    initial begin clk = 0; forever #5 clk = ~clk; end

    // --- 4. 测试流程 ---
    initial begin
        // 初始化
        rst_n = 0;
        IP_lan = 0; TCPPort_lan = 0; UDPPort_lan = 0; icmpID_lan = 0;
        TCPPort_lan_vld = 0; UDPPort_lan_vld = 0; icmpID_lan_vld = 0; lan_vld = 0;
        TCP_lan_flag = 0; TCP_lan_flag_vld = 0; outbound_ack = 0; outbound_drop = 0;
        TCPPort_wan = 0; UDPPort_wan = 0; icmpID_wan = 0;
        TCPPort_wan_vld = 0; UDPPort_wan_vld = 0; icmpID_wan_vld = 0; wan_vld = 0;
        TCP_wan_flag = 0; TCP_wan_flag_vld = 0; inbound_ack = 0; inbound_drop = 0;
        ram_dp_cfg_register = 0; ram_2p_cfg_register = 0; rf_2p_cfg_register = 0;
        np_cpu_data_in = 0; np_cpu_addr = 0; np_cpu_ctr = 0;

        $display("=== [TEST 2] Inbound (Round-Trip) Test Started ===");
        #100; rst_n = 1;
        wait(nat_table_init_end == 1);
        #100;

        // -------------------------------------------------------
        // 步骤 1: 内网发起连接 (建立映射)
        // -------------------------------------------------------
        @(posedge clk);
        lan_vld = 1; 
        IP_lan = 32'hC0A8010A; // 192.168.1.10
        TCPPort_lan = 16'h1F90; // 8080
        TCPPort_lan_vld = 1; TCP_lan_flag_vld = 1; TCP_lan_flag = 3'b010;
        
        @(posedge clk);
        lan_vld = 0; TCPPort_lan_vld = 0; TCP_lan_flag_vld = 0;

        // 读取分配的公网端口
        timeout_cnt = 0;
        while (otb_fifo_empty == 1 && timeout_cnt < 200) begin 
            @(posedge clk); 
            timeout_cnt=timeout_cnt+1; 
        end
        
        if (otb_fifo_empty == 0) begin
            @(posedge clk);
            assigned_public_port = Port_lan_NAT;
            outbound_ack = 1; @(posedge clk); outbound_ack = 0;
            $display("[Step 1] Mapping Created. Public Port: 0x%h", assigned_public_port);
        end else begin
            $display("[FATAL] Outbound setup failed!"); $stop;
        end

        // -------------------------------------------------------
        // 步骤 2: 外网回包 (Inbound Test)
        // -------------------------------------------------------
        #200;
        $display("[Step 2] Simulating WAN packet to Public Port: 0x%h...", assigned_public_port);
        
        @(posedge clk);
        wan_vld = 1; 
        TCPPort_wan = assigned_public_port; // 目标端口 = 刚才分配的公网端口
        TCPPort_wan_vld = 1; 
        TCP_wan_flag_vld = 1; TCP_wan_flag = 3'b010; 
        
        @(posedge clk);
        wan_vld = 0; TCPPort_wan_vld = 0; TCP_wan_flag_vld = 0;

        // 等待 Inbound FIFO
        timeout_cnt = 0;
        while (ib_fifo_empty == 1 && timeout_cnt < 200) begin 
            @(posedge clk); 
            timeout_cnt=timeout_cnt+1; 
        end

        if (ib_fifo_empty == 0) begin
            @(posedge clk);
            $display("[Result] IP_wan_NAT: 0x%h (Expect C0A8010A)", IP_wan_NAT);
            $display("[Result] Port_wan_NAT: 0x%h (Expect 1F90)", Port_wan_NAT);

            if (IP_wan_NAT == 32'hC0A8010A && Port_wan_NAT == 16'h1F90) begin
                $display("==================================================");
                $display(" [SUCCESS] Inbound Traffic Translated Correctly!");
                $display("==================================================");
            end else begin
                $display("[FAILURE] Inbound Translation Wrong.");
            end
            inbound_ack = 1; @(posedge clk); inbound_ack = 0;
        end else begin
            $display("[FAILURE] Inbound lookup timeout (Not found in table).");
        end

        #200;
        $stop;
    end
endmodule