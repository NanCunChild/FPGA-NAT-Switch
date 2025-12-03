`include "top_define.v"
module nat_top (
            input    wire          clk            ,
            input    wire          rst_n          ,
            //write, maint
            input    wire          maint_vld      ,
            input    wire  [31:0]  ip_maint       ,
            input    wire  [15:0]  port_lan_maint ,
            input    wire  [15:0]  port_wan_maint ,
            input    wire  [2 :0]  session_type   ,
            input    wire          tcp_fin_vld    , 
            input    wire  [1 :0]  tcp_fin        ,
            input    wire          tcp_syn_vld    , 
            input    wire  [1 :0]  tcp_syn        ,   
            //outbound interface  
            //lookup
            input    wire          lan_vld        ,
            input    wire  [31:0]  ip_lan         ,
            input    wire  [15:0]  port_lan       ,
            input    wire  [2 :0]  port_lan_type  ,  //tcp,udp,icmp
            output   wire  [15:0]  outwan_port    ,
            output   wire          outwan_port_en ,
            output   wire          look_incorrect ,
            output   wire          outb_cover_en  ,  
            output   wire  [9 :0]  hash_outbound_lookup ,

            //inbound interface
            //lookup
             input   wire          wan_vld        ,
             input   wire  [15:0]  port_wan       ,
             input   wire  [2 :0]  port_wan_type  ,
             output  wire  [31:0]  outip          ,
             output  wire  [15:0]  outlan_port    ,
             output  wire          out_result_en  ,
             output  wire          ib_cover_en    ,
             input   wire  [11:0]  ram_dp_cfg_register ,
             //active release
             input   wire           active_release               ,
             input   wire  [31:0]   active_release_ip            ,    
             input   wire  [15:0]   active_release_port          ,
             input   wire  [2 :0]   active_release_session_type  ,
             output  wire           release_en                   ,
             output  wire  [15:0]   delete_port_wan              ,
             //output  wire  [2 :0]   delete_session_type          ,
             //flag
             output  wire           study_done  ,
             output  wire  [1 :0]   lookup_done ,
             output  wire           init_end    ,
             //yfy 5.23 config interface
             input  wire [31:0]  np_cpu_data_in          ,
             input  wire [18:0]  np_cpu_addr             ,
             input  wire [ 1:0]  np_cpu_ctr              ,
             output reg  [31:0]  np_cpu_data_out         ,
             output reg          data_out_vld     
                 
            );    
//yfy config    
reg outbound_rd_vld;

reg  [31:0] outbound_rd_data;
reg  [18:0] np_cpu_addr_d1  ; 
reg  [31:0] np_cpu_wdata_d1 ;

reg outbound_wen;
reg outbound_ren;
wire [9 :0]outbound_waddr;
wire [9 :0]outbound_raddr;
reg  [95:0] outbound_ram_input;
reg  [95:0] outbound_ram_output;

//hash
wire        hash_en;
wire [50:0] outbound_maint;
wire [50:0] outbound_lookup;
wire [50:0] outbound_delete;
wire [9 :0] hash_outbound_maint;
wire [9 :0] hash_outbound_delete;

assign outbound_maint  = {ip_maint,port_lan_maint,session_type}; //51
assign outbound_lookup = {ip_lan,port_lan,port_lan_type};
assign outbound_delete = {active_release_ip,active_release_port,active_release_session_type};

hash  hash_inst 
(
    .clk                   (clk                  ),
    .rst_n                 (rst_n                ),
    .maint_vld             (maint_vld            ),
    .outbound_maint        (outbound_maint       ),
    .lan_vld               (lan_vld              ),
    .outbound_lookup       (outbound_lookup      ),
    .wan_vld               (wan_vld              ),
    .active_release        (active_release       ),
    .outbound_delete       (outbound_delete      ),
    .hash_en               (hash_en              ),
    .hash_outbound_maint   (hash_outbound_maint  ),
    .hash_outbound_lookup  (hash_outbound_lookup ),
    .hash_outbound_delete  (hash_outbound_delete )
  );
//outbound
//ram * outbound_rw
wire  [95:0]  q_outbound ;
wire  [ 9:0]  addr_a     ;
wire  [95:0]  data_a     ;
wire          wren_a     ;
wire          outaddr_en ;
wire  [9 :0]  out_addr   ;
wire  [9 :0]  addr_a_a   ;

assign addr_a = outaddr_en ? out_addr : addr_a_a ;


wire busy ;
//
wire ob_busy        ;
wire ob_lookup_done ;
wire ob_study_done  ;
wire init_end_o     ;

//inbound
//inbound_rw*ram
wire [15:0] q_inbound ;
wire [9 :0] addr_b    ;
wire [15:0] data_b    ;
wire        wren_b    ;
wire [9 :0] outbound_addr ;
wire        wren_u    ;
wire [9 :0] addr_u    ;
wire [15:0] data_u    ; 

//
wire ib_busy        ;
wire ib_lookup_done ;
wire ib_study_done  ;
wire init_end_i     ;

//delete * outbound_rw
wire   [16:0]   time_notcp  ;
wire   [16:0]   time_tcpsf  ;
wire   [16:0]   time_tcping ;

reg  [16:0]cpu_cd_time ;
outbound_rw  outbound_rw_inst 
(
    .clk                  (clk                   ),
    .rst_n                (rst_n                 ),
    .maint_vld            (maint_vld             ),
    .ip_maint             (ip_maint              ),
    .port_lan_maint       (port_lan_maint        ),
    .port_wan_maint       (port_wan_maint        ),
    .session_type         (session_type          ),
    .tcp_fin              (tcp_fin               ),
    .tcp_syn              (tcp_syn               ),
    .q_outbound           (q_outbound            ),
    .addr_a               (addr_a_a              ),
    .data_a               (data_a                ),
    .wren_a               (wren_a                ),
    .time_notcp           (time_notcp            ),
    .time_tcpsf           (time_tcpsf            ),
    .time_tcping          (time_tcping           ),
	.cpu_cd_time          (cpu_cd_time           ),
    .hash_en              (hash_en               ),
    .hash_outbound_maint  (hash_outbound_maint   ),
    .hash_outbound_lookup (hash_outbound_lookup  ),
    .lan_vld              (lan_vld               ),
    .ip_lan               (ip_lan                ),
    .port_lan             (port_lan              ),
    .port_lan_type        (port_lan_type         ),
    .outwan_port          (outwan_port           ),
    .outb_cover_en        (outb_cover_en         ),
    .outwan_port_en       (outwan_port_en        ),
    .look_incorrect       (look_incorrect        ),
    .busy                 (ob_busy               ),
    .lookup_done          (ob_lookup_done        ),
    .study_done           (ob_study_done         ),
    .init_end             (init_end_o            )
  );

inbound_rw  inbound_rw_inst 
(
    .clk                  (clk                  ),
    .rst_n                (rst_n                ),
    .maint_vld            (maint_vld            ),
    .outbound_addr        (outbound_addr        ),
    .port_wan_maint       (port_wan_maint       ),
    .session_type         (session_type         ),
    .q_inbound            (q_inbound            ),
    .addr_b               (addr_b               ),
    .data_b               (data_b               ),
    .wren_b               (wren_b               ),
    .wan_vld              (wan_vld              ),
    .port_wan             (port_wan             ),
    .port_wan_type        (port_wan_type        ),
    .outaddr_en           (outaddr_en           ),
    .out_addr             (out_addr             ),
    .q_outbound           (q_outbound           ),
    .outip                (outip                ),
    .outlan_port          (outlan_port          ),
    .ib_cover_en          (ib_cover_en          ),
    .out_result_en        (out_result_en        ),
    .busy                 (ib_busy              ),
    .lookup_done          (ib_lookup_done       ),
    .study_done           (ib_study_done        ),
    .init_end             (init_end_i           )
  ); 
  //delete
  //delete*ram
  wire  [95:0] q_d_d    ;
  wire  [9 :0] addr_d_d ;
  wire  [95:0] data_d_d ;
  wire         wren_d_d ;
  //delete*update
 // wire [31:0] delete_ip           ;
 // wire [15:0] delete_port         ;
 // wire [2 :0] delete_session_type ;

delete  delete_inst 
(
    .clk                         (clk                         ),
    .rst_n                       (rst_n                       ),
    .q_d                         (q_d_d                       ),
    .addr_d                      (addr_d_d                    ),
    .data_d                      (data_d_d                    ),
    .wren_d                      (wren_d_d                    ),
    .time_notcp                  (time_notcp                  ),
    .time_tcpsf                  (time_tcpsf                  ),
    .time_tcping                 (time_tcping                 ),
    .delete_port_wan             (delete_port_wan             ),
    .release_en                  (release_en                  ),
    .active_release              (active_release              ),
    .hash_outbound_delete        (hash_outbound_delete        )
  );

  //update*ram
 //yfy 10.3 cpu wr inbound
 
reg          wen_d_cfg   ;
reg          ren_d_cfg   ;
reg   [9 :0] addr_d_cfg  ;
wire  [95:0] q_d         ;
wire  [9 :0] addr_d      ;
wire  [95:0] data_d      ;
wire         wren_d      ;

  assign outbound_addr = hash_outbound_maint ;
  assign wren_u = wen_d_cfg ;
  assign addr_u = outbound_ram_input[35:26]; 
  assign data_u = {3'b001,addr_d_cfg,outbound_ram_input[23:21]};
  /*
  update  update_inst 
  (
    .clk                 (clk                   ),
    .rst_n               (rst_n                 ),
    .q_u                 (q_u_u                 ),
    .delete_ip           (delete_ip             ),
    .delete_port_wan     (delete_port           ),
    .delete_session_type (delete_session_type   ),
    .addr_u              (addr_u_u              ),
    .data_u              (data_u_u              ),
    .wren_u              (wren_u_u              )
  );

  */
//outbound


always@(posedge clk or negedge rst_n) begin
    if (~rst_n)
        wen_d_cfg <= 1'b0 ;
      else if(np_cpu_addr_d1[11:10]==2'b10 && outbound_wen) //yfy 10.3
        wen_d_cfg <= 1'b1 ;
      else 
        wen_d_cfg <= 1'b0 ;
end

always@(posedge clk or negedge rst_n) begin
    if (~rst_n)
      ren_d_cfg <= 1'b0 ;
    else if(np_cpu_addr_d1[11:10]==2'b00 && outbound_ren) //yfy 10.3
      ren_d_cfg <= 1'b1 ;
    else 
      ren_d_cfg <= 1'b0;
end

always@(posedge clk or negedge rst_n) begin
    if (~rst_n)
      addr_d_cfg <= 1'b0 ;
    else if(outbound_wen)
      addr_d_cfg <= outbound_waddr ;
    else if (outbound_ren)
      addr_d_cfg <= outbound_raddr ;
    else
      addr_d_cfg <= addr_d_cfg     ;
end

reg ren_d_cfg_d1;//yfy 8.10

assign addr_d = (wen_d_cfg | ren_d_cfg) ? addr_d_cfg : addr_d_d ;    
assign data_d = wen_d_cfg ? outbound_ram_input : wren_d_d ? data_d_d : 96'b0 ;
assign wren_d = wen_d_cfg | wren_d_d ;
assign q_d_d  = (!ren_d_cfg) ? q_d : 96'b0 ;
//assign outbound_ram_output = ren_d_cfg_d1 ? q_d : 96'b0 ;
//yfy 10.3
always@(posedge clk or negedge rst_n) begin
    if (~rst_n)
      outbound_ram_output <= 96'b0 ;
    else if(ren_d_cfg_d1)
      outbound_ram_output <= q_d;
    else  
      outbound_ram_output <= outbound_ram_output;
end

//ram
`ifdef ASIC
ram_dp_d1024_w96_wrapper outbound_table
(
    .addra     (addr_a     ),
    .addrb     (addr_d     ),
    .clka      (clk        ),
    .clkb      (clk        ),
    .dina      (data_a     ),
    .dinb      (data_d     ),
    .wea       (wren_a     ),
    .web       (wren_d     ),
    .douta     (q_outbound ),
    .doutb     (q_d        ),

    .ram_dp_cfg_register (ram_dp_cfg_register)
 );

 ram_dp_d1024_w16_wrapper inbound_table
 (
   .addra     (addr_b    ),
   .addrb     (addr_u    ),
   .clka      (clk       ),
   .clkb      (clk       ),
   .dina      (data_b    ),
   .dinb      (data_u    ),
   .wea       (wren_b    ),
   .web       (wren_u    ),
   .douta     (q_inbound ),
   .doutb     (          ),

   .ram_dp_cfg_register (ram_dp_cfg_register)
 );  

`else
ram_dp_d1024_w96 outbound_table(
    .addra     (addr_a     ),
    .addrb     (addr_d     ),
    .clka      (clk        ),
    .clkb      (clk        ),
    .dina      (data_a     ),
    .dinb      (data_d     ),
    .wea       (wren_a     ),
    .web       (wren_d     ),
    .douta     (q_outbound ),
    .doutb     (q_d        )
  );
  ram_dp_d1024_w16 inbound_table(
    .addra     (addr_b    ),
    .addrb     (addr_u    ),
    .clka      (clk       ),
    .clkb      (clk       ),
    .dina      (data_b    ),
    .dinb      (data_u    ),
    .wea       (wren_b    ),
    .web       (wren_u    ),
    .douta     (q_inbound ),
    .doutb     (          )
  );
`endif


assign busy         =  ob_busy | ib_busy               ;
assign lookup_done  =  {ob_lookup_done,ib_lookup_done} ;
assign study_done   =  ob_study_done | ib_study_done   ;
assign init_end     =  init_end_i & init_end_o         ;

//************************yfy 5.24 config for NAT table

`ifndef NO_CPU_MODE
//*********input data delay
reg [18:0] np_cpu_addr_d2;
reg [18:0] np_cpu_addr_d3;
reg [18:0] np_cpu_addr_d4;//yfy 10.3
always@(posedge clk or negedge rst_n)begin
  if(~rst_n)begin
      np_cpu_addr_d1     <= 19'h0;
      np_cpu_wdata_d1     <= 32'b0;
      np_cpu_addr_d2     <= 19'h0;
      np_cpu_addr_d3     <= 19'h0;
      np_cpu_addr_d4     <= 19'h0;
  end 
  else begin
      np_cpu_addr_d1     <= np_cpu_addr    ;
      np_cpu_wdata_d1     <= np_cpu_data_in;
      np_cpu_addr_d2     <= np_cpu_addr_d1;
      np_cpu_addr_d3     <= np_cpu_addr_d2; 
      np_cpu_addr_d4     <= np_cpu_addr_d3;
  end
end



//*****************************outbound logic
//********en
always @(posedge clk or negedge rst_n) begin
  if(~rst_n)
      outbound_wen <= 1'b0;
  else if(np_cpu_ctr[1] && np_cpu_addr[18:17]==2'b01 && np_cpu_addr[16:10]>=`NAT_OUTBOUND_HEAD_BASE_ADDR && np_cpu_addr[16:10]<`NAT_OUTBOUND_TAIL_BASE_ADDR)
      outbound_wen <= 1'b1;
  else
      outbound_wen <= 1'b0;
end
always @(posedge clk or negedge rst_n) begin
  if(~rst_n)
      outbound_ren <= 1'b0;
  else if(np_cpu_ctr[0] && np_cpu_addr[18:17]==2'b01 && np_cpu_addr[16:10]>=`NAT_OUTBOUND_HEAD_BASE_ADDR && np_cpu_addr[16:10]<`NAT_OUTBOUND_TAIL_BASE_ADDR)
      outbound_ren <= 1'b1;
  else
      outbound_ren <= 1'b0;
end
//********addr
assign outbound_waddr = (outbound_wen)? np_cpu_addr_d1[9:0]:10'b0;
assign outbound_raddr = (outbound_ren)? np_cpu_addr_d1[9:0]:10'b0;
//********input
always@(posedge clk or negedge rst_n) begin
  if(rst_n == 1'b0) begin
    outbound_ram_input <= 'b0;
  end
  else if(outbound_wen)begin
      case(np_cpu_addr_d1[11:10])
        2'b00:
          outbound_ram_input <= {np_cpu_wdata_d1,64'b0};
        2'b01:
          outbound_ram_input <= {outbound_ram_input[95:64],np_cpu_wdata_d1,32'b0};
        2'b10:
          outbound_ram_input <= {outbound_ram_input[95:32],np_cpu_wdata_d1};
        default: outbound_ram_input <= 0;
      endcase     
  end
  // else
  //   outbound_ram_input <= outbound_ram_input;
end
//********output
//reg ren_d_cfg_d2 ;//yfy 10.3
reg outbound_ren_d1;//yfy 10.6
reg outbound_ren_d2;
reg outbound_ren_d3;
always@(posedge clk or negedge rst_n)begin
  if(rst_n == 1'b0) begin
    outbound_ren_d1<= 1'b0;//yfy 10.6
    outbound_ren_d2<= 1'b0;
    outbound_ren_d3<= 1'b0;
    ren_d_cfg_d1   <= 1'b0;
  end
  else begin
    outbound_ren_d1<= outbound_ren;//yfy 10.6
    outbound_ren_d2<= outbound_ren_d1;
    outbound_ren_d3<= outbound_ren_d2;
    ren_d_cfg_d1   <= ren_d_cfg;
  end
end

always@(posedge clk or negedge rst_n) begin
  if(rst_n == 1'b0) begin
    outbound_rd_data  <= 32'b0 ;
    outbound_rd_vld   <= 1'b0  ;
  end
  else if(outbound_ren_d3)begin//yfy 10.6
      case(np_cpu_addr_d4[11:10])//yfy 10.3
        2'b00:begin
          outbound_rd_data   <= outbound_ram_output[95:64];
          outbound_rd_vld    <= 1'b1;
        end
        2'b01:begin
          outbound_rd_data     <= outbound_ram_output[63:32];
          outbound_rd_vld      <= 1'b1;
        end
        2'b10:begin
          outbound_rd_data     <= outbound_ram_output[31:0];
          outbound_rd_vld      <= 1'b1;
        end
        default:begin 
          outbound_rd_data    <= outbound_rd_data;
          outbound_rd_vld     <= 1'b0;
        end
      endcase 
    end
  else begin
    outbound_rd_data      <= outbound_rd_data;
    outbound_rd_vld       <= 1'b0;
  end
end
`ifdef DEBUG
ila_nat_cfg  inst_ila_nat_cfg
(
	.clk(clk),
	.probe0 (outbound_wen),
	.probe1 (outbound_ren),
	.probe2 (ren_d_cfg),
	.probe3 (addr_d_cfg),
	.probe4 (outbound_rd_vld),
	.probe5 (outbound_rd_data),
	.probe6 (outbound_ram_output[95:64]),
	.probe7 (outbound_ram_output[63:32]),
	.probe8 (outbound_ram_output[31:0])
);
`endif

`endif

//***reg wr en 
reg CPU_reg_rden;
reg CPU_reg_wren;
always @(posedge clk or negedge rst_n) begin
    if(~rst_n)
        CPU_reg_wren <= 1'b0;
    else if(np_cpu_ctr[1])
        CPU_reg_wren <= !(|np_cpu_addr[18:10]);
    else
        CPU_reg_wren <= 1'b0;
end
//***reg rd en 
always @(posedge clk or negedge rst_n) begin
    if(~rst_n)
        CPU_reg_rden <= 1'b0;
    else if(np_cpu_ctr[0])
        CPU_reg_rden <= !(|np_cpu_addr[18:10]);
    else 
        CPU_reg_rden <= 1'b0;
end

//nat cd time 
always @(posedge clk or negedge rst_n) begin
    if(~rst_n)
        cpu_cd_time <= 17'b0;
    else if(CPU_reg_wren && np_cpu_addr_d1[8:0]==`ADDR_NAT_COVER_CD_TIME)
        cpu_cd_time <= np_cpu_wdata_d1[16:0];
    else
        cpu_cd_time <= cpu_cd_time;
end


reg [31:0]reg_rd_data;
reg CPU_reg_rd_vld;
always@(posedge clk or negedge rst_n) begin
    if(~rst_n)begin
        reg_rd_data <= 32'h0;
        CPU_reg_rd_vld <= 1'b0;
    end else if (CPU_reg_rden) begin
        case(np_cpu_addr_d1[8:0])
            `ADDR_NAT_COVER_CD_TIME:begin
                reg_rd_data    <=  {15'h0,cpu_cd_time};
                CPU_reg_rd_vld <=  1'b1;
                end
			default:begin
					reg_rd_data    <= reg_rd_data;
					CPU_reg_rd_vld <= 1'b0;
					end
			endcase
		end else begin
			reg_rd_data    <= reg_rd_data;
			CPU_reg_rd_vld <= 1'b0;
		end
	end

//*********************output****************//
	always@(posedge clk or negedge rst_n)begin
		if(~rst_n)
			np_cpu_data_out <= 32'b0;
		else if(outbound_rd_vld)
			np_cpu_data_out <= outbound_rd_data;
		else if(CPU_reg_rd_vld)
			np_cpu_data_out <= reg_rd_data;
		else
			np_cpu_data_out <= np_cpu_data_out;
	  end
	  always@(posedge clk or negedge rst_n)begin
		if(~rst_n)
			data_out_vld <= 1'b0;
		else if(outbound_rd_vld)
			data_out_vld <= 1'b1; 
		else if(CPU_reg_rd_vld)
			data_out_vld <= 1'b1;
		else
			data_out_vld <= 1'b0;
	  end



`ifdef DEBUG

reg   [31:0] distribute_cnt   ;
reg   [31:0] otb_look_suc_cnt ;
reg   [31:0] otb_cover_cnt    ;
reg   [31:0] ib_look_suc_cnt  ;
reg   [31:0] ib_look_fail_cnt ;

always@(posedge clk or negedge rst_n)begin
	if(~rst_n)
	    distribute_cnt <= 32'b0;
	else if(ob_lookup_done && !(look_incorrect || outwan_port_en))
		distribute_cnt <= distribute_cnt + 1'b1 ; 
	else
		distribute_cnt <= distribute_cnt ;
  end

always@(posedge clk or negedge rst_n)begin
	if(~rst_n)
	    otb_look_suc_cnt <= 32'b0;
	else if(ob_lookup_done && outwan_port_en)
		otb_look_suc_cnt <= otb_look_suc_cnt + 1'b1 ; 
	else
		otb_look_suc_cnt <= otb_look_suc_cnt ;
  end 
  
always@(posedge clk or negedge rst_n)begin
	if(~rst_n)
	    otb_cover_cnt <= 32'b0;
	else if(ob_lookup_done && look_incorrect)
		otb_cover_cnt <= otb_cover_cnt + 1'b1 ; 
	else
		otb_cover_cnt <= otb_cover_cnt ;
  end 

always@(posedge clk or negedge rst_n)begin
	if(~rst_n)
	    ib_look_suc_cnt <= 32'b0;
	else if(ib_lookup_done && out_result_en)
		ib_look_suc_cnt <= ib_look_suc_cnt + 1'b1 ; 
	else
		ib_look_suc_cnt <= ib_look_suc_cnt ;
  end 

always@(posedge clk or negedge rst_n)begin
	if(~rst_n)
	ib_look_fail_cnt <= 32'b0;
	else if(ib_lookup_done && !out_result_en)
		ib_look_fail_cnt <= ib_look_fail_cnt + 1'b1 ; 
	else
		ib_look_fail_cnt <= ib_look_fail_cnt ;
  end  

ila_nat_lookup_result  inst_ila_nat_lookup_result
(
	.clk (clk),
    .probe0 (ob_lookup_done ),
	.probe1 (look_incorrect ),
	.probe2 (outwan_port_en ),
	.probe3 (ib_lookup_done ),
	.probe4 (out_result_en  ),
	.probe5 (distribute_cnt ),
	.probe6 (otb_look_suc_cnt ),
	.probe7 (otb_cover_cnt    ),
	.probe8 (ib_look_suc_cnt  ),
	.probe9 (ib_look_fail_cnt )
	
);

`endif 

endmodule

