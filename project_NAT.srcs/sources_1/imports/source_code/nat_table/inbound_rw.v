module inbound_rw (
    //write
    input  wire           clk                   ,
    input  wire           rst_n                 ,
    input  wire           maint_vld             ,
    input  wire  [9 :0]   outbound_addr         ,
    input  wire  [15:0]   port_wan_maint        ,
    input  wire  [2 :0]   session_type          ,
    //inbound address table
    input  wire  [15:0]   q_inbound             ,
    output reg   [9 :0]   addr_b                ,
    output reg   [15:0]   data_b                ,
    output reg            wren_b                ,
    //lookup
    input  wire           wan_vld               ,
    input  wire  [15:0]   port_wan              ,
    input  wire  [2 :0]   port_wan_type         ,//tcp,udp,icmp
    output reg            outaddr_en            ,
    output wire  [9 :0]   out_addr              ,
    input  wire  [95:0]   q_outbound            ,
    output wire  [31:0]   outip                 ,
    output wire  [15:0]   outlan_port           ,
    output wire           out_result_en         ,
    output wire           ib_cover_en           ,
    //else
    output wire           busy                  ,
    output reg            lookup_done           ,
    output reg            study_done            ,
    output reg            init_end
       
);

reg           wan_vld_ff              ;
reg           wan_vld_ff2             ;
reg  [9 :0]   init_addr               ;
reg           maint_vld_ff            ;
wire          colldisn                ;
reg           maint_vld_co            ;
reg  [9 :0]   outbound_addr_ff        ;
reg           lookup_start         ;
reg           lookup_start_ff      ;
reg           lookup_start_ff2     ;
reg           lookup_start_ff3     ;

reg  [15: 0]  port_wan_maint_ff1   ;
reg  [ 2: 0]  session_type_ff1     ;
reg  [15: 0]  port_wan_maint_ff2   ;
reg  [ 2: 0]  session_type_ff2     ;

reg  [15: 0]  port_wan_ff1       ;
reg  [15: 0]  port_wan_ff2       ;
reg  [15: 0]  port_wan_ff3       ;
reg  [15: 0]  port_wan_ff4       ;

reg  [ 2: 0]  port_wan_type_ff1  ;
reg  [ 2: 0]  port_wan_type_ff2  ;
reg  [ 2: 0]  port_wan_type_ff3  ;
reg  [ 2: 0]  port_wan_type_ff4  ;


assign colldisn = wan_vld && maint_vld_ff ;

always @ (posedge clk or negedge rst_n)begin
    if(~rst_n)
        init_addr   <=  10'd0 ;
    else if (!init_end)
        init_addr   <=  init_addr + 10'd1 ;
    else
        init_addr   <=  10'd0 ;
end

always @ (posedge clk or negedge rst_n)begin
    if(~rst_n)
        init_end        <=  1'b0 ;
    else if (init_addr == 10'h3ff)  //1024个地址
        init_end        <=  1'b1 ;
    else
        init_end        <=  init_end ;
end


always @ (posedge clk or negedge rst_n)begin
    if(~rst_n)
        maint_vld_co       <= 1'b0 ;
    else if (colldisn)
        maint_vld_co       <= 1'b1 ;
    else
        maint_vld_co       <= 1'b0 ;
end

always @ (posedge clk or negedge rst_n)begin
    if(~rst_n)
        maint_vld_ff       <= 1'b0 ;
     else
        maint_vld_ff       <= maint_vld ;
end

// todo
always @ (posedge clk or negedge rst_n)begin
    if(~rst_n) begin
        lookup_start_ff    <= 1'b0 ;
        lookup_start_ff2   <= 1'b0 ;
        lookup_done        <= 1'b0 ;
    end
    else begin
        lookup_start_ff    <= lookup_start    ;
        lookup_start_ff2   <= lookup_start_ff ;
        lookup_done        <= lookup_start_ff2 ;
    end
end

always @ (posedge clk or negedge rst_n)begin
    if(~rst_n)
        lookup_start       <=  1'b0 ;
    else if (wan_vld)
        lookup_start       <=  1'b1 ;
    else
        lookup_start       <=  1'b0  ;
end
 //todo//
 //
always @ (posedge clk or negedge rst_n)begin
    if(~rst_n) begin
        port_wan_maint_ff1  <=  16'b0         ;
        session_type_ff1    <=   3'b0         ;
        port_wan_maint_ff2  <=  16'b0         ;
        session_type_ff2    <=   3'b0         ;
    end
    else begin 
        port_wan_maint_ff1  <= port_wan_maint     ; 
        session_type_ff1    <= session_type       ; 
        port_wan_maint_ff2  <= port_wan_maint_ff1 ; 
        session_type_ff2    <= session_type_ff1   ; 
   end
end

always @ (posedge clk or negedge rst_n)begin
    if(~rst_n) begin 
        port_wan_ff1         <=   16'b0      ;
        port_wan_type_ff1    <=    3'b0      ;
        port_wan_ff2         <=   16'b0      ;
        port_wan_type_ff2    <=    3'b0      ;
        port_wan_ff3         <=   16'b0      ;
        port_wan_type_ff3    <=    3'b0      ;
        port_wan_ff4         <=   16'b0      ;
        port_wan_type_ff4    <=    3'b0      ;
      end
    else begin
        port_wan_ff1         <=  port_wan          ;
        port_wan_type_ff1    <=  port_wan_type     ;
        port_wan_ff2         <=  port_wan_ff1      ;  
        port_wan_type_ff2    <=  port_wan_type_ff1 ;
        port_wan_ff3         <=  port_wan_ff2      ;
        port_wan_type_ff3    <=  port_wan_type_ff2 ;
        port_wan_ff4         <=  port_wan_ff3      ;
        port_wan_type_ff4    <=  port_wan_type_ff3 ;
      end
end

always @ (posedge clk or negedge rst_n)begin
    if(~rst_n) begin
        wan_vld_ff          <=   1'b0       ;
        wan_vld_ff2         <=   1'b0       ;
        outaddr_en          <=   1'b0       ;
      end
    else begin
        wan_vld_ff          <=  wan_vld     ;
        wan_vld_ff2         <=  wan_vld_ff  ;
        outaddr_en          <=  wan_vld_ff2  ;
    end
end

always @ (posedge clk or negedge rst_n)begin
    if(~rst_n) 
        outbound_addr_ff <= 10'b0         ;
    else 
        outbound_addr_ff <= outbound_addr ;
end

always@(posedge clk or negedge rst_n)begin
    if(~rst_n) begin
        addr_b <= 10'b0 ;
        data_b <= 16'b0 ;
        wren_b <= 1'b0  ;
    end
    else if (!init_end) begin
        addr_b <= init_addr  ;    //inital
        data_b <= 16'b0      ;
        wren_b <= 1'b1       ;
    end  
    else if (wan_vld) begin
        addr_b <= port_wan[10:1]       ;    
        data_b <= 16'b0                ;           //读
        wren_b <= 1'b0                 ;
    end
    else if (maint_vld_co) begin  
        addr_b <= port_wan_maint_ff2[10:1]                      ;    //study
        data_b <= {2'b0,1'b1,outbound_addr_ff,session_type_ff2} ;
        wren_b <= 1'b1                                          ;   
    end
    else if (maint_vld_ff) begin
        addr_b <=  port_wan_maint_ff1[10:1]                     ;     //study
        data_b <= {2'b0,1'b1,outbound_addr,session_type_ff1}    ;
        wren_b <= 1'b1                                          ;          
    end
    else  begin
        addr_b <= 10'b0 ;
        data_b <= 16'b0 ;
        wren_b <= 1'b0  ;
    end
end

assign out_addr   = outaddr_en ? q_inbound[12:3] : 10'b0 ;

assign out_result_en = ((lookup_done)&&(q_outbound[40:25] == port_wan_ff3) && (q_outbound[23:21]==port_wan_type_ff3) && (q_outbound[24]==1'b1)) ? 1'b1 : 1'b0 ;
assign outip = out_result_en ? q_outbound[88:57] : 32'b0 ;
assign outlan_port = out_result_en ? q_outbound[56:41] : 16'b0 ;
assign ib_cover_en = out_result_en ? q_outbound[89] : 1'b0 ;



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
//    INIT:
//    if(init_end)
//    n_state  = IDLE;
//    else 
//    n_state  = INIT;
//
//    IDLE:
//    if(hash_en && wan_vld_r)
//    n_state = LOOKUP;
//    else if(hash_en && maint_vld_ff)
//    n_state =STUDY ;
//    else
//    n_state = IDLE ;
//    
//    LOOKUP:
//    if(outip_en)
//    n_state = IDLE   ;
//    else
//    n_state = LOOKUP ;
//
//    STUDY:
//    if(wren_b)
//    n_state = IDLE  ;
//    else
//    n_state = STUDY ;
//
//    default:
//    n_state = IDLE  ;
//   endcase
//end
////FSM_3
//always@(posedge clk or negedge rst_n)begin
//    if(~rst_n)
//      begin
//      addr_b <= 10'b0;
//      data_b <= 68'b0;
//      wren_b <= 1'b0;
//      end
//    else
//        case(n_state)
//           INIT:
//             begin
//                   addr_b <= init_addr;    //inital
//                   data_b <= 68'h0;
//                   wren_b <= 1'b1;
//             end  
//          STUDY:
//             begin
//                    begin
//                       addr_b <= hash_inbound_maint;    //study
//                       data_b <= {ip_maint,port_lan_maint,port_wan_maint,1'b1,session_type};
//                       wren_b <= 1'b1;   
//                    end
//             end
//          LOOKUP:
//             begin
//                   addr_b <= hash_inbound_lookup;    //lookup
//                   data_b <= 68'h0;           
//                   wren_b <= 1'b0;            //读
//             end
//            default:
//            begin
//            addr_b <= 10'b0;
//            data_b <= 68'b0;
//            wren_b <= 1'b0;
//            end
//        endcase
//    end
//////////////////////////////////////////////////////////////////////
///////////////////////////////lookup/////////////////////////////////
///////////////////////////////////////////////////////////////////////

//always@(posedge clk or negedge rst_n)begin
//    if(~rst_n) begin
//    outip_en <=1'b0;
//    outip    <=16'b0;
//    end
//    else if(n_state == LOOKUP && q_inbound[19:4] == port_wan && q_inbound[2:0]==port_wan_type && q_inbound[3]==1'b1) begin
//    outip_en <= 1'b1;
//    outip    <= q_inbound[67:36];
//    end
//    else begin
//    outip_en <= 1'b0;
//    outip    <= outip;
//    end
// end 
// always@(posedge clk or negedge rst_n) begin
//    if(~rst_n) begin
//    outlan_port_en <= 1'b0;
//    outlan_port    <= 16'b0;
//    end
//    else if(n_state == LOOKUP && q_inbound[19:4] == port_wan && q_inbound[2:0]==port_wan_type && q_inbound[3]==1'b1) begin
//    outlan_port_en <= 1'b1;
//    outlan_port    <= q_inbound[35:20];
//    end
//    else begin
//    outlan_port_en <= 1'b0;
//    outlan_port    <= outlan_port;
//    end
// end
///////////////////////////////////////////////////////////////////////
//////////////////////////////flag sign////////////////////////////////
///////////////////////////////////////////////////////////////////////
reg  initing;
reg  rwing_inbound;
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
    rwing_inbound <= 1'b0;
    else if(wan_vld_ff || maint_vld_ff)
    rwing_inbound <= 1'b1;
    else 
    rwing_inbound <= 1'b0;
end
assign busy = initing| rwing_inbound;

always@(posedge clk or negedge rst_n)begin
  if(~rst_n)
    study_done <= 1'b0;
  else if(maint_vld_ff)
    study_done <= 1'b1;
  else 
    study_done <= 1'b0;      
end 

`ifdef SIM
always @(posedge clk) begin
  if(wren_b) $display("[Inbound]%0t: %0d %0d", $time, addr_b, data_b[12:3]);
end
`endif


endmodule
