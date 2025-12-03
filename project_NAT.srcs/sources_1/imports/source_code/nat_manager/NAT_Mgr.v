// **************************************************************
// COPYRIGHT(c)2024, Xidian University
// All rights reserved.
//
// IP LIB INDEX      :  
// IP Name           :  
// File name         :   NAT_Mgr.v
// Module name       :   NAT_Mgr
// Full name         :   
//
// Author            :   Chen Dilong 
// Email             :   1523245790@qq.com
// Data              :   2024/4/23
// Version           : V 1.0 
// 
// Abstract          :  distribute and reserve and release 
// Called by         : Father Module
// 
// Modification history
// ------------------------------------------------------------------------------------------------------
// //
// $Log$
//
// *********************************************************************
module NAT_Mgr
(
    input  wire             clk              ,
    input  wire             rst_n            , 
///////outbound/////////////////// 
    input  wire  [31 : 0]   IP_lan           ,
    input  wire  [15 : 0]   TCPPort_lan      , 
    input  wire  [15 : 0]   UDPPort_lan      , 
    input  wire  [15 : 0]   icmpID_lan       , 
    input  wire             TCPPort_lan_vld  ,
    input  wire             UDPPort_lan_vld  , 
    input  wire             icmpID_lan_vld   ,
    input  wire             lan_vld          ,
    input  wire  [ 2 : 0]   TCP_lan_flag     ,
    input  wire             TCP_lan_flag_vld ,
    input  wire             outbound_ack     ,
    input  wire             outbound_drop    ,
    output wire  [15 : 0]   Port_lan_NAT     ,
    //output wire             lan_NAT_vld      ,
    output wire             otb_fifo_empty   ,
/////////inbound///////////////////
    input  wire  [15 : 0]   TCPPort_wan      ,      
    input  wire  [15 : 0]   UDPPort_wan      ,       
    input  wire  [15 : 0]   icmpID_wan       ,       
    input  wire             TCPPort_wan_vld  ,
    input  wire             UDPPort_wan_vld  , 
    input  wire             icmpID_wan_vld   ,
    input  wire             wan_vld          ,
    input  wire  [ 2 : 0]   TCP_wan_flag     ,
    input  wire             TCP_wan_flag_vld ,
    input  wire             inbound_ack      ,
    input  wire             inbound_drop     ,
    output wire  [15 : 0]   Port_wan_NAT     ,
    // output wire             wan_NAT_vld      ,
    output wire  [31 : 0]   IP_wan_NAT       ,
    input  wire  [11 : 0]   ram_dp_cfg_register ,
    input  wire  [ 9 : 0]   ram_2p_cfg_register ,
    input  wire  [ 6 : 0]   rf_2p_cfg_register  ,
    output wire             inbound_fail        ,
    output wire             ib_fifo_empty       ,
    output wire             nat_table_init_end  ,
    //yfy 5.14 config interface   5.22 add width of the np_cpu_addr
    input  wire [31:0]  np_cpu_data_in          ,
    input  wire [18:0]  np_cpu_addr             ,
    input  wire [ 1:0]  np_cpu_ctr              ,
    output reg  [31:0]  np_cpu_data_out         ,
    output reg          data_out_vld 
);
//
wire  nat_mgr_out_vld,nat_table_out_vld;
wire [31:0]nat_mgr_out_data;
wire [31:0]nat_table_out_data;

///////////////avail_ppool/////////////////////////////
wire [9 :0] number_avail ;
wire [9 :0] number_rec   ;
wire [9 :0] nat_map_cnt  ;

wire [9 :0] hash_outbound_lookup  ;
////////////////manager///////////////////////////////
reg  [15 : 0]   port_avail        ;
wire            port_use_ack      ;
wire [15 : 0]   port_rec          ;
wire            port_rec_vld      ;

wire [15 : 0]   port_lan          ; 
wire [ 2 : 0]   port_type_lan     ;                              
wire            otb_search_suc    ;           
wire            otb_search_fail   ;                           
wire            look_incorrect    ;
wire [15 : 0]   port_sear_wan     ;           
wire [15 : 0]   port_wan          ;             
wire [ 2 : 0]   port_type_wan     ;        


wire            ib_search_suc     ; 
wire            ib_search_fail    ;
wire [31 : 0]   IP_sear_lan       ;                       
wire [15 : 0]   port_sear_lan     ;                       
wire [31 : 0]   IP_maint          ;                         
wire [15 : 0]   port_lan_maint    ;                   
wire [15 : 0]   port_wan_maint    ;                     
wire [2  : 0]   port_type_maint   ;                   
wire            maint_vld         ;                 
wire            maint_release     ;                             
wire            outb_cover_en     ;
wire            ib_cover_en       ;
wire [1  : 0]   tcp_fin           ;                     
wire            tcp_fin_vld       ;                     
wire [ 1 : 0]   tcp_syn           ;
wire            tcp_syn_vld       ;
wire            prog_full         ;                               
wire [31 : 0]   IP_maint_rel      ;                   
wire [15 : 0]   port_lan_maint_rel;
wire [15 : 0]   port_wan_maint_rel;
wire [2  : 0]   port_type_mt_rel  ;             
wire            maint_done        ;                 
wire [15 : 0]   port_release      ;                   
//wire [2  : 0]   port_type_release ;                                 
wire            release_vld       ; 

assign port_lan       = TCPPort_lan_vld ? TCPPort_lan :
                        UDPPort_lan_vld ? UDPPort_lan :
                        icmpID_lan_vld  ? icmpID_lan  : 16'h0000 ;
assign port_type_lan  = {TCPPort_lan_vld , UDPPort_lan_vld , icmpID_lan_vld} ;                        
assign port_type_wan  = {TCPPort_wan_vld , UDPPort_wan_vld , icmpID_wan_vld} ;                  
assign port_wan       = TCPPort_wan_vld ? TCPPort_wan :
                        UDPPort_wan_vld ? UDPPort_wan :
                        icmpID_wan_vld  ? icmpID_wan  : 16'h0000 ;

assign number_rec     = port_rec[10 :1] ;

reg [2 :0] port_type_lan_r ;
always@(posedge clk or negedge rst_n)begin
    if(~rst_n) 
        port_type_lan_r <= 3'b0            ;
    else if (|port_type_lan)
        port_type_lan_r <= port_type_lan   ;
    else
        port_type_lan_r <= port_type_lan_r ;
end

always @ (*) begin
    case (port_type_lan_r)
        3'b100:port_avail = {2'b11,TCPPort_lan[7:5],number_avail,TCPPort_lan[4]} ;
        3'b010:port_avail = {2'b11,UDPPort_lan[7:5],number_avail,UDPPort_lan[0]} ;
        3'b001:port_avail = {icmpID_lan[9:5],number_avail,icmpID_lan[4]} ;
        default:port_avail = 16'b0 ;
       endcase
end

manager inst_manager 
(
    .rst_n                   (rst_n                ) , 
    .clk                     (clk                  ) ,          

    .port_avail              (port_avail           ) ,                                            
    .port_use_ack            (port_use_ack         ) ,                                            
    .port_rec                (port_rec             ) ,                                            
    .port_rec_vld            (port_rec_vld         ) ,

    .IP_lan                  (IP_lan               ) ,                                            
    .port_lan                (port_lan             ) ,                                            
    .port_type_lan           (port_type_lan        ) ,                                            
    .otb_search_suc          (otb_search_suc       ) ,                                            
    .otb_search_fail         (otb_search_fail      ) ,                                            
    .port_sear_wan           (port_sear_wan        ) ,                                            
    .outb_cover_en           (outb_cover_en        ),
    .lan_vld                 (lan_vld              ) ,                                            
    .TCP_lan_flag            (TCP_lan_flag         ) ,                                            
    .outbound_ack            (outbound_ack         ) ,                                            
    .outbound_drop           (outbound_drop        ) ,                                            
    .port_lan_NAT            (Port_lan_NAT         ) ,                                            
    .otb_fifo_empty          (otb_fifo_empty       ) ,  
    .port_wan                (port_wan             ) ,                                            
    .port_type_wan           (port_type_wan        ) ,                                            
    .wan_vld                 (wan_vld              ) ,                                            
    .TCP_wan_flag            (TCP_wan_flag         ) ,                                            
    .inbound_ack             (inbound_ack          ) ,                                            
    .inbound_drop            (inbound_drop         ) ,                                                     
    .ib_search_suc           (ib_search_suc        ) ,                                                     
    .ib_search_fail          (ib_search_fail       ) ,                                                     
    .IP_sear_lan             (IP_sear_lan          ) ,                                                     
    .port_sear_lan           (port_sear_lan        ) ,                                                     
    .ib_cover_en             (ib_cover_en          ) ,
    .IP_wan_NAT              (IP_wan_NAT           ) ,                                                     
    .port_wan_NAT            (Port_wan_NAT         ) ,                                                
    .inbound_fail            (inbound_fail         ) ,
    .ib_fifo_empty           (ib_fifo_empty        ) ,  

    .IP_maint                (IP_maint             ) ,                                                                
    .port_lan_maint          (port_lan_maint       ) ,                                                                
    .port_wan_maint          (port_wan_maint       ) ,                                                                
    .port_type_maint         (port_type_maint      ) , 
    .maint_vld               (maint_vld            ) , 
    .maint_release           (maint_release        ) , 
    .tcp_fin                 (tcp_fin              ) , 
    .tcp_syn                 (tcp_syn              ) , 
    .prog_full               (prog_full            ) , 
    .IP_maint_rel            (IP_maint_rel         ) , 
    .port_lan_maint_rel      (port_lan_maint_rel   ) , 
    .port_wan_maint_rel      (port_wan_maint_rel   ) , 
    .port_type_mt_rel        (port_type_mt_rel     ) ,

    .port_release            (port_release         ) , 
    //.port_type_release       (port_type_release    ) , 
    .rf_2p_cfg_register      (rf_2p_cfg_register   ) ,
    .release_vld             (release_vld          )  
);
wire outwan_port_en          ;
wire out_result_en           ;
wire active_release          ;
wire [ 1 : 0 ] lookup_done   ;// {ob_lookup_done,ib_lookup_done}

assign ib_search_suc   = out_result_en && lookup_done[0]     ;
assign ib_search_fail  = (!out_result_en) && lookup_done[0]  ;
assign otb_search_suc  = (outwan_port_en | look_incorrect) && lookup_done[1]    ;
assign otb_search_fail = (!(outwan_port_en|look_incorrect)) && lookup_done[1] ;

assign tcp_syn_vld     = TCP_lan_flag_vld | TCP_wan_flag_vld ;
assign tcp_fin_vld     = TCP_lan_flag_vld | TCP_wan_flag_vld ;


avail_ppool  inst_avail_ppool
(
    .clk                 ( clk                ), 
    .rst_n               ( rst_n              ), 
    .number_avail        ( number_avail       ),        
    .port_use_ack        ( port_use_ack       ),     
    .number_rec          ( number_rec         ),     
    .number_rec_vld      ( port_rec_vld       ),      
    .ram_2p_cfg_register ( ram_2p_cfg_register),
    .nat_map_cnt         ( nat_map_cnt        ),
    .np_cpu_data_in      ( np_cpu_data_in     ),
    .np_cpu_addr         ( np_cpu_addr        ),
    .np_cpu_ctr          ( np_cpu_ctr         ),
    .np_cpu_data_out     ( nat_mgr_out_data   ),
    .data_out_vld        ( nat_mgr_out_vld    )
  );

nat_top inst_nat_top
(    
    .clk                         (clk                 ) , 
    .rst_n                       (rst_n               ) , 
    .maint_vld                   (maint_vld           ) ,     
    .ip_maint                    (IP_maint            ) , 
    .port_lan_maint              (port_lan_maint      ) ,   
    .port_wan_maint              (port_wan_maint      ) ,  
    .session_type                (port_type_maint     ) ,   
    .tcp_fin_vld                 (tcp_fin_vld         ) ,    
    .tcp_fin                     (tcp_fin             ) ,  
    .tcp_syn_vld                 (tcp_syn_vld         ) ,      
    .tcp_syn                     (tcp_syn             ) ,    
    .lan_vld                     (lan_vld             ) ,     
    .ip_lan                      (IP_lan              ) ,  
    .port_lan                    (port_lan            ) ,  
    .port_lan_type               (port_type_lan       ) ,       
    .outwan_port                 (port_sear_wan       ) ,  
    .outwan_port_en              (outwan_port_en      ) ,
    .look_incorrect              (look_incorrect      ) ,
    .outb_cover_en               (outb_cover_en       ) ,
    .hash_outbound_lookup        (hash_outbound_lookup) ,
    .wan_vld                     (wan_vld             ) ,        
    .port_wan                    (port_wan            ) ,     
    .port_wan_type               (port_type_wan       ) ,       
    .outip                       (IP_sear_lan         ) ,  
    .outlan_port                 (port_sear_lan       ) ,   
    .out_result_en               (out_result_en       ) ,  
    .ib_cover_en                 (ib_cover_en         ) ,
    .ram_dp_cfg_register         (ram_dp_cfg_register ) ,
    .active_release              (maint_release       ) ,          
    .active_release_ip           (IP_maint_rel        ) ,         
    .active_release_port         (port_lan_maint_rel  ) ,
    .active_release_session_type (port_type_mt_rel    ) ,
    .release_en                  (release_vld         ) ,
    .delete_port_wan             (port_release        ) ,
    //.delete_session_type         (port_type_release   ) ,
    .study_done                  (maint_done          ) ,
    .lookup_done                 (lookup_done         ) ,
    .init_end                    (nat_table_init_end  ) ,
    .np_cpu_data_in              (np_cpu_data_in      ) ,//5.23 yfy add config interface for nat table   
    .np_cpu_addr                 (np_cpu_addr         ) ,
    .np_cpu_ctr                  (np_cpu_ctr          ) , 
    .np_cpu_data_out             (nat_table_out_data  ) ,   
    .data_out_vld                (nat_table_out_vld   )                                
);

//yfy 5.24

always@(posedge clk or negedge rst_n)begin
    if(~rst_n)
        np_cpu_data_out <= 32'b0;
    else if(nat_mgr_out_vld)
        np_cpu_data_out <= nat_mgr_out_data;
    else if(nat_table_out_vld)
        np_cpu_data_out <= nat_table_out_data ;
    else
        np_cpu_data_out <= np_cpu_data_out ;
end

always@(posedge clk or negedge rst_n)begin
    if(~rst_n)
        data_out_vld <= 1'b0;
    else if(nat_mgr_out_vld||nat_table_out_vld)
        data_out_vld <= 1'b1; 
    else
        data_out_vld <= 1'b0;
end

`ifdef  DEBUG
ila_map_cnt inst_ila_map_cnt
(
  .clk(clk),

  .probe0(number_avail),
  .probe1(number_rec  ),
  .probe2(nat_map_cnt )
);
`endif
endmodule
