// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.1 (win64) Build 6140274 Thu May 22 00:12:29 MDT 2025
// Date        : Sun Mar  8 13:22:28 2026
// Host        : WINServ25 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/Users/Administrator/project_NAT/project_NAT.gen/sources_1/ip/blk_mem_gen_2/blk_mem_gen_2_sim_netlist.v
// Design      : blk_mem_gen_2
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7vx485tffg1157-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "blk_mem_gen_2,blk_mem_gen_v8_4_11,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_11,Vivado 2025.1" *) 
(* NotValidForBitStream *)
module blk_mem_gen_2
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
  blk_mem_gen_2_blk_mem_gen_v8_4_11 U0
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 20256)
`pragma protect data_block
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
rzzDduG8f86lD82nxKpOxt6NEDHQ
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
