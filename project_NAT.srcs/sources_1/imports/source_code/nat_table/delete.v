module delete
( 
    input  wire            clk         ,
    input  wire            rst_n       ,
    //接ram  
    input  wire   [95:0]   q_d         , 
    output reg    [9 :0]   addr_d      ,
    output reg    [95:0]   data_d      ,
    output reg             wren_d      ,
    //接outbound_rw
    output reg    [16:0]   time_notcp  ,
    output reg    [16:0]   time_tcpsf  ,
    output reg    [16:0]   time_tcping ,
    //接inboud表 
    output reg    [15:0]   delete_port_wan              ,
    output reg             release_en                   ,
    //active release
    input  wire            active_release               ,
    input  wire   [9:0 ]   hash_outbound_delete         
);

//地址表中的数据{  ip(32), lan_port(16), wan_port(16),val,type,fin, time_notcp(17) }
//表中写入的时间是当前时间-1
reg[19:0] count_1;
reg[9 :0] count_0;
//定时器，单位为秒
reg[12:0] timer1; //[4096s ,  8191s]
reg[13:0] timer2; //[8192s , 16383s]
reg[16:0] timer3; //[65536s,131071s]

parameter LIVE_TIME1=600    ; //生存时间10min,notcp类型
parameter LIVE_TIME2=300    ; //生存时间5min,tcpstart/fin类型
parameter LIVE_TIME3=86400  ; //生存时间24h，tcp会话ing类型

//wire [12:0] live_time_temp;
//assign live_time_temp = live_time_i[12:0];

//count1_up_limit * timer_up_limit  = 125000000(频率) 
parameter COUNT1_UP_LIMIT = 19'd499999; //499999
parameter TIMER_UP_LIMIT  = 10'd250;  //250        

always@(posedge clk or negedge rst_n)
begin
    if(~rst_n)
      count_0 <= 10'd0;
    else if(count_0 == TIMER_UP_LIMIT)
      count_0 <= 10'd0;
    else 
      count_0 <= count_0 + 10'd1;
end
always@(posedge clk or negedge rst_n)
begin
    if(~rst_n)
      count_1 <= 0;
    else if(count_1 == COUNT1_UP_LIMIT && count_0 == TIMER_UP_LIMIT)
      count_1 <= 0;
    else if(count_0 == TIMER_UP_LIMIT)
      count_1 <= count_1 + 1;
    else 
      count_1 <= count_1;
end
//time 1
always@(posedge clk or negedge rst_n)
begin
    if(~rst_n)
      timer1 <= 0;
    else if( count_1 == COUNT1_UP_LIMIT && count_0 == TIMER_UP_LIMIT && timer1 == LIVE_TIME1)
      timer1 <= 0;
    else if( count_1 == COUNT1_UP_LIMIT && count_0 == TIMER_UP_LIMIT)
      timer1 <= timer1 + 13'd1;
    else 
      timer1 <= timer1;
end

always @ (posedge clk or negedge rst_n)
  if(~rst_n)
    begin
      time_notcp <=  13'd0;
    end
  else
    begin
      if(timer1==13'd0)
        time_notcp <=  LIVE_TIME1;   //time_notcp是给他放进去那一刻如果time刚好计到0给那个表项的time_notcp设置为4095；
      else
        time_notcp <=  timer1 - 13'd1;//如果正巧time 计数到399（随便），就将399-1=398给写到那个表项的time_notcp，等下次time循环到这个398的时候就刚好过去了一个time的循环，删除表项
    end

//time 2  
always@(posedge clk or negedge rst_n)
begin
    if(~rst_n)
      timer2 <= 0;
    else if( count_1 == COUNT1_UP_LIMIT && count_0 == TIMER_UP_LIMIT && timer2 == LIVE_TIME2)
      timer2 <= 0;
    else if( count_1 == COUNT1_UP_LIMIT && count_0 == TIMER_UP_LIMIT)
      timer2 <= timer2 + 14'd1;
    else 
      timer2 <= timer2;
end
always @ (posedge clk or negedge rst_n)
  if(~rst_n)
    begin
      time_tcpsf <=  14'd0;
    end
  else
    begin
      if(timer2==14'd0)
        time_tcpsf <=  LIVE_TIME2;   
      else
        time_tcpsf <=  timer2 - 14'd1;
    end

//time 3
always@(posedge clk or negedge rst_n)
begin
    if(~rst_n)
      timer3 <= 0;
    else if( count_1 == COUNT1_UP_LIMIT && count_0 == TIMER_UP_LIMIT && timer3 == LIVE_TIME3)
      timer3 <= 0;
    else if( count_1 == COUNT1_UP_LIMIT && count_0 == TIMER_UP_LIMIT)
      timer3 <= timer3 + 17'd1;
    else 
      timer3 <= timer3;
end
always @ (posedge clk or negedge rst_n)
  if(~rst_n)
    begin
      time_tcping <=  17'd0;
    end
  else
    begin
      if(timer3==17'd0)
        time_tcping <=  LIVE_TIME3;   
      else
        time_tcping <=  timer3 - 17'd1;
    end


reg[2:0] state         ;
reg[2:0] next_state    ;
reg[9:0] addr_init     ;  

parameter  IDLE     = 3'b000 ,
           DELETE   = 3'b001 ,
           FINISH   = 3'b010 ,
           ACRELESE = 3'b100 ;
           
//FSM_1  
always @ (posedge clk or negedge rst_n) begin
  if(~rst_n)
    state <=  IDLE;
  else 
    state <=  next_state;
end
//FSM_2  
always @ (*) begin
  case(state)
    IDLE:
        if(active_release)
            next_state = ACRELESE ;
        else
            next_state = DELETE   ;
    DELETE:
        if(active_release)
            next_state = ACRELESE ;
        else
            next_state = FINISH   ;
    ACRELESE:
        next_state = IDLE         ; 
    FINISH:
        if(active_release)
            next_state = ACRELESE ;
        else
            next_state = IDLE     ;
    
    default:
      next_state = IDLE;
  endcase
end


always @ (posedge clk or negedge rst_n)
  if(~rst_n)
    begin
      addr_d    <=  10'd0 ;
      data_d    <=  96'd0 ;
      wren_d    <=   1'b0 ;
    end
  else begin
      case(state)
        IDLE:
          begin
            wren_d <=  1'b0       ;               //开始读取数据
            data_d <=  96'd0      ;
            addr_d <=  addr_init  ;
          end
          //假设100=tcp  ，假设010=udp ，001=icmp；
        DELETE:
          begin
            if((q_d[90]==1'b0)&&(q_d[23:21]!=3'b100)&&(q_d[16:0]==timer1) && (q_d[24]==1'b1))//notcp
              begin     
                wren_d              <= 1'b1      ;   //删除
                data_d              <= 96'd0     ;
                addr_d              <= addr_init ;
              end
            else if((q_d[90]==1'b0)&&(q_d[23:21]==3'b100)&&(q_d[20:19]==2'b10||q_d[18:17]==2'b11)&&(q_d[16:0]==timer2) && (q_d[24]==1'b1))//tcpsf
              begin                               
                wren_d              <= 1'b1      ;   //删除
                data_d              <= 96'd0     ;
                addr_d              <= addr_init ;
              end
            else if((q_d[90]==1'b0)&&(q_d[23:21]==3'b100)&&(q_d[20:19]==2'b11)&&(q_d[16:0]==timer3) && (q_d[24]==1'b1))//tcping
              begin                               
                wren_d              <= 1'b1      ;   //删除
                data_d              <= 96'd0     ;
                addr_d              <= addr_init ;
              end
            else
              begin                                             //不删除
                wren_d <=  1'b0      ;
                data_d <=  96'd0     ;
                addr_d <=  addr_init ;
              end
          end
        ACRELESE:
           begin           
                wren_d   <= 1'b1    ;   //删除
                data_d   <= 96'd0   ;
                addr_d   <= hash_outbound_delete;
           end  
        FINISH:
          begin
            wren_d    <=  1'b0      ;
            data_d    <=  96'd0     ;
            addr_d    <=  addr_init ;
          end

		    default:begin
				    wren_d    <=  1'b0      ;    
				    data_d    <=  96'd0     ;
            addr_d    <=  addr_init ;
      end
      endcase
    end

  always@(posedge clk or negedge rst_n) begin
      if(~rst_n) 
          addr_init <= 10'd0 ;
      else if(next_state == FINISH)
          addr_init <= addr_init + 1'b1 ;
      else 
         addr_init <= addr_init ;
   end
     
  always@(posedge clk or negedge rst_n) begin
      if(~rst_n) begin
         delete_port_wan        <= 16'd0 ;
         release_en             <= 1'b0  ;
      end
    //  else if(state == ACRELESE) begin
    //        delete_ip           <= active_release_ip;
    //        delete_port         <= active_release_port; 
    //        delete_session_type <= active_release_session_type;  
    //        release_en          <= 1'b1;
    //  end
      else if((state == DELETE) && (q_d[24]==1'b1) && (((q_d[23:21]!=3'b100)&&(q_d[16:0]==timer1)) ||
              ((q_d[23:21]==3'b100)&&(q_d[20:19]==2'b10||q_d[18:17]==2'b11)&&(q_d[16:0]==timer2)) || ((q_d[23:21]==3'b100)&&(q_d[20:19]==2'b11||q_d[20:19]==2'b00)&&(q_d[16:0]==timer3)))) begin
          delete_port_wan     <= q_d[40:25] ;
          release_en          <= 1'b1       ;
      end
      else begin
          delete_port_wan     <= delete_port_wan     ;
          release_en          <= 1'b0                ;
      end
    end
endmodule
