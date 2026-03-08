module manager
(
    input  wire                  rst_n             ,      
    input  wire                  clk               , 
    input  wire  [ 6  : 0 ]      rf_2p_cfg_register,
    
    input  wire  [15  : 0 ]      port_avail        , 
    output wire                  port_use_ack      , 
    output reg   [15  : 0 ]      port_rec          , 
    output reg                   port_rec_vld      ,

    input  wire  [ 31 : 0 ]      IP_lan            ,  // lan IP
    input  wire  [ 15 : 0 ]      port_lan          , 
    input  wire  [ 2  : 0 ]      port_type_lan     ,  // lan port type, TCP or UDP or ID
    input  wire                  otb_search_suc    ,  // outbound table search succuss
    input  wire                  otb_search_fail   ,
    input  wire  [ 15 : 0 ]      port_sear_wan     ,  // wan port that was found
    input  wire                  outb_cover_en     , 
    input  wire                  lan_vld           ,  // intranet reflection valid                
    input  wire  [ 2  : 0 ]      TCP_lan_flag      ,  //  RST, SYN and FIN in TCP from lan to wan     
    input  wire                  outbound_ack      ,           
    input  wire                  outbound_drop     ,          
    output wire  [ 15 : 0 ]      port_lan_NAT      ,  // NAT port for lan, is port of wan    
    output wire                  otb_fifo_empty    ,  

    input  wire  [ 15 : 0 ]      port_wan          ,  // wan port    
    input  wire  [ 2  : 0 ]      port_type_wan     ,    
    input  wire                  wan_vld           ,  // upper network reflection valid  
    input  wire  [ 2  : 0 ]      TCP_wan_flag      ,  // RST, SYN and FIN in TCP from wan to lan
    input  wire                  inbound_ack       ,     
    input  wire                  inbound_drop      ,
    input  wire                  ib_search_suc     ,  // inbound table search success
    input  wire                  ib_search_fail    ,  // inbound table search fail
    input  wire  [ 31 : 0 ]      IP_sear_lan       ,  // lan IP that was found
    input  wire  [ 15 : 0 ]      port_sear_lan     ,  // lan port that was found
    input  wire                  ib_cover_en       ,
    output wire  [ 31 : 0 ]      IP_wan_NAT        ,  // NAT IP for wan, is IP of lan        
    output wire  [ 15 : 0 ]      port_wan_NAT      ,  // NAT port for wan, is port of lan
    output wire                  inbound_fail      ,
    output wire                  ib_fifo_empty     ,

    output reg   [ 31 : 0 ]      IP_maint          ,  // IP to study
    output reg   [ 15 : 0 ]      port_lan_maint    ,  // lan port to study
    output reg   [ 15 : 0 ]      port_wan_maint    ,  // wan port to study
    output reg   [ 2  : 0 ]      port_type_maint   ,   
    output reg                   maint_vld         ,   
    output reg                   maint_release     ,  // when receive TCP RST, need to release this reflection
    output reg   [ 1  : 0 ]      tcp_fin           ,
    output reg   [ 1  : 0 ]      tcp_syn           ,    
    output wire                  prog_full         , 
    output reg   [ 31 : 0 ]      IP_maint_rel      ,  // when maint_release high, need to release IP  
    output reg   [ 15 : 0 ]      port_lan_maint_rel,  // when maint_release high, need to release port
    output reg   [ 15 : 0 ]      port_wan_maint_rel,  // when maint_release high, need to release port
    output reg   [ 2  : 0 ]      port_type_mt_rel  ,  // when maint_release high, need to release port type
    input  wire  [ 15 : 0 ]      port_release      ,  
    //input  wire  [ 2  : 0 ]      port_type_release ,
    input  wire                  release_vld          
);
///////////////////////////change by 20240508 for pipeline////////////////
//////////////bound pipeline//////////////////////////////////////////
wire  [16 :0] otbport_to_fifo  ;  
wire  [47 :0] ibIPport_to_fifo ;
wire  [53 :0] otbmaint_to_fifo ;
wire  [21 :0] ibmaint_to_fifo  ;  
wire  [16 :0] otbport_fifo_o   ;
wire  [47 :0] ibIPport_fifo_o  ;
wire  [53 :0] otbmaint_fifo_o  ;
wire  [21 :0] ibmaint_fifo_o   ;

assign otbport_to_fifo  = otb_search_suc ? {1'b0,port_sear_wan} : 
                          otb_search_fail ? {1'b1,port_avail} : 17'b0 ;
assign ibIPport_to_fifo = ib_search_suc ? {IP_sear_lan,port_sear_lan} : 48'b0 ;
assign otbmaint_to_fifo = lan_vld ? {TCP_lan_flag,IP_lan,port_lan,port_type_lan} :54'b0 ;
assign ibmaint_to_fifo  = wan_vld ? {TCP_wan_flag,port_wan, port_type_wan} : 22'b0 ;
assign port_use_ack     = otb_search_fail ;


reg  cover_fifo_in ;
wire cantcover_en ;
reg  [2 :0] port_type_rec ;
reg  fifo_cover_wren ;
wire fifo_cover_rden ;
assign fifo_cover_rden = outbound_ack||outbound_drop || inbound_ack || inbound_drop ;   
always @(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
        cover_fifo_in   <= 1'b0 ;
        fifo_cover_wren <= 1'b0 ;
	end
    else if(otb_search_suc || otb_search_fail) begin
        cover_fifo_in   <=  outb_cover_en ;
		fifo_cover_wren <= 1'b1 ;
	end
    else if(ib_search_suc || ib_search_fail) begin
        cover_fifo_in <= ib_cover_en ;
		fifo_cover_wren <= 1'b1 ;
	end
    else begin
        cover_fifo_in <= cover_fifo_in ;
		fifo_cover_wren <= 1'b0 ;
	end
end

fifo_wxx_dxx_s #(
    .PTR(5),
    .WORDS(32),
    .W_SIZE(1),
    .A_FULL(31)
) inst_cover_fifo (
    .clock         (clk              ),
    .rst_n         (rst_n            ),
    .fifo_wen      (fifo_cover_wren  ),
    .fifo_wdata    (cover_fifo_in    ),
    .fifo_ren      (fifo_cover_rden  ),
    .fifo_rdata    (cantcover_en     ),
    .fifo_empty_rd (                 ),
    .almost_full   (                 )
);
///////////////////maint///////////////////
always @(posedge clk or negedge rst_n) begin
    if(~rst_n)
        maint_vld <= 1'b0 ;
    else if(((outbound_ack && !otbmaint_fifo_o[53])||(!ibmaint_fifo_o[21] && inbound_ack && !inbound_fail)) && !cantcover_en)
        maint_vld <= 1'b1 ;
    else
        maint_vld <= 1'b0 ;
end

always @(posedge clk or negedge rst_n) begin
    if(~rst_n)
        IP_maint <= 32'b0 ;
    else if(outbound_ack)
        IP_maint <= otbmaint_fifo_o[50 : 19] ;
    else if(inbound_ack)
        IP_maint <= ibIPport_fifo_o[47 : 16] ;
    else
        IP_maint <= IP_maint ;
end

always @ (posedge clk or negedge rst_n) begin
    if(~rst_n)
        port_lan_maint <= 16'b0 ;
    else if(outbound_ack)
        port_lan_maint <= otbmaint_fifo_o[18 : 3] ;
    else if(inbound_ack)
        port_lan_maint <= ibIPport_fifo_o[15 : 0] ;
    else
        port_lan_maint <= port_lan_maint ;
end

always @ (posedge clk or negedge rst_n) begin
    if(~rst_n)
        port_wan_maint <= 16'b0 ;
    else if(outbound_ack)
        port_wan_maint <= otbport_fifo_o[15 : 0] ;
    else if(inbound_ack)
        port_wan_maint <= ibmaint_fifo_o[18 : 3] ;
    else
        port_wan_maint <= port_wan_maint ;
end

always @ (posedge clk or negedge rst_n) begin
    if(~rst_n)
        port_type_maint <= 3'b0 ;
    else if(outbound_ack)
        port_type_maint <= otbmaint_fifo_o[2 : 0] ;
    else if(inbound_ack)
        port_type_maint <= ibmaint_fifo_o[2 : 0] ;
    else
        port_type_maint <= port_type_maint ;
end

always @ (posedge clk or negedge rst_n) begin
    if(~rst_n) begin
        tcp_fin <= 2'b0 ;
        tcp_syn <= 2'b0 ;
      end
      else if(outbound_ack  && !otbmaint_fifo_o[53]) begin
        tcp_fin[1] <= otbmaint_fifo_o[51] ;
        tcp_syn[1] <= otbmaint_fifo_o[52] ;
      end
      else if(inbound_ack && !ibmaint_fifo_o[21]) begin
        tcp_fin[0] <= ibmaint_fifo_o[19] ;
        tcp_syn[0] <= ibmaint_fifo_o[20] ;
      end
      else begin
        tcp_fin <= tcp_fin ;
        tcp_syn <= tcp_syn ;
      end
end

/////////////////////////////release/////////////////
always @ (posedge clk or negedge rst_n) begin
    if(~rst_n)
        maint_release <= 1'b0 ;
    else if(!cantcover_en && ((outbound_ack && otbmaint_fifo_o[53])||(inbound_ack && ibmaint_fifo_o[21])))
        maint_release <= 1'b1 ;
    else
        maint_release <= 1'b0 ;
end

always @ (posedge clk or negedge rst_n) begin
    if(~rst_n)
        IP_maint_rel <= 32'b0 ;
    else if(outbound_ack && otbmaint_fifo_o[53])
        IP_maint_rel <= otbmaint_fifo_o[50 : 19] ;
    else if(inbound_ack && ibmaint_fifo_o[21])
        IP_maint_rel <= ibIPport_fifo_o[47 : 16] ;
    else
        IP_maint_rel <= IP_maint_rel ;
end

always @ (posedge clk or negedge rst_n) begin
    if(~rst_n)
        port_lan_maint_rel <= 16'b0 ;
    else if(outbound_ack && otbmaint_fifo_o[53])
        port_lan_maint_rel <= otbmaint_fifo_o[18 : 3] ;
    else if(inbound_ack && ibmaint_fifo_o[21])
        port_lan_maint_rel <= ibIPport_fifo_o[15 : 0] ;
    else
        port_lan_maint_rel <= port_lan_maint_rel ;
end

always @ (posedge clk or negedge rst_n) begin
    if(~rst_n)
        port_wan_maint_rel <= 16'b0 ;
    else if(outbound_ack && otbmaint_fifo_o[53])
        port_wan_maint_rel <= otbport_fifo_o[15 : 0] ;
    else if(inbound_ack && ibmaint_fifo_o[21])
        port_wan_maint_rel <= ibmaint_fifo_o[18 : 3] ;
    else
        port_wan_maint_rel <= port_wan_maint_rel ;
end

always @ (posedge clk or negedge rst_n) begin
    if(~rst_n)
        port_type_mt_rel <= 3'b0 ;
    else if(outbound_ack && otbmaint_fifo_o[53])
        port_type_mt_rel <= otbmaint_fifo_o[2 : 0] ;
    else if(inbound_ack && ibmaint_fifo_o[21])
        port_type_mt_rel <= ibmaint_fifo_o[2 : 0] ;
    else
        port_type_mt_rel <= port_type_mt_rel ;
end
/////////////////////////rec//////////////////////////
reg conflict_vld ;
reg [15 : 0] rec_conf_port ;
reg [ 2 : 0] rec_conf_port_type ;

always @(posedge clk or negedge rst_n) begin
    if(~rst_n)
        conflict_vld <= 1'b0 ;
    else if(((outbound_drop && otbport_fifo_o[16]) || maint_release)&& release_vld)
        conflict_vld <= 1'b1 ;
    else
        conflict_vld <= 1'b0 ;
end

always @(posedge clk or negedge rst_n) begin
   if(~rst_n)
       rec_conf_port <= 16'b0 ;
   else if(((outbound_drop && otbport_fifo_o[16]) || maint_release) && release_vld)
       rec_conf_port <= port_release ;
     else 
       rec_conf_port <= 16'b0 ;
end

always @(posedge clk or negedge rst_n) begin
    if(~rst_n)
        rec_conf_port_type <= 3'b0 ;
    else if(((outbound_drop && otbport_fifo_o[16]) || maint_release) && release_vld)
        rec_conf_port_type <= 3'b0;//port_type_release ;
        else 
        rec_conf_port_type <= 3'b0 ;
end

always @(posedge clk or negedge rst_n) begin
    if(~rst_n)
        port_rec_vld <= 1'b0 ;
    else if((outbound_drop && otbport_fifo_o[16]) || release_vld || conflict_vld || maint_release)
        port_rec_vld <= 1'b1 ;
    else
        port_rec_vld <= 1'b0 ;
end

always @(posedge clk or negedge rst_n) begin
   if(~rst_n)
       port_rec <= 16'b0 ;
   else if(conflict_vld)
       port_rec <= rec_conf_port ;
   else if(outbound_drop && otbport_fifo_o[16])
       port_rec <= otbport_fifo_o[15 : 0] ;
   else if(maint_release)
       port_rec <= port_wan_maint_rel ;
   else if(release_vld)
       port_rec <= port_release ;
        else 
       port_rec <= 16'b0 ;
end

always @(posedge clk or negedge rst_n) begin
    if(~rst_n)
        port_type_rec <= 3'b0 ;
    else if(conflict_vld)
        port_type_rec <= rec_conf_port_type ;
    else if(outbound_drop && otbport_fifo_o[16])   
        port_type_rec <= otbmaint_fifo_o[2 : 0] ;
    else if(maint_release)
        port_type_rec <= port_type_mt_rel ;
    else if(release_vld)
        port_type_rec <= 3'b0;//port_type_release ;
        else 
        port_type_rec <= 3'b0 ;
end
//////////////////////////////////////////////////////////////////
wire otb_fifo_wen ;
wire otb_fifo_ren ;
//wire otb_fifo_empty ;
wire ib_fifo_wen ;
wire ib_fifo_ren ;
//wire ib_fifo_empty ;
wire otb_maint_fifo_wen ;
wire otb_maint_fifo_ren ;
wire ibmaint_fifo_wen  ;
wire ibmaint_fifo_ren  ;


assign otb_fifo_wen = otb_search_suc||otb_search_fail ;
assign otb_fifo_ren = outbound_ack||outbound_drop     ; 
assign ib_fifo_wen  = ib_search_suc||ib_search_fail   ;
assign ib_fifo_ren  = inbound_ack||inbound_drop       ;
assign otb_maint_fifo_wen = lan_vld ;
assign otb_maint_fifo_ren = outbound_ack||outbound_drop ;
assign ibmaint_fifo_wen   = wan_vld ;
assign ibmaint_fifo_ren   = inbound_drop||inbound_ack ; 

assign port_lan_NAT = otbport_fifo_o[15 :  0]   ;
assign port_wan_NAT = ibIPport_fifo_o[15 :  0]  ;
assign IP_wan_NAT   = ibIPport_fifo_o[47 : 16]  ;
//assign inbound_fail = (inbound_ack && (ibIPport_fifo_o == 48'b0)) ;
assign inbound_fail = ib_fifo_empty ? 1'b0 : (ibIPport_fifo_o == 48'b0);
`ifdef ASIC
FIFO_w17_d128_fwft inst_FIFO_W17_D128_fwft
(
   .clk                (clk               ) ,                 
   .clr                (rst_n             ) ,               
   .rf_2p_cfg_register (rf_2p_cfg_register) ,
   .w_data             (otbport_to_fifo   ) ,
   .w_we               (otb_fifo_wen      ) ,        
   .w_full             (                  ) ,
   .w_afull            (                  ) ,        
   .r_data             (otbport_fifo_o    ) ,      
   .r_re               (otb_fifo_ren      ) ,
   .r_empty            (otb_fifo_empty    )
 );

FIFO_w48_d128_fwft inst_FIFO_W48_D128_fwft
(
   .clk                (clk               ) ,                 
   .clr                (rst_n             ) ,               
   .rf_2p_cfg_register (rf_2p_cfg_register) ,
   .w_data             (ibIPport_to_fifo  ) ,
   .w_we               (ib_fifo_wen       ) ,        
   .w_full             (                  ) ,
   .w_afull            (                  ) ,        
   .r_data             (ibIPport_fifo_o   ) ,      
   .r_re               (ib_fifo_ren       ) ,
   .r_empty            (ib_fifo_empty     )
 );

FIFO_w54_d128_fwft inst_FIFO_W54_D128_fwft
(
   .clk                (clk               ) ,                 
   .clr                (rst_n             ) ,               
   .rf_2p_cfg_register (rf_2p_cfg_register) ,
   .w_data             (otbmaint_to_fifo  ) ,
   .w_we               (otb_maint_fifo_wen) ,        
   .w_full             (                  ) ,
   .w_afull            (                  ) ,        
   .r_data             (otbmaint_fifo_o   ) ,      
   .r_re               (otb_maint_fifo_ren) ,
   .r_empty            (                  )
 );

FIFO_w22_d128_fwft inst_FIFO_W22_D128_fwft
(
   .clk                (clk               ) ,                 
   .clr                (rst_n             ) ,               
   .rf_2p_cfg_register (rf_2p_cfg_register) ,
   .w_data             (ibmaint_to_fifo   ) ,
   .w_we               (ibmaint_fifo_wen  ) ,        
   .w_full             (                  ) ,
   .w_afull            (                  ) ,        
   .r_data             (ibmaint_fifo_o    ) ,      
   .r_re               (ibmaint_fifo_ren ) ,
   .r_empty            (                  )
 );
 `else

FIFO_w17_d128_fwft FIFO_w17_d128_fwft_fpga 
(
  .clk           (clk              ),        
  .rst           (~rst_n           ),        
  .din           (otbport_to_fifo  ),       
  .wr_en         (otb_fifo_wen     ),                    
  .rd_en         (otb_fifo_ren     ),                    
  .dout          (otbport_fifo_o   ),    
  .full          (                 ),                     
  .empty         (otb_fifo_empty   ),                    
  .prog_full     (                 ),                
  .wr_rst_busy   (                 ), 
  .rd_rst_busy   (                 )  
);

FIFO_w48_d128_fwft FIFO_w48_d128_fwft_fpga 
(
  .clk           (clk              ),        
  .rst           (~rst_n           ),        
  .din           (ibIPport_to_fifo ),       
  .wr_en         (ib_fifo_wen      ),                    
  .rd_en         (ib_fifo_ren      ),                    
  .dout          (ibIPport_fifo_o  ),    
  .full          (                 ),                     
  .empty         (ib_fifo_empty    ),                    
  .prog_full     (                 ),                
  .wr_rst_busy   (                 ), 
  .rd_rst_busy   (                 )  
);

FIFO_w54_d128_fwft FIFO_w54_d128_fwft_fpga 
(
  .clk           (clk                 ),        
  .rst           (~rst_n              ),        
  .din           (otbmaint_to_fifo    ),       
  .wr_en         (otb_maint_fifo_wen  ),                    
  .rd_en         (otb_maint_fifo_ren  ),                    
  .dout          (otbmaint_fifo_o     ),    
  .full          (                    ),                     
  .empty         (                    ),                    
  .prog_full     (                    ),                
  .wr_rst_busy   (                    ), 
  .rd_rst_busy   (                    )  
);

FIFO_w22_d128_fwft FIFO_w22_d128_fwft_fpga 
(
  .clk           (clk                 ),        
  .rst           (~rst_n              ),        
  .din           (ibmaint_to_fifo     ),       
  .wr_en         (ibmaint_fifo_wen    ),                    
  .rd_en         (ibmaint_fifo_ren    ),                    
  .dout          (ibmaint_fifo_o      ),    
  .full          (                    ),                     
  .empty         (                    ),                    
  .prog_full     (                    ),                
  .wr_rst_busy   (                    ), 
  .rd_rst_busy   (                    )  
);
`endif
//nat_port_info_fifo_d128_w17 inst_nat_port_info_fifo_d128_w17
//(          
//    .clk                 (clk                 ) ,
//    .rst_n               (rst_n               ) ,
//    .rf_2p_cfg_register  (rf_2p_cfg_register  ) ,
//    .fifo_wen            (otb_fifo_wen        ) ,
//    .fifo_wdata          (otbport_to_fifo     ) ,
//    .fifo_ren            (otb_fifo_ren        ) ,
//    .fifo_rdata          (otbport_fifo_o      ) ,
//    .fifo_full_wr        (                    ) ,
//    .fifo_empty_rd       (otb_fifo_empty      ) ,
//    .almost_full         (                    ) 
//);
//
//nat_port_info_fifo_d128_w48 inst_nat_port_info_fifo_d128_w48
//(
//    .clk                 (clk                 ) ,
//    .rst_n               (rst_n               ) ,
//    .rf_2p_cfg_register  (rf_2p_cfg_register  ) ,
//    .fifo_wen            (ib_fifo_wen         ) ,
//    .fifo_wdata          (ibIPport_to_fifo    ) ,
//    .fifo_ren            (ib_fifo_ren         ) ,
//    .fifo_rdata          (ibIPport_fifo_o     ) ,
//    .fifo_full_wr        (                    ) ,
//    .fifo_empty_rd       (ib_fifo_empty       ) ,
//    .almost_full         (                    ) 
//);
//
//nat_port_info_fifo_d128_w54 inst_nat_port_info_fifo_d128_w54
//(
//    .clk                 (clk                 ) ,
//    .rst_n               (rst_n               ) ,
//    .rf_2p_cfg_register  (rf_2p_cfg_register  ) ,
//    .fifo_wen            (otb_maint_fifo_wen  ) ,
//    .fifo_wdata          (otbmaint_to_fifo    ) ,
//    .fifo_ren            (otb_maint_fifo_ren  ) ,
//    .fifo_rdata          (otbmaint_fifo_o     ) ,
//    .fifo_full_wr        (                    ) ,
//    .fifo_empty_rd       (                    ) ,
//    .almost_full         (                    ) 
//);
//
//nat_port_info_fifo_d128_w22 inst_nat_port_info_fifo_d128_w22
//(
//    .clk                 (clk                 ) ,
//    .rst_n               (rst_n               ) ,
//    .rf_2p_cfg_register  (rf_2p_cfg_register  ) ,
//    .fifo_wen            (ibmaint_fifo_wen   ) ,
//    .fifo_wdata          (ibmaint_to_fifo     ) ,
//    .fifo_ren            (ibmaint_fifo_ren    ) ,
//    .fifo_rdata          (ibmaint_fifo_o      ) ,
//    .fifo_full_wr        (                    ) ,
//    .fifo_empty_rd       (                    ) ,
//    .almost_full         (                    ) 
//);
/////////////////////////change ////////////////////////////////////////
//parameter IDLE                          = 7'b0000001 ;                  
//parameter APPLY                         = 7'b0000010 ;
//parameter ADD_ITEM                      = 7'b0000100 ;
//parameter LKUP_SUC                      = 7'b0001000 ;
//parameter LKUP_SUC_EXEC                 = 7'b0010000 ;
//parameter TCP_RST                       = 7'b0100000 ;
//parameter TCP_FIN                       = 7'b1000000 ;
//
//reg  [ 6 : 0 ]  outbound_cstate  ;
//reg  [ 6 : 0 ]  outbound_nstate  ;
//reg  [ 6 : 0 ]  inbound_cstate   ;
//reg  [ 6 : 0 ]  inbound_nstate   ;
//reg             port_ack_en      ;
//reg  [15 : 0 ]  port_use_nuncnt  ;
//reg             port_ack_high    ;
//reg             port_ack_high_ff ;
//wire            release_done     ;
//reg  [ 2 : 0 ]  lan_vld_r_cnt    ;
//reg  [ 2 : 0 ]  wan_vld_r_cnt    ;
//wire            lan_vld_r        ;
//wire            wan_vld_r        ;
//
//assign lan_vld_r = (!lan_vld_r_cnt) ? 1'b0 : 1'b1 ;
//assign wan_vld_r = (!wan_vld_r_cnt) ? 1'b0 : 1'b1 ;
//
//always @ (posedge clk or negedge rst_n)begin
//    if(!rst_n)
//        lan_vld_r_cnt   <=  3'b000 ;
//    else if (lan_vld)
//        lan_vld_r_cnt   <=  3'b001 ;
//    else if (lan_vld_r_cnt == 3'd4 )
//        lan_vld_r_cnt   <=  3'b000 ;    
//    .clk                 (clk                 ) ,
//    .rst_n               (rst_n               ) ,
//    .rf_2p_cfg_register  (rf_2p_cfg_register  ) ,
//    .fifo_wen            (otb_maint_fifo_wen  ) ,
//    .fifo_wdata          (otbmaint_to_fifo    ) ,
//    .fifo_ren            (otb_maint_fifo_ren  ) ,
//    .fifo_rdata          (otbmaint_fifo_o     ) ,
//    .fifo_full_wr        (                    ) ,
//    .fifo_empty_rd       (                    ) ,
//    .almost_full         (                    ) 
//);
//
//nat_port_info_fifo_d128_w22 inst_nat_port_info_fifo_d128_w22
//(
//    .clk                 (clk                 ) ,
//    .rst_n               (rst_n               ) ,
//    .rf_2p_cfg_register  (rf_2p_cfg_register  ) ,
//    .fifo_wen            (ibmaint_fifo_wen   ) ,
//    .fifo_wdata          (ibmaint_to_fifo     ) ,
//    .fifo_ren            (ibmaint_fifo_ren    ) ,
//    .fifo_rdata          (ibmaint_fifo_o      ) ,
//    .fifo_full_wr        (                    ) ,
//    .fifo_empty_rd       (                    ) ,
//    .almost_full         (                    ) 
//);
/////////////////////////change ////////////////////////////////////////
//parameter IDLE                          = 7'b0000001 ;                  
//parameter APPLY                         = 7'b0000010 ;
//parameter ADD_ITEM                      = 7'b0000100 ;
//parameter LKUP_SUC                      = 7'b0001000 ;
//parameter LKUP_SUC_EXEC                 = 7'b0010000 ;
//parameter TCP_RST                       = 7'b0100000 ;
//parameter TCP_FIN                       = 7'b1000000 ;
//
//reg  [ 6 : 0 ]  outbound_cstate  ;
//reg  [ 6 : 0 ]  outbound_nstate  ;
//reg  [ 6 : 0 ]  inbound_cstate   ;
//reg  [ 6 : 0 ]  inbound_nstate   ;
//reg             port_ack_en      ;
//reg  [15 : 0 ]  port_use_nuncnt  ;
//reg             port_ack_high    ;
//reg             port_ack_high_ff ;
//wire            release_done     ;
//reg  [ 2 : 0 ]  lan_vld_r_cnt    ;
//reg  [ 2 : 0 ]  wan_vld_r_cnt    ;
//wire            lan_vld_r        ;
//wire            wan_vld_r        ;
//
//assign lan_vld_r = (!lan_vld_r_cnt) ? 1'b0 : 1'b1 ;
//assign wan_vld_r = (!wan_vld_r_cnt) ? 1'b0 : 1'b1 ;
//
//always @ (posedge clk or negedge rst_n)begin
//    if(!rst_n)
//        lan_vld_r_cnt   <=  3'b000 ;
//    else if (lan_vld)
//        lan_vld_r_cnt   <=  3'b001 ;
//    else if (lan_vld_r_cnt == 3'd4 )
//        lan_vld_r_cnt   <=  3'b000 ;    
//    else if (lan_vld_r_cnt != 3'b000)
//        lan_vld_r_cnt   <=  lan_vld_r_cnt + 1 ;
//        else
//        lan_vld_r_cnt   <= lan_vld_r_cnt  ;
//end
//
//always @ (posedge clk or negedge rst_n)begin
//    if(!rst_n)
//        wan_vld_r_cnt   <=  3'b000 ;
//    else if (wan_vld)
//        wan_vld_r_cnt   <=  3'b001 ;
//    else if (wan_vld_r_cnt == 3'd4 )
//        wan_vld_r_cnt   <=  3'b000 ;    
//    else if (wan_vld_r_cnt != 3'b000)
//        wan_vld_r_cnt   <=  wan_vld_r_cnt + 1 ;
//        else
//        wan_vld_r_cnt   <= wan_vld_r_cnt  ;
//end
//
/////////////outbound FSM//////////////////////////////////
//always @( posedge clk or negedge rst_n ) begin
//    if(!rst_n)
//        outbound_cstate <=  IDLE ;
//    else
//        outbound_cstate <=  outbound_nstate ;
//end
//
//always @ (*) begin
//    if(!rst_n)
//        outbound_nstate <= IDLE ; 
//    else 
//        case(outbound_cstate)
//
//        IDLE : 
//            if(lan_vld_r && otb_search_fail && !(TCP_lan_flag_vld && TCP_lan_flag[2])) 
//                outbound_nstate <= APPLY ;
//            else if(lan_vld_r && otb_search_suc)
//                outbound_nstate <= LKUP_SUC ;
//            else 
//                outbound_nstate <= IDLE ;
//      
//        APPLY :
//            if(outbound_ack)
//                outbound_nstate <= ADD_ITEM ;
//            else if(outbound_drop)
//                outbound_nstate <= IDLE ;
//            else 
//                outbound_nstate <= APPLY ;
//      
//        ADD_ITEM :
//            if (maint_done)
//                outbound_nstate <= IDLE ;
//            else
//                outbound_nstate <= ADD_ITEM ;
//      
//        LKUP_SUC :
//            if(outbound_drop)
//                outbound_nstate <= IDLE ;
//            else if(outbound_ack && !(TCP_lan_flag_vld && (TCP_lan_flag[2] || TCP_lan_flag[0])))
//                outbound_nstate <= LKUP_SUC_EXEC ;
//            else if(outbound_ack && TCP_lan_flag_vld && TCP_lan_flag[2] )
//                outbound_nstate <= TCP_RST ;
//            //else if(outbound_ack && TCP_lan_flag_vld && TCP_lan_flag[0] )
//            //    outbound_nstate <= TCP_FIN ;
//            else 
//                outbound_nstate <= LKUP_SUC ;
//      
//        LKUP_SUC_EXEC :
//            if(maint_done)
//                outbound_nstate <= IDLE ;
//            else
//                outbound_nstate <= LKUP_SUC_EXEC ;
//      
//        TCP_RST :
//            if(release_done)////////////////////
//                outbound_nstate <= IDLE ;
//            else
//                outbound_nstate <= TCP_RST ;
//      
//        // TCP_FIN :
//        //     if(tcp_fin)
//        //         outbound_nstate <= IDLE ;
//        //     else
//        //         outbound_nstate <= TCP_FIN ;
//    
//      default :
//                outbound_nstate <= IDLE ;
//    endcase
//end
//
//assign port_use_ack = outbound_cstate == APPLY ;
//assign maint_vld    = (outbound_cstate == ADD_ITEM || outbound_cstate == LKUP_SUC_EXEC || inbound_cstate == LKUP_SUC_EXEC) ; 
//assign tcp_fin_vld  = (outbound_cstate == TCP_FIN || inbound_cstate == TCP_FIN) ;
//assign release_done = port_rec_vld ;
//assign port_rec_vld = release_vld ;

//always@(posedge clk or negedge rst_n) begin
//    if(!rst_n)
//        port_use_ack <= 1'b0 ;
//    else if (outbound_cstate == IDLE && outbound_nstate==APPLY) 
//        port_use_ack <= 1'b1 ;
//    else
//         port_use_ack <= 1'b0 ;
//end
//
//always@(posedge clk or negedge rst_n) begin
//    if(!rst_n)
//        maint_vld <= 1'b0 ;
//    else if (outbound_ack || inbound_ack)
//        maint_vld <= 1'b1 ;
//    else
//        maint_vld <= 1'b0 ;
//end
//
//always@(posedge clk or negedge rst_n) begin
//    if(!rst_n)
//        lan_NAT_vld <= 1'b0 ;
//    else if (port_use_ack || otb_search_suc)
//        lan_NAT_vld <= 1'b1 ;
//    else
//        lan_NAT_vld <= 1'b0 ;
//end
//
//always@(posedge clk or negedge rst_n) begin
//    if(!rst_n)
//         port_lan_NAT <= 16'h0000 ;
//    else if (port_use_ack)
//         port_lan_NAT <= port_avail ;
//    else if (otb_search_suc)
//         port_lan_NAT <= port_sear_wan ;
//    else
//         port_lan_NAT <= port_lan_NAT ;
//end
//
//always@(posedge clk or negedge rst_n) begin
//    if(!rst_n)
//        port_use_nuncnt <= 16'b0 ;
//    else if (port_use_ack)
//        port_use_nuncnt <= port_use_nuncnt + 1'b1 ;
//    else if (release_vld)
//        port_use_nuncnt <= port_use_nuncnt - 1'b1 ;
//    else
//        port_use_nuncnt <= port_use_nuncnt ;
//end

// always@(posedge clk or negedge rst_n)
// begin
//   if(!rst_n)
//   port_ack_en <= 1'b0 ;
//   else if (port_use_ack)
//   port_ack_en <= 1'b1 ;
//   else
//   port_ack_en <= port_ack_en ;
// end

// always@(posedge clk or negedge rst_n)
// begin
//   if(!rst_n) begin
//   port_ack_high    <= 1'b0 ;
//   port_ack_high_ff <= 1'b0 ;
//   end
//   else if (outbound_cstate == ADD_ITEM) begin
//   port_ack_high    <= 1'b1 ;
//   port_ack_high_ff <= port_ack_high ;
//   end
//   else begin
//   port_ack_high    <= port_ack_high ;
//   port_ack_high_ff <= port_ack_high_ff ;
//   end
// end

//always@(posedge clk or negedge rst_n) begin
//    if(!rst_n) begin
//        IP_maint        <= 32'h0000_0000 ;
//        port_lan_maint  <= 16'h0000      ;
//        port_wan_maint  <= 16'h0000      ;
//        port_type_maint <= 3'b000        ;
//  end
//    else if (outbound_ack) begin
//        IP_maint        <=  IP_lan        ;
//        port_lan_maint  <=  port_lan      ;
//        port_wan_maint  <=  port_lan_NAT  ;
//        port_type_maint <=  port_type_lan ;
//  end
//    else if (inbound_ack)  begin
//        IP_maint        <=  IP_wan_NAT    ;
//        port_lan_maint  <=  port_wan_NAT  ;
//        port_wan_maint  <=  port_wan      ;
//        port_type_maint <=  port_type_wan ;
//  end
//    else begin
//        IP_maint        <= IP_maint        ;
//        port_lan_maint  <= port_lan_maint  ;
//        port_wan_maint  <= port_wan_maint  ;
//        port_type_maint <= port_type_maint ;
//  end
//end

// always@(posedge clk or negedge rst_n)
// begin
//   if(!rst_n)
//   tcp_fin[1] <= 0 ;
//   else if (outbound_cstate == TCP_FIN)
//   tcp_fin[1] <= 1 ;
//   else
//   tcp_fin[1] <= 0 ;
// end
//////////////release//////////////////////////////
// wire [31 : 0 ]  IP_outb_release ;
// wire [15 : 0 ]  port_outb_release ;
// wire [ 2 : 0 ]  port_typeoutb_release ;


// always@(posedge clk or negedge rst_n)
// begin
//   if(!rst_n) begin
//   IP_release        <= 32'h0000_0000 ;
//   port_release      <= 16'h0000      ;
//   port_type_release <= 3'b000        ;
//   end
//   else if (release_vld) begin
//   IP_release        <= IP_outb_release       ;
//   port_release      <= port_outb_release     ;
//   port_type_release <= port_typeoutb_release ;
//   end
//   else begin
//   IP_release        <= IP_release        ;
//   port_release      <= port_release      ;
//   port_type_release <= port_type_release ;
//   end
// end
////////////////recycle //////////////////////////
//always@(posedge clk or negedge rst_n) begin
//    if(!rst_n) 
//        port_rec <= 16'h0000     ;
//    else if (release_vld) 
//        port_rec <= port_release ;
//    else 
//        port_rec <= port_rec     ;
//end
//
//always@(posedge clk or negedge rst_n) begin
//    if(!rst_n) 
//        port_rec_vld <= 0 ;
//    else if (release_vld) 
//        port_rec_vld <= 1 ;
//    else 
//        port_rec_vld <= 0 ;
//end
//
//always@(posedge clk or negedge rst_n) begin
//    if(!rst_n) 
//        port_type_rec <= 3'b000 ;
//    else if (release_vld) 
//        port_type_rec <= port_type_release ;
//    else 
//        port_type_rec <= port_type_rec ;
//end
/////////////////inbound//////////////////////////////////
//////////////////////////////////////////////////////////
//
//always @ (posedge clk or negedge rst_n) begin
//    if(!rst_n)
//        inbound_cstate <=  IDLE ;
//    else
//        inbound_cstate <=  inbound_nstate ;
//end
//
//always @ (*) begin
//    if(!rst_n)
//        inbound_nstate <= IDLE ;
//    else 
//        case(inbound_cstate)
//
//        IDLE : 
//            if(wan_vld_r && ib_search_suc)
//                inbound_nstate <= LKUP_SUC ;
//            else 
//                inbound_nstate <= IDLE ;
//    
//        LKUP_SUC :
//            if(inbound_drop)
//                inbound_nstate <= IDLE ;
//            else if(inbound_ack && !(TCP_wan_flag_vld && (TCP_wan_flag[2] || TCP_wan_flag[0])))
//                inbound_nstate <= LKUP_SUC_EXEC ;
//            else if(inbound_ack && TCP_wan_flag_vld && TCP_wan_flag[2] )
//                inbound_nstate <= TCP_RST ;
//            // else if(inbound_ack && TCP_wan_flag_vld && TCP_wan_flag[0] )
//            //     inbound_nstate <= TCP_FIN ;
//            else 
//                inbound_nstate <= LKUP_SUC ;
//    
//        LKUP_SUC_EXEC :
//            if(maint_done)
//                inbound_nstate <= IDLE ;
//            else
//                inbound_nstate <= LKUP_SUC_EXEC ;
//    
//        TCP_RST :
//        maint_release <= 1'b0 ;
//end
//
//always@(posedge clk or negedge rst_n) begin
//    if(!rst_n)
//        IP_maint_rel <= 32'h0000_0000 ;
//    else if (outbound_cstate == LKUP_SUC && outbound_nstate == TCP_RST)
//        IP_maint_rel <= IP_lan        ;
//    else if (inbound_cstate == LKUP_SUC && inbound_nstate == TCP_RST)
//        IP_maint_rel <= IP_wan_NAT    ;
//    else
//        IP_maint_rel <= IP_maint_rel  ;
//end
//
//always@(posedge clk or negedge rst_n) begin
//    if(!rst_n)
//        port_maint_rel <= 16'h0000       ;
//    else if (outbound_cstate == LKUP_SUC && outbound_nstate == TCP_RST)
//        port_maint_rel <= port_lan_NAT   ;
//    else if (inbound_cstate == LKUP_SUC && inbound_nstate == TCP_RST)
//        port_maint_rel <= port_wan       ;
//    else
//        port_maint_rel <= port_maint_rel ;
//end
//
//always@(posedge clk or negedge rst_n) begin
//    if(!rst_n)
//        port_type_mt_rel <= 3'b000 ;
//    else if ((outbound_cstate == LKUP_SUC && outbound_nstate == TCP_RST) || (inbound_cstate == LKUP_SUC && inbound_nstate == TCP_RST))
//        port_type_mt_rel <= 3'b100 ;
//    else
//        port_type_mt_rel <= port_type_mt_rel ;
//end

endmodule
