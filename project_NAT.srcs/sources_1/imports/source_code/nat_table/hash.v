// `include    "top_define.v"
//crc域计算
// crc10
module hash(
  input   wire         clk                   ,
  input   wire         rst_n                 ,
     
  input   wire         maint_vld             ,
  input   wire  [50:0] outbound_maint        ,
 
  input   wire         lan_vld               ,
  input   wire  [50:0] outbound_lookup       ,
 
  input   wire         wan_vld               ,
  input   wire         active_release        ,
  input   wire  [50:0] outbound_delete       ,
  output  reg          hash_en               ,//正在运行的flag
  output  wire  [9:0]  hash_outbound_maint   ,
  output  wire  [9:0]  hash_outbound_lookup  ,
  output  wire  [9:0]  hash_outbound_delete  
);

reg   [9:0]  crc_reg1 ;
reg   [9:0]  crc_reg2 ;
reg   [9:0]  crc_reg3 ;

reg   [9:0]  hash_outbound_maint_reg10  ;
reg   [9:0]  hash_outbound_lookup_reg10 ;
reg   [9:0]  hash_outbound_delete_reg10 ;


assign hash_outbound_maint   = hash_outbound_maint_reg10  ;
assign hash_outbound_lookup  = hash_outbound_lookup_reg10 ;
assign hash_outbound_delete  = hash_outbound_delete_reg10 ;

/**************************************CRC51并行计算，数据位宽51***********************************************************************/
// polynomial: x^10 + x^9 + x^5 + x^4 + x^1 + 1
// data width: 51
// convention: the first serial bit is D[50]
function [9:0] CRC51_D10;

  input [50:0] Data;
  input [9:0] crc;
  reg [50:0] d;
  reg [9:0] c;
  reg [9:0] newcrc;
begin
  d = Data;
  c = crc;

  newcrc[0] = d[49] ^ d[46] ^ d[42] ^ d[41] ^ d[39] ^ d[37] ^ d[36] ^ d[34] ^ d[33] ^ d[32] ^ d[31] ^ d[30] ^ d[28] ^ d[27] ^ d[24] ^ d[23] ^ d[19] ^ d[17] ^ d[16] ^ d[15] ^ d[9] ^ d[4] ^ d[3] ^ d[2] ^ d[1] ^ d[0] ^ c[0] ^ c[1] ^ c[5] ^ c[8];
  newcrc[1] = d[50] ^ d[49] ^ d[47] ^ d[46] ^ d[43] ^ d[41] ^ d[40] ^ d[39] ^ d[38] ^ d[36] ^ d[35] ^ d[30] ^ d[29] ^ d[27] ^ d[25] ^ d[23] ^ d[20] ^ d[19] ^ d[18] ^ d[15] ^ d[10] ^ d[9] ^ d[5] ^ d[0] ^ c[0] ^ c[2] ^ c[5] ^ c[6] ^ c[8] ^ c[9];
  newcrc[2] = d[50] ^ d[48] ^ d[47] ^ d[44] ^ d[42] ^ d[41] ^ d[40] ^ d[39] ^ d[37] ^ d[36] ^ d[31] ^ d[30] ^ d[28] ^ d[26] ^ d[24] ^ d[21] ^ d[20] ^ d[19] ^ d[16] ^ d[11] ^ d[10] ^ d[6] ^ d[1] ^ c[0] ^ c[1] ^ c[3] ^ c[6] ^ c[7] ^ c[9];
  newcrc[3] = d[49] ^ d[48] ^ d[45] ^ d[43] ^ d[42] ^ d[41] ^ d[40] ^ d[38] ^ d[37] ^ d[32] ^ d[31] ^ d[29] ^ d[27] ^ d[25] ^ d[22] ^ d[21] ^ d[20] ^ d[17] ^ d[12] ^ d[11] ^ d[7] ^ d[2] ^ c[0] ^ c[1] ^ c[2] ^ c[4] ^ c[7] ^ c[8];
  newcrc[4] = d[50] ^ d[44] ^ d[43] ^ d[38] ^ d[37] ^ d[36] ^ d[34] ^ d[31] ^ d[27] ^ d[26] ^ d[24] ^ d[22] ^ d[21] ^ d[19] ^ d[18] ^ d[17] ^ d[16] ^ d[15] ^ d[13] ^ d[12] ^ d[9] ^ d[8] ^ d[4] ^ d[2] ^ d[1] ^ d[0] ^ c[2] ^ c[3] ^ c[9];
  newcrc[5] = d[49] ^ d[46] ^ d[45] ^ d[44] ^ d[42] ^ d[41] ^ d[38] ^ d[36] ^ d[35] ^ d[34] ^ d[33] ^ d[31] ^ d[30] ^ d[25] ^ d[24] ^ d[22] ^ d[20] ^ d[18] ^ d[15] ^ d[14] ^ d[13] ^ d[10] ^ d[5] ^ d[4] ^ d[0] ^ c[0] ^ c[1] ^ c[3] ^ c[4] ^ c[5] ^ c[8];
  newcrc[6] = d[50] ^ d[47] ^ d[46] ^ d[45] ^ d[43] ^ d[42] ^ d[39] ^ d[37] ^ d[36] ^ d[35] ^ d[34] ^ d[32] ^ d[31] ^ d[26] ^ d[25] ^ d[23] ^ d[21] ^ d[19] ^ d[16] ^ d[15] ^ d[14] ^ d[11] ^ d[6] ^ d[5] ^ d[1] ^ c[1] ^ c[2] ^ c[4] ^ c[5] ^ c[6] ^ c[9];
  newcrc[7] = d[48] ^ d[47] ^ d[46] ^ d[44] ^ d[43] ^ d[40] ^ d[38] ^ d[37] ^ d[36] ^ d[35] ^ d[33] ^ d[32] ^ d[27] ^ d[26] ^ d[24] ^ d[22] ^ d[20] ^ d[17] ^ d[16] ^ d[15] ^ d[12] ^ d[7] ^ d[6] ^ d[2] ^ c[2] ^ c[3] ^ c[5] ^ c[6] ^ c[7];
  newcrc[8] = d[49] ^ d[48] ^ d[47] ^ d[45] ^ d[44] ^ d[41] ^ d[39] ^ d[38] ^ d[37] ^ d[36] ^ d[34] ^ d[33] ^ d[28] ^ d[27] ^ d[25] ^ d[23] ^ d[21] ^ d[18] ^ d[17] ^ d[16] ^ d[13] ^ d[8] ^ d[7] ^ d[3] ^ c[0] ^ c[3] ^ c[4] ^ c[6] ^ c[7] ^ c[8];
  newcrc[9] = d[50] ^ d[48] ^ d[45] ^ d[41] ^ d[40] ^ d[38] ^ d[36] ^ d[35] ^ d[33] ^ d[32] ^ d[31] ^ d[30] ^ d[29] ^ d[27] ^ d[26] ^ d[23] ^ d[22] ^ d[18] ^ d[16] ^ d[15] ^ d[14] ^ d[8] ^ d[3] ^ d[2] ^ d[1] ^ d[0] ^ c[0] ^ c[4] ^ c[7] ^ c[9];
  CRC51_D10 = newcrc;
end
endfunction

always @(posedge clk or negedge rst_n) begin
  if(~rst_n)
      hash_en  <= 1'b0 ;
  else if(maint_vld || lan_vld || active_release)
      hash_en  <= 1'b1 ;
  else
      hash_en  <= 1'b0 ;
end

always @(posedge clk or negedge rst_n) begin
  if(~rst_n) begin
    crc_reg1                   <= 10'h3ff ;
    hash_outbound_maint_reg10  <= 10'b0   ;
  end
  else if(maint_vld) begin
    crc_reg1                   <= 10'h3ff ;
    hash_outbound_maint_reg10  <= CRC51_D10(outbound_maint,crc_reg1);
  end
  else begin
    crc_reg1                   <= 10'h3ff ;
    hash_outbound_maint_reg10  <= hash_outbound_maint_reg10   ;
  end
end
  
always @(posedge clk or negedge rst_n) begin
  if(~rst_n) begin
    crc_reg2                   <= 10'h3ff ;
    hash_outbound_lookup_reg10 <= 10'b0   ;
  end
  else if(lan_vld) begin
    crc_reg2                   <= 10'h3ff ;
    hash_outbound_lookup_reg10 <= CRC51_D10(outbound_lookup,crc_reg2);
  end
  else begin
    crc_reg2                   <= 10'h3ff ;
    hash_outbound_lookup_reg10 <= hash_outbound_lookup_reg10 ;
  end
end

always @(posedge clk or negedge rst_n) begin
  if(~rst_n) begin
    crc_reg3     <= 10'h3ff ;
    hash_outbound_delete_reg10 <= 10'b0 ;
  end
  else if (active_release) begin
    crc_reg3                    <= 10'h3ff ;
    hash_outbound_delete_reg10  <= CRC51_D10(outbound_delete,crc_reg3);
  end
  else begin
    crc_reg3                   <= 10'h3ff ;
    hash_outbound_delete_reg10 <= hash_outbound_delete_reg10  ;
  end
end

endmodule
