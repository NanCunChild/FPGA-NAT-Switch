`timescale 1ns / 1ps
`include "top_define.v"

module tb_NAT_Inbound;

    // --- 1. 信号声明 (与 Outbound 相同) ---
    reg clk, rst_n;
    reg [31:0] IP_lan;
    reg [15:0] TCPPort_lan, UDPPort_lan, icmpID_lan;
    reg TCPPort_lan_vld, UDPPort_lan_vld, icmpID_lan_vld, lan_vld;
    reg [2:0] TCP_lan_flag;
    reg TCP_lan_flag_vld;
    reg outbound_ack, outbound_drop;
    wire [15:0] Port_lan_NAT;
    wire otb_fifo_empty;
    // Inbound 测试重点关注这些信号
    reg [15:0] TCPPort_wan, UDPPort_wan, icmpID_wan;
    reg TCPPort_wan_vld, UDPPort_wan_vld, icmpID_wan_vld, wan_vld;
    reg [2:0] TCP_wan_flag;
    reg TCP_wan_flag_vld;
    reg inbound_ack, inbound_drop;
    wire [15:0] Port_wan_NAT; // 查表得到的内网端口
    wire [31:0] IP_wan_NAT;   // 查表得到的内网IP
    wire inbound_fail, ib_fifo_empty;
    // Config
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
    reg [15:0] expected_public_port; // 记录系统分配的公网端口，用于回包测试

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

    // --- 3. 时钟 ---
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

        $display("=== [TEST 2] Inbound (WAN->LAN) Test Started ===");
        #100; rst_n = 1;
        wait(nat_table_init_end == 1);
        #100;

        // -------------------------------------------------------
        // 铺垫阶段: 必须先由内网发起连接，NAT 表里才会有记录
        // -------------------------------------------------------
        $display("[Step 1] Pre-requisite: LAN sends packet to establish mapping...");
        @(posedge clk);
        lan_vld = 1; IP_lan = 32'hC0A8010A; TCPPort_lan = 16'h1F90; // 192.168.1.10:8080
        TCPPort_lan_vld = 1; TCP_lan_flag_vld = 1; TCP_lan_flag = 3'b010;
        @(posedge clk);
        lan_vld = 0; TCPPort_lan_vld = 0; TCP_lan_flag_vld = 0;

        // 快速读取并确认分配的端口
        timeout_cnt = 0;
        while (otb_fifo_empty == 1 && timeout_cnt < 200) begin 
            @(posedge clk); 
            timeout_cnt=timeout_cnt+1; 
        end
        
        if (otb_fifo_empty == 0) begin
            @(posedge clk);
            expected_public_port = Port_lan_NAT; // 记住这个 0xE001
            outbound_ack = 1; @(posedge clk); outbound_ack = 0;
            $display("[Setup] NAT Table Created. Public Port is: 0x%h", expected_public_port);
        end else begin
            $display("[FATAL] Setup failed. Cannot proceed."); $stop;
        end

        // -------------------------------------------------------
        // 核心测试: 外网回包
        // -------------------------------------------------------
        #200;
        $display("[Step 2] Testing Inbound Traffic...");
        $display("         Simulating WAN packet to Port 0x%h (Expect forward to C0A8010A:1F90)", expected_public_port);
        
        @(posedge clk);
        wan_vld = 1; 
        TCPPort_wan = expected_public_port; // 发给 NAT 的公网端口
        TCPPort_wan_vld = 1; // 协议类型必须匹配
        TCP_wan_flag_vld = 1; TCP_wan_flag = 3'b010; // SYN/ACK
        
        @(posedge clk);
        wan_vld = 0; TCPPort_wan_vld = 0; TCP_wan_flag_vld = 0;

        // 等待 Inbound FIFO
        timeout_cnt = 0;
        
        // 检查 ib_fifo_empty (Inbound FIFO)
        while (ib_fifo_empty == 1 && timeout_cnt < 200) begin
            @(posedge clk); 
            timeout_cnt = timeout_cnt + 1;
            
            if (u_NAT_Mgr.inst_nat_top.inbound_rw_inst.lookup_done) begin
                $display("================ [DIAGNOSTIC DUMP] ================");
                $display("1. RAM Output WAN Port [40:25] = 0x%h", u_NAT_Mgr.inst_nat_top.inbound_rw_inst.q_outbound[40:25]);
                $display("   Testbench Send Port (ff3)   = 0x%h", u_NAT_Mgr.inst_nat_top.inbound_rw_inst.port_wan_ff3);
                $display("---------------------------------------------------");
                $display("2. RAM Output Type [23:21]     = %b", u_NAT_Mgr.inst_nat_top.inbound_rw_inst.q_outbound[23:21]);
                $display("   Testbench Send Type (ff3)   = %b", u_NAT_Mgr.inst_nat_top.inbound_rw_inst.port_wan_type_ff3);
                $display("---------------------------------------------------");
                $display("3. RAM Output Valid Bit [24]   = %b", u_NAT_Mgr.inst_nat_top.inbound_rw_inst.q_outbound[24]);
                $display("---------------------------------------------------");
                $display("FINAL RESULT (out_result_en)   = %b", u_NAT_Mgr.inst_nat_top.inbound_rw_inst.out_result_en);
                $display("===================================================");
            end 
        end
        
        // 监控底层时序
        /*if (u_NAT_Mgr.inbound_rw_inst.lookup_done) begin
            $display("[Debug] lookup_done is HIGH! q_outbound[88:57]=0x%h, Expected=0x%h", 
                    u_NAT_Mgr.inbound_rw_inst.q_outbound[88:57], 32'hC0A8010A);
        end*/

        if (ib_fifo_empty == 0) begin
            @(posedge clk); // 等待数据稳定
            
            // 检查 IP_wan_NAT (应该是内网IP) 和 Port_wan_NAT (应该是内网端口)
            $display("[Result] Inbound Lookup Output: IP=0x%h, Port=0x%h", IP_wan_NAT, Port_wan_NAT);
            
            if (IP_wan_NAT == 32'hC0A8010A && Port_wan_NAT == 16'h1F90) begin
                $display("==================================================");
                $display(" [SUCCESS] Inbound Translation Correct!");
                $display("           WAN -> LAN path is working.");
                $display("==================================================");
            end else begin
                $display("[FAILURE] Wrong Translation! Expected C0A8010A:1F90");
            end
            
            // 读确认
            inbound_ack = 1; @(posedge clk); inbound_ack = 0;
        end else begin
            $display("[ERROR] Inbound FIFO Timeout! Packet dropped?");
        end

        #200;
        $stop;
    end
endmodule