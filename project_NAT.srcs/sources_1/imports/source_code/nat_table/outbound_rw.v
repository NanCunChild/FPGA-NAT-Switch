module outbound_rw (
    //write
    input  wire           clk            ,
    input  wire           rst_n          ,
    input  wire           maint_vld      ,
    input  wire   [31:0]  ip_maint       ,
    input  wire   [15:0]  port_lan_maint ,
    input  wire   [15:0]  port_wan_maint ,
    input  wire   [ 2:0]  session_type   ,
    input  wire   [ 1:0]  tcp_fin        ,
    input  wire   [ 1:0]  tcp_syn        ,         
    //ram
    input  wire   [95:0]  q_outbound     , 
    output reg    [9 :0]  addr_a         ,
    output reg    [95:0]  data_a         ,//data_a={ip(32),lanport(16)，wanport（16），val,type,syn(2),fin(2),time_now(17)}
    output reg            wren_a         ,
    
    //delete
    input  wire   [16:0]  time_notcp     ,
    input  wire   [16:0]  time_tcpsf     ,
    input  wire   [16:0]  time_tcping    ,
    input  wire   [16:0]  cpu_cd_time    ,

    //hash
    input  wire          hash_en              ,
    input  wire   [9:0]  hash_outbound_maint  , //study
    input  wire   [9:0]  hash_outbound_lookup , //lookup

    //lookup
    input  wire           lan_vld        ,
    input  wire   [31:0]  ip_lan         ,
    input  wire   [15:0]  port_lan       , 
    input  wire   [ 2:0]  port_lan_type  ,//tcp,udp,icmp
    output reg    [15:0]  outwan_port    ,//wan_port!
    output wire           outwan_port_en ,
    output wire           look_incorrect ,
    output wire           outb_cover_en  ,
    
    //else
    output  wire          busy           ,
    output  reg           lookup_done    ,
    output  reg           study_done     ,
    output  reg           init_end
        
);




//Initial
reg  [9 : 0]  init_addr               ;
reg           lan_vld_ff              ;
reg           maint_vld_ff            ;
reg           lookup_start            ;
reg           lookup_start_ff         ;  
wire          colldisn                ;
reg           maint_vld_ff_co         ;
reg  [ 9: 0]  hash_outbound_maint_ff1 ;

reg  [15: 0]  port_lan_maint_ff1   ;
reg  [15: 0]  port_wan_maint_ff1   ;
reg  [31: 0]  ip_maint_ff1         ;
reg  [ 2: 0]  session_type_ff1     ;
reg  [ 1: 0]  tcp_fin_ff1          ;
reg  [ 1: 0]  tcp_syn_ff1          ;
reg  [15: 0]  port_lan_maint_ff_co ;
reg  [15: 0]  port_wan_maint_ff_co ;
reg  [31: 0]  ip_maint_ff_co       ;
reg  [ 2: 0]  session_type_ff_co   ;
reg  [ 1: 0]  tcp_fin_ff_co        ;
reg  [ 1: 0]  tcp_syn_ff_co        ;

reg  [15: 0]  port_lan_ff1       ;
reg  [15: 0]  port_lan_ff2       ;
reg  [15: 0]  port_lan_ff3       ;
reg  [31: 0]  ip_lan_ff1         ;
reg  [31: 0]  ip_lan_ff2         ;
reg  [31: 0]  ip_lan_ff3         ;
reg  [ 2: 0]  port_lan_type_ff1  ;
reg  [ 2: 0]  port_lan_type_ff2  ;
reg  [ 2: 0]  port_lan_type_ff3  ;



assign colldisn = lan_vld_ff && maint_vld_ff ;

always @ (posedge clk or negedge rst_n)begin
    if(~rst_n)
        init_addr  <=  10'd0 ;
    else if (!init_end)
        init_addr  <=  init_addr + 10'd1 ;
    else
        init_addr  <=  10'd0 ;
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
        lan_vld_ff       <=  1'b0    ;
    else    
        lan_vld_ff       <=  lan_vld ;
end

always @ (posedge clk or negedge rst_n)begin
    if(~rst_n)
        maint_vld_ff       <=   1'b0    ;
    else 
        maint_vld_ff       <= maint_vld ;
end

always @ (posedge clk or negedge rst_n)begin
    if(~rst_n)
        maint_vld_ff_co       <=   1'b0       ;
    else if (colldisn)
        maint_vld_ff_co       <= maint_vld_ff ;
end
always @ (posedge clk or negedge rst_n)begin

    if(~rst_n)
        hash_outbound_maint_ff1       <=  10'b0  ;
    else if (colldisn)
        hash_outbound_maint_ff1       <= hash_outbound_maint ;
end

always @ (posedge clk or negedge rst_n)begin
    if(~rst_n) begin
        lookup_start_ff    <= 1'b0 ;
        lookup_done        <= 1'b0 ;
    end
    else begin
        lookup_start_ff    <= lookup_start    ;
        lookup_done        <= lookup_start    ;
    end
end

always @ (posedge clk or negedge rst_n)begin
    if(~rst_n)
        lookup_start       <=  1'b0 ;
    else if (lan_vld_ff)
        lookup_start       <=  1'b1 ;
    else
        lookup_start       <=  1'b0 ;
end

always @ (posedge clk or negedge rst_n)begin
    if(~rst_n) begin
        port_lan_maint_ff1  <=  16'b0         ;
        port_wan_maint_ff1  <=  16'b0         ;
        ip_maint_ff1        <=  32'b0         ;
        session_type_ff1    <=   3'b0         ;
        tcp_fin_ff1         <=   2'b0         ;
        tcp_syn_ff1         <=   2'b0         ;
        port_lan_ff1        <=  16'b0         ;
        ip_lan_ff1          <=  32'b0         ;
        port_lan_type_ff1   <=   3'b0         ; 
    end
    else begin 
        port_lan_maint_ff1  <= port_lan_maint ;
        port_wan_maint_ff1  <= port_wan_maint ; 
        ip_maint_ff1        <= ip_maint       ; 
        session_type_ff1    <= session_type   ; 
        tcp_fin_ff1         <= tcp_fin        ; 
        tcp_syn_ff1         <= tcp_syn        ; 
        port_lan_ff1        <= port_lan       ; 
        ip_lan_ff1          <= ip_lan         ; 
        port_lan_type_ff1   <= port_lan_type  ; 
   end
end

always @ (posedge clk or negedge rst_n) begin
    if(~rst_n) begin
        port_lan_ff2        <=  16'b0             ;
        ip_lan_ff2          <=  32'b0             ;
        port_lan_type_ff2   <=   3'b0             ;
        port_lan_ff3        <=  16'b0             ;
        ip_lan_ff3          <=  32'b0             ;
        port_lan_type_ff3   <=   3'b0             ;

    end
    else begin 
        port_lan_ff2        <= port_lan_ff1       ; 
        ip_lan_ff2          <= ip_lan_ff1         ; 
        port_lan_type_ff2   <= port_lan_type_ff1  ;
        port_lan_ff3        <= port_lan_ff2       ;
        ip_lan_ff3          <= ip_lan_ff2         ;
        port_lan_type_ff3   <= port_lan_type_ff2  ;

   end
end

always @ (posedge clk or negedge rst_n) begin
    if(~rst_n) begin
        port_lan_maint_ff_co  <=  16'b0         ;
        port_wan_maint_ff_co  <=  16'b0         ;
        ip_maint_ff_co        <=  32'b0         ;
        session_type_ff_co    <=   3'b0         ;
        tcp_fin_ff_co         <=   2'b0         ;
        tcp_syn_ff_co         <=   2'b0         ;
    end
    else begin 
        port_lan_maint_ff_co  <= port_lan_maint_ff1 ;
        port_wan_maint_ff_co  <= port_wan_maint_ff1 ; 
        ip_maint_ff_co        <= ip_maint_ff1       ; 
        session_type_ff_co    <= session_type_ff1   ; 
        tcp_fin_ff_co         <= tcp_fin_ff1        ; 
        tcp_syn_ff_co         <= tcp_syn_ff1        ; 
   end
end

//FSM_1
//always @ (posedge clk or negedge rst_n)begin
//  if(~rst_n)
//    c_state <=  INIT ;
//  else
//    c_state <=  n_state ;
//    end
////FSM_2
//always@(*)begin
//    case (c_state)  
//    INIT://000
//    if(init_end)
//    n_state  = IDLE ;
//    else 
//    n_state  = INIT ;
//
//    IDLE://001
//    if(hash_en && lan_vld_r)
//    n_state = LOOKUP ;
//    else if(maint_vld_ff)
//    n_state = STUDY  ;
//    else 
//    n_state = IDLE   ;
//
//    LOOKUP://010
//    if(lookup_done)
//    n_state = IDLE   ;
//    else
//    n_state = LOOKUP ;
//
//    STUDY://100
//    if(wren_a)
//    n_state = IDLE   ;
//    else
//    n_state = STUDY  ;
//    
//    default:
//    n_state = IDLE   ;
//   endcase
//end
//FSM_3
always@(posedge clk or negedge rst_n)begin
    if(~rst_n) begin
        addr_a <= 10'b0 ;
        data_a <= 96'b0 ;
        wren_a <= 1'b0  ;
    end
    else if (!init_end) begin
        addr_a <= init_addr  ;    //inital
        data_a <= 96'b0      ;
        wren_a <= 1'b1       ;
    end  
    else if (lan_vld_ff) begin
        addr_a <= hash_outbound_lookup ;    
        data_a <= 96'b0                ;           //读
        wren_a <= 1'b0                 ;
    end
    else if (maint_vld_ff_co) begin //://假设100=tcp  ，假设010=udp ，001=icmp；syn=10进入tcp的start阶段 ，syn=11进入tcp的ing状态，fin=11进入tcp的结束状态
      if ((session_type_ff_co==3'b010)||(session_type_ff_co==3'b001)) begin
            addr_a <= hash_outbound_maint_ff1  ;    
            data_a <= {6'b0,1'b0,ip_maint_ff_co,port_lan_maint_ff_co,port_wan_maint_ff_co,1'b1,session_type_ff_co,tcp_syn_ff_co,tcp_fin_ff_co,time_notcp} ;  
            wren_a <= 1'b1 ;//1028
      end
      else if ((session_type_ff_co==3'b100)&&((tcp_syn_ff_co==2'b10)||(tcp_fin_ff_co==2'b11))) begin
            addr_a <= hash_outbound_maint_ff1  ;    
            data_a <= {6'b0,1'b0,ip_maint_ff_co,port_lan_maint_ff_co,port_wan_maint_ff_co,1'b1,session_type_ff_co,tcp_syn_ff_co,tcp_fin_ff_co,time_tcpsf} ;  
            wren_a <= 1'b1 ;//1028
      end
      else if ((session_type_ff_co==3'b100)&&(tcp_syn_ff_co==2'b11)) begin
            addr_a <= hash_outbound_maint_ff1  ;    
            data_a <= {6'b0,1'b0,ip_maint_ff_co,port_lan_maint_ff_co,port_wan_maint_ff_co,1'b1,session_type_ff_co,tcp_syn_ff_co,tcp_fin_ff_co,time_tcping} ;  
            wren_a <= 1'b1 ;//1028
      end
      else begin
            addr_a <= 10'b0 ;
            data_a <= 96'b0 ;
            wren_a <= 1'b0  ;
      end
    end
    else if (maint_vld_ff) begin
      if ((session_type_ff1==3'b010)||(session_type_ff1==3'b001)) begin
            addr_a <= hash_outbound_maint  ;    
            data_a <= {6'b0,1'b0,ip_maint_ff1,port_lan_maint_ff1,port_wan_maint_ff1,1'b1,session_type_ff1,tcp_syn_ff1,tcp_fin_ff1,time_notcp} ;  
            wren_a <= 1'b1 ;//1028
      end
      else if ((session_type_ff1==3'b100)&&((tcp_syn_ff1==2'b10)||(tcp_fin_ff1==2'b11))) begin
            addr_a <= hash_outbound_maint  ;    
            data_a <= {6'b0,1'b0,ip_maint_ff1,port_lan_maint_ff1,port_wan_maint_ff1,1'b1,session_type_ff1,tcp_syn_ff1,tcp_fin_ff1,time_tcpsf} ;  
            wren_a <= 1'b1 ;//1028
      end
      else if ((session_type_ff1==3'b100)&&(tcp_syn_ff1==2'b11)||(tcp_syn_ff1==2'b00)) begin
            addr_a <= hash_outbound_maint  ;    
            data_a <= {6'b0,1'b0,ip_maint_ff1,port_lan_maint_ff1,port_wan_maint_ff1,1'b1,session_type_ff1,tcp_syn_ff1,tcp_fin_ff1,time_tcping} ;  
            wren_a <= 1'b1 ;//1028
      end
      else begin
            addr_a <= 10'b0 ;
            data_a <= 96'b0 ;
            wren_a <= 1'b0  ;
      end
    end
    else  begin
            addr_a <= 10'b0 ;
            data_a <= 96'b0 ;
            wren_a <= 1'b0  ;
    end
end


 //         STUDY://假设100=tcp  ，假设010=udp ，001=icmp；syn=10进入tcp的start阶段 ，syn=11进入tcp的ing状态，fin=11进入tcp的结束状态
 //            begin
 //                if(((session_type==3'b010)||(session_type==3'b001)))
 //                   begin
 //                      addr_a <= hash_outbound_maint ;    //inital
 //                      data_a <= {6'b0,1'b0,ip_maint,port_lan_maint,port_wan_maint,1'b1,session_type,tcp_syn,tcp_fin,time_notcp} ;
 //                      wren_a <= 1'b1 ;
 //                   end
 //               else if((session_type==3'b100)&&((tcp_syn==2'b10)||(tcp_fin==2'b11)))
 //                   begin
 //                      addr_a <= hash_outbound_maint ;    //inital
 //                      data_a <= {6'b0,1'b0,ip_maint,port_lan_maint,port_wan_maint,1'b1,session_type,tcp_syn,tcp_fin,time_tcpsf} ;
 //                      wren_a <= 1'b1 ;   
 //                   end
 //                 else if ((session_type==3'b100)&&(tcp_syn==2'b11)) 
 //                 begin 
 //                      addr_a <= hash_outbound_maint ;    //inital
 //                      data_a <= {6'b0,1'b0,ip_maint,port_lan_maint,port_wan_maint,1'b1,session_type,tcp_syn,tcp_fin,time_tcping} ;
 //                      wren_a <= 1'b1 ; 
 //                 end
 //                else begin
 //                      addr_a <= 10'b0 ;
 //                      data_a <= 96'b0 ;
 //                      wren_a <= 1'b0  ;
 //                end
 //            end
 //         LOOKUP:
 //            begin
 //                  addr_a <= hash_outbound_lookup ;    
 //                  data_a <= 96'b0                ;           //读
 //                  wren_a <= 1'b0                 ;
 //            end
 //           default:
 //           begin
 //           addr_a <= 10'b0                       ;
 //           data_a <= 96'b0                       ;
 //           wren_a <= 1'b0                        ;
 //           end
 //       endcase
 //   end
///////////////////////////////////////////////////////////////////////
//////////////////////////////lookup///////////////////////////////////
///////////////////////////////////////////////////////////////////////
//

wire [16:0] table_living ;
assign table_living = (time_tcping - q_outbound[16:0]) ;  


assign outwan_port_en =  ((lookup_done)&&(q_outbound[88:57]== ip_lan_ff3)&&(q_outbound[56:41]==port_lan_ff3)&&(q_outbound[23:21]==port_lan_type_ff3)&&(q_outbound[24]==1'b1)) ? 1'b1 : 1'b0 ;
assign look_incorrect = (lookup_done) && (q_outbound[24]==1'b1) && (!((q_outbound[88:57]== ip_lan_ff3)&&(q_outbound[56:41]==port_lan_ff3)&&(q_outbound[23:21]==port_lan_type_ff3))) ;
assign outb_cover_en = lookup_done && q_outbound[89] || (look_incorrect && (q_outbound[23:21] ==3'b100) && (q_outbound[20:19] == 2'b00) && (table_living < cpu_cd_time)); 

wire [2 :0] hash_outbound_lookup_plus ;
assign hash_outbound_lookup_plus = hash_outbound_lookup[7:5] + 1'b1 ;

always @ (*) begin
    if (outwan_port_en)
        outwan_port = q_outbound[40:25] ;
    else if (look_incorrect) begin
    case (port_lan_type_ff3)
        3'b100:outwan_port = {2'b11, port_lan_ff3[7:5],q_outbound[35:26],port_lan_ff3[4]} ;
        3'b010:outwan_port = {2'b11, port_lan_ff3[7:5],q_outbound[35:26],port_lan_ff3[0]} ;
        3'b001:outwan_port = {port_lan_ff3[9:5],q_outbound[35:26],port_lan_ff3[4]} ;
        default:outwan_port = 16'b0 ;
        endcase
      end
    else
        outwan_port = 16'b0 ;
      end

// always@(posedge clk or negedge rst_n)begin
//    if(~rst_n) begin
//    outwan_port_en <= 1'b0              ;
//    outwan_port    <= 16'b0             ;
//    end
//    else if((n_state == LOOKUP)&&(q_outbound[88:57]== ip_lan) && (q_outbound[56:41]==port_lan) && (q_outbound[23:21]==port_lan_type) && q_outbound[24]==1'b1) begin
//    outwan_port_en <= 1'b1              ;
//    outwan_port    <= q_outbound[40:25] ;
//    end
//    else begin
//    outwan_port_en <= 1'b0              ;
//    outwan_port    <= outwan_port       ;
//    end
// end
 
///////////////////////////////////////////////////////////////////////
//////////////////////////////flag sign////////////////////////////////
///////////////////////////////////////////////////////////////////////
reg  initing;
reg  rwing_outbound;
always@(posedge clk or negedge rst_n)begin
    if(~rst_n)
    initing <= 1'b0;
    else if(!init_end)
    initing <= 1'b1;
    else 
    initing <= 1'b0;
end
always@(posedge clk or negedge rst_n)begin
    if(~rst_n)
    rwing_outbound <= 1'b0;
    else if( lan_vld_ff || maint_vld_ff)
    rwing_outbound <= 1'b1;
    else 
    rwing_outbound <= 1'b0;
end
assign busy = initing| rwing_outbound;

always@(posedge clk or negedge rst_n)begin
  if(~rst_n)
    study_done  <= 1'b0;
  else if(maint_vld_ff)
    study_done <= 1'b1;
  else 
    study_done <= 1'b0;      
end 

`ifdef SIM
always @(posedge clk) begin
  if(wren_a) $display("[Outbound]%0t: %0d %0d %0d", $time, addr_a, port_lan_maint_ff1, port_wan_maint_ff1); 
end
`endif
endmodule


