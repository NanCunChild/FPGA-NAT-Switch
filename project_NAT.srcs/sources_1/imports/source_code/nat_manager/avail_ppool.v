// **************************************************************
// COPYRIGHT(c)2024, Xidian University
// All rights reserved.
//
// IP LIB INDEX      :  
// IP Name           :  
// File name         :  avail_ppool.v 
// Module name       :  avail_ppool
//
// Full name         :   
// Author            :   Chen Dilong
// Email             :   1523245790@qq.com
// Data              :   2024/4/23
// Version           : V 1.0 
// 
// Abstract          : available port number pool for TCP,UDP,ICMP echo in NAT 
// Called by         : Father Module
// 
// Modification history
// ------------------------------------------------------------------------------------------------------
// //
// $Log$
//
// *********************************************************************
module avail_ppool  
 (
    input  wire            clk              ,
    input  wire            rst_n            ,
    //acquire signals
    output wire [9  : 0]   number_avail     ,
    input  wire            port_use_ack     , 
//recycle  signals  
    input  wire [9  : 0]   number_rec       ,
    input  wire            number_rec_vld   ,

    input  wire [ 9 : 0]   ram_2p_cfg_register  ,

    output reg  [9 :0]  nat_map_cnt             ,//10.3
    //yfy 5.14 config interface
    input  wire [31:0]  np_cpu_data_in          ,
    input  wire [18:0]  np_cpu_addr             ,
    input  wire [ 1:0]  np_cpu_ctr              ,
    output reg  [31:0]  np_cpu_data_out         ,
    output reg          data_out_vld             
 ) ;   


reg  [9 : 0] number_din ;
reg  wr_en ;

reg         init_end  ;
reg  [9 :0] init_addr ;

wire  full  ;
wire  empty ;

always @ (posedge clk or negedge rst_n)begin
    if(~rst_n)
        init_addr  <=  10'd0 ;
    else if (!init_end && !full)
        init_addr  <=  init_addr + 10'd1 ;
    else
        init_addr  <=  init_addr ;
end

always @ (posedge clk or negedge rst_n)begin
    if(~rst_n)
        init_end   <=  1'b0 ;
    else if (init_addr == 10'h3ff)  //1024个地址
        init_end   <=  1'b1 ;
    else
        init_end   <=  init_end ;
end
 
always @ (posedge clk or negedge rst_n)begin
    if(~rst_n)
        wr_en  <=  1'b0 ;
    else if (!init_end && !full)
        wr_en  <=  1'b1 ;
    else if (number_rec_vld && !full)
        wr_en  <=  1'b1 ;
    else 
        wr_en  <=  1'b0 ;
end

always @ (posedge clk or negedge rst_n)begin
    if(~rst_n)
        number_din  <=  10'b0 ;
    else if (!init_end)
        number_din  <=  init_addr  ;
    else if (number_rec_vld)
        number_din  <=  number_rec ;
    else 
        number_din  <=  number_din ;
end

always @ (posedge clk or negedge rst_n)begin
    if(~rst_n)
        nat_map_cnt  <=  10'b0 ;
    else begin
          case ({port_use_ack,number_rec_vld})
            2'b10 :
            nat_map_cnt  <=  nat_map_cnt + 1'b1  ;
            2'b01 :
            nat_map_cnt  <=  nat_map_cnt - 1'b1  ;
          default :
            nat_map_cnt  <=  nat_map_cnt ;
          endcase
          end
end
`ifdef DEBUG
reg [31 :0] wr_en_cnt ;
reg [31 :0] port_use_ack_cnt ;

always @(posedge clk or negedge rst_n) begin
    if(~rst_n)
	    wr_en_cnt <= 32'b0;
    else if(wr_en)
        wr_en_cnt <= wr_en_cnt + 1'b1;
    else 
        wr_en_cnt <= wr_en_cnt;
end

always @(posedge clk or negedge rst_n) begin
    if(~rst_n)
	    port_use_ack_cnt <= 32'b0;
    else if(wr_en)
        port_use_ack_cnt <= port_use_ack_cnt + 1'b1;
    else 
        port_use_ack_cnt <= port_use_ack_cnt;
end
ila_avail_pool  inst_avail_pool
(
	.clk(clk),
	.probe0 (init_end),
	.probe1 (init_addr),
	.probe2 (wr_en_cnt),
	.probe3 (port_use_ack_cnt),
	.probe4 (nat_map_cnt)
);
`endif 

`ifdef ASIC
FIFO_w10_d1024_fwft  inst_FIFO_w10_d1024_fwft_number_asic
(
.clk                  (clk                ),                     
.clr                  (rst_n              ),                    
.ram_2p_cfg_register  (ram_2p_cfg_register),    
.w_data               (number_din         ),                 
.w_we                 (wr_en              ),                    
.w_full               (full               ),                  
.w_afull              (                   ),                 
.r_data               (number_avail       ),               
.r_re                 (port_use_ack       ),  
.r_empty              (empty              ),    
.r_aempty             (                   )
);


`else 
FIFO_w10_d1024_fwft inst_FIFO_w10_d1024_fwft_number_fpga
(
  .clk         (clk           ),                  // input wire clk
  .rst         (!rst_n        ),                  // input wire rst
  .din         (number_din    ),                  // input wire [9 : 0] din
  .wr_en       (wr_en         ),                  // input wire wr_en
  .rd_en       (port_use_ack  ),                  // input wire rd_en
  .dout        (number_avail  ),                  // output wire [9 : 0] dout
  .full        (full          ),                  // output wire full
  .empty       (empty         ),                  // output wire empty
  .wr_rst_busy (              ),                  // output wire wr_rst_busy
  .rd_rst_busy (              )                   // output wire rd_rst_busy
);
`endif


//********************************************
//reg config  yfy 5.14
//******************************************** 
reg     CPU_reg_wren      ;
reg     CPU_reg_rden      ;
reg [18:0] np_cpu_addr_d1 ;
reg [31:0] np_cpu_wdata_d1;

reg     CPU_reg_rd_vld    ;
reg [31:0] reg_rd_data    ; 
`ifndef NO_CPU_MODE

always @(posedge clk or negedge rst_n) begin
    if(~rst_n)
        CPU_reg_rden <= 1'b0;
    else if(np_cpu_ctr[0])
        CPU_reg_rden <= !(|np_cpu_addr[18:10]);
    else 
        CPU_reg_rden <= 1'b0;
end

//input data delay
always@(posedge clk or negedge rst_n)begin
    if(~rst_n)begin
        np_cpu_addr_d1     <= 19'h0;
    end 
    else begin
        np_cpu_addr_d1     <= np_cpu_addr     ;
    end
end

//data out
always@(posedge clk or negedge rst_n)begin   // yfy 10.3
    if(~rst_n)begin
        reg_rd_data    <= 32'h0;
        CPU_reg_rd_vld <= 1'b0;
    end 
    else if (CPU_reg_rden) begin
        case(np_cpu_addr_d1[8:0])
            `ADDR_NAT_MAP_CNT:begin
                reg_rd_data    <=  {22'h0,nat_map_cnt}; 
                CPU_reg_rd_vld <= 1'b1;
                end
        endcase
    end 
    else begin
        reg_rd_data    <= reg_rd_data;
        CPU_reg_rd_vld <= 1'b0;
    end
end

always@(posedge clk or negedge rst_n)begin
    if(~rst_n)
        np_cpu_data_out <= 32'b0;
    else if(CPU_reg_rd_vld)
        np_cpu_data_out <= reg_rd_data;
    else 
        np_cpu_data_out <= np_cpu_data_out;
end

always@(posedge clk or negedge rst_n)begin
    if(~rst_n)
        data_out_vld <= 1'b0;
    else if(CPU_reg_rd_vld)
        data_out_vld <= 1'b1; 
    else
        data_out_vld <= 1'b0;
end

`endif

endmodule
