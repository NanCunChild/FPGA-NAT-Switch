// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.1 (win64) Build 6140274 Thu May 22 00:12:29 MDT 2025
// Date        : Sun Mar  8 13:22:26 2026
// Host        : WINServ25 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top blk_mem_gen_3 -prefix
//               blk_mem_gen_3_ blk_mem_gen_2_sim_netlist.v
// Design      : blk_mem_gen_2
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7vx485tffg1157-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "blk_mem_gen_2,blk_mem_gen_v8_4_11,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_11,Vivado 2025.1" *) 
(* NotValidForBitStream *)
module blk_mem_gen_3
   (clka,
    ena,
    wea,
    addra,
    dina,
    douta);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_mode = "slave BRAM_PORTA" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_ADDRESS_MODE BYTE_ADDRESS, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN" *) input ena;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [0:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [3:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [15:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [15:0]douta;

  wire [3:0]addra;
  wire clka;
  wire [15:0]dina;
  wire [15:0]douta;
  wire ena;
  wire [0:0]wea;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_rsta_busy_UNCONNECTED;
  wire NLW_U0_rstb_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [15:0]NLW_U0_doutb_UNCONNECTED;
  wire [3:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [15:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "4" *) 
  (* C_ADDRB_WIDTH = "4" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "1" *) 
  (* C_COUNT_36K_BRAM = "0" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "0" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "0" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     2.87285 mW" *) 
  (* C_FAMILY = "virtex7" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "1" *) 
  (* C_HAS_ENB = "0" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "1" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "0" *) 
  (* C_HAS_RSTB = "0" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "blk_mem_gen_2.mem" *) 
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
  (* C_MEM_TYPE = "0" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "16" *) 
  (* C_READ_DEPTH_B = "16" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "16" *) 
  (* C_READ_WIDTH_B = "16" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "0" *) 
  (* C_USE_BYTE_WEA = "0" *) 
  (* C_USE_BYTE_WEB = "0" *) 
  (* C_USE_DEFAULT_DATA = "0" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "1" *) 
  (* C_WEB_WIDTH = "1" *) 
  (* C_WRITE_DEPTH_A = "16" *) 
  (* C_WRITE_DEPTH_B = "16" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "16" *) 
  (* C_WRITE_WIDTH_B = "16" *) 
  (* C_XDEVICEFAMILY = "virtex7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  blk_mem_gen_3_blk_mem_gen_v8_4_11 U0
       (.addra(addra),
        .addrb({1'b0,1'b0,1'b0,1'b0}),
        .clka(clka),
        .clkb(1'b0),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(douta),
        .doutb(NLW_U0_doutb_UNCONNECTED[15:0]),
        .eccpipece(1'b0),
        .ena(ena),
        .enb(1'b0),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[3:0]),
        .regcea(1'b1),
        .regceb(1'b1),
        .rsta(1'b0),
        .rsta_busy(NLW_U0_rsta_busy_UNCONNECTED),
        .rstb(1'b0),
        .rstb_busy(NLW_U0_rstb_busy_UNCONNECTED),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[3:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[15:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb(1'b0),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(wea),
        .web(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2025.1"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
gydSV72FvW4hnoyUt6yZFJHfJqjRQWPUfYIuDKP0fpjrPOkLRbJGBr4Z9msYTvoIHRlYtXJ2YMY0
d1TIQb+FK4gKsTRru9wr397OxuFBsTRf4e+ZjpYZEdsnqYWcgMSzhN4yhPvO06GyZO15y/LKBxa8
3OKwxVlOLYXhv+sxdXg=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
WHB6Zbfa5Qi47krP9T4L8UnPOlr881dWx7UcYaZfNGIQQM0gadcoXbhucIpRaUuyOKxv6yhKveRN
h0l+N9+KX6rbZ6+TRhP9JAMuPhlpI7T42QtRv5zx9+m3ct5S0NMszbFaK8zeTAYra5BGP7BHmtkr
MpKfLK5sFyaTE/A7ACtAace9MwFTHDZdl9uUs4aY6KJlm6GaypKduiqkNugukJp5vlFPX/ZapJqG
KMtMhI6grhcuYb1FJrwRZ4jW7hs9HxddSdGLzsZ0HsBcO/qaCPTst+ZA0YIQfd5ULlFmPqq39FfO
p1P+2hEH2n+LycbMj5cn4Dxfqv2R8eucM78R3w==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
SmAzQA1VEuJXtJi5vXa2Jg7YvRqAJs6PX9HTZ1YqrJw4VfonBW3726gJ81BjlizpMkcf/Uk5sFIK
aPedVhEs4xCIZylz7gXYDshtytOA/pXUID2qV9nXr8qfI+FydSADUF3ScYDZmlkclFqlZrGq6DQ7
da3lJAzt2h/iR+cczrA=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
iAph5JWb/chMQpLPX1UoLjQDxN5l2I8McM/k2xN5wRht7HXoE6F5yV8luDjn3zkI6vnfUYo7BaI1
mogRRx+R3XcwxvhHr+lngh4+/YLVex1TFncl+kiUMAsu3M/FjFSiqGMVMdKTNLDqr35DuZJVyuiF
lTwXob/KkbQDJiJjBEoxbt+968rKRKRyJGcqIjm4mqRBdqMcgo3HOJFG74SFsWAQrxvXfBhdLSG3
OfoLfls9XDojBjp7G83k0h82g1eeWgBfydm/OcX9o48Pst93NvI4ua8WShZL8MCvRWYqWZrrjrWi
cfUjXAF5SDACjq1/OU6arz/Idz6/a7AP/jmexw==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
BY49GZBxBT/gjZDPyaSWlti/sctckoR7jK6NuWdhnF9tiyNfVU7BqjjwxSnyMi0Uucv1BKHXC18h
8hQbFWnNtrq71ilURotXux7sssHlVJ2i1CsJWU18DOcBWxm2ai89uwvxDJh3TJkBJixB5KPvsDhL
lWOjTvZWPoR+Ixy+Tzo+U5Vx7z7SOakRwTrn3u7+c3vmCEBphE+HKeJExhBAoOEd0SXK5iwXaByW
D7Wb7zq6NNUmnCyaJ2BG9kGxLVsf+md7SlocuaFsYyaRZhwPyTucxIlz1tLYwcytKzx0ovoax3no
nYgzlzP/F0/PDWk9BqXgr/tuclc4EZYX0cf4ng==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2025.1-2029.x", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
qGnCvL35qO7cbUEKCL50yDv1UvezcqBz601zctKop1954QlcjemzZWZHg1zJ00nJaToNdH2S8AKX
n8hNJvbQ+x5HEGL5DoSU9m5qjXd8xxocnZ0yzuZX/dGCT8kDn3gWJR2Gz13pT+w2LQUno1fX+MsC
ehgwvjBBT6GeYjdxHi+aybQUP9AblSxX/z3vh857SGCPohEWvghOgORCHAe45YD+ZWnL62FLxMM2
c+Ozq/Au/Q4q1Yzlzcfv8Mnsvg7OqOeEamQHbuYOfdkJUuYqOwsskEWW348u7FXtsf8m7P3pZyyz
IWyTDAW4igGguMPLHfbtK/twZx8ScJQmOKzglg==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Hz+6K8+wh5/fukU4ZWNDXGsq6hreSVCSPP67nA6kUz9Vpjy4TtTnOrrl1BWY0ivEC7Ldyw8VI60A
VO/WPlt409LdAZdMZGsEZ1JuTZ0m9LPcgu9CPCyoMECctmd8LHE+otY6etTmYABB9syY61rk2hrv
RgbcyT/HCK9TzWxSm+XMqvx2nvagCLkMDPh/JZv51fj2zcKaBPnxsz8rnDipaeo0fEyVRC3Y1F/V
U3RmXojBjIumPHSJkQ537dENJEIA0Ra65u8EM/+ItUn1bcryLcIbKy1xGadrHmHdHRUoRcAodO2C
B48bNVeL0VnGg8P9ACIB04lMNzn5p6A1tPOb4Q==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
YDpb+UeT0rJ543Q8wCo2xSS3gpVAT+JoStgBlV5IMjJoUOWkiOPn691FGChmDi3BTq5NxC73KHHR
1galACCjeTGq6cv+0Zc2Ocm1oobdrnSPHp7TMDr5Zle8FX6WywJCiGdoWBODggZSlbOASIK/PVfY
cZM2z60M6RSvzsi3TnYHiKYHpju8THVoSgRd6r31GcbiSy9TjjARERXan0OVc79jGuAg90mmDEEq
91eqmn6NZ9yLI2fgBjFUZbtFCpmJ8WGxOL1h39niWnRK3ZXnk8jcpnZUlxLbYTPO0Z3vVr1zrvcn
RVQloU0OLqg7M95zSs7NtX5Vzvb6jGbMehWV+WMMyxWmxL2XOwsAwPSeX2dI2r77pioY7X6VzH7f
/JxMAnq9udra3WGPsUkD1G0CvPkCC3zdxjpVaflY37ztX9UONhKtzMQa8lJc1IL8GhXRY3R9Lg2c
HIeXSGkpNNuFDqKT6Khe/6Casq+SjFJq+IH9IUtz6RUZTkbFb0Xhgm2P

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Q+63zFEYw/LeMgxa7g8g79GGvSyIKDKD8RvvC4DHDQuGObf6n9OGZX4e17v/E/+EDEwUhsWQHFDI
Lp/aH+6fNRmhu9BEWVjxq2WRrQSl4eQjfIaSOXu2dlYh3JjRJwiUp4LteVh8RFAf5t5sRQO4dRIK
x+h28yliSgibaWEAv5FaJQ1EFbNwmgedAaSYjgf2A3afBUcBh5Uy9VHbW/zRzdhhJdsVNBjZYcFy
CVLOcf1toCRp8J4U5FlnFMOzFegUbdXFQhq2VmIhPRxWjrfTk6iR4BcMEN9UMij/5IHRAeBdksyD
CqEKsyFxosbI5KVMRZ1Ln75Zipn0JdsGekHkxg==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
DPUa5DLPYRWvbPnX0U412yoWvvvHyuq43DrYmDJGTK0cR5U4U6th8icYgizC1/hUAEzt19kM/hVa
zZh7bXSWACYLpcfhPY8dRTVGDZVjpbkraw0ceBryLP7jc6Jt5JdNw88tZtZpprCB7nQ25lUL82Hf
WTwL1ZqgGIvtfHhxO0JF5L5ES5giedwQ6u5ffXG3UB6ELcpQD1NvpW5lAz4mfXyvVDCAPZN581TF
tlAy79iKbPKlJ2zFn1BS2cuRIHHe2JRxwPo+0n5VD5CXVgg+lCYxTnCxI8CdyFaTumbs4IfAKwVI
wSN/btbwDUhW9hAHWHIRo+BpdJ4qeGcTDPKtsA==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
mf5hcf6JE6yLm0jNCQnHMVmogjLlPz6re0FwG67yvOJ3FuEorru0emIeAKEwgOoxjUYNWvcM7QAH
/UEeB2EIdjLl6glPAUda0HjtaCU2rdncVdM8k6DSMBggc4yo18Qx5F+1TD/RoBgoo0jNkMdDy6wJ
JHjqlN+R01z3yYIMQ9f2z6ZaYncbBYEp4+YAb7g1D7CSMxP5cFRpQznRpYp0JwqJfT9CHzlKgdab
8B288NxeLM66iYodiTS+GSRGLGtDWXpz9yeiuiPe6kJxae2GJyHIMSfluO/0Slc3m24DQNdbojf8
jdc0G2UnrDe5mCUTfYiDmpOWTUJOdYo0FK0N2g==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 19968)
`pragma protect data_block
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
J3qHcXdVL+F+VP5pKRJijVXD
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
