// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.1 (win64) Build 6140274 Thu May 22 00:12:29 MDT 2025
// Date        : Sun Mar  8 18:53:00 2026
// Host        : WINServ25 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/Users/Administrator/project_NAT/project_NAT.gen/sources_1/ip/blk_mem_gen_4/blk_mem_gen_4_sim_netlist.v
// Design      : blk_mem_gen_4
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7vx485tffg1157-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "blk_mem_gen_4,blk_mem_gen_v8_4_11,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_11,Vivado 2025.1" *) 
(* NotValidForBitStream *)
module blk_mem_gen_4
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
  (* C_INIT_FILE = "blk_mem_gen_4.mem" *) 
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
  blk_mem_gen_4_blk_mem_gen_v8_4_11 U0
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
OszrUybZRcXEunLZ2qNY00oqSRYq
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
