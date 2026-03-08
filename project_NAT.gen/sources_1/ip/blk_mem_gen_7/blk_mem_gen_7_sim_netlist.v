// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.1 (win64) Build 6140274 Thu May 22 00:12:29 MDT 2025
// Date        : Sun Mar  8 18:52:59 2026
// Host        : WINServ25 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top blk_mem_gen_7 -prefix
//               blk_mem_gen_7_ blk_mem_gen_4_sim_netlist.v
// Design      : blk_mem_gen_4
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7vx485tffg1157-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "blk_mem_gen_4,blk_mem_gen_v8_4_11,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_11,Vivado 2025.1" *) 
(* NotValidForBitStream *)
module blk_mem_gen_7
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
  blk_mem_gen_7_blk_mem_gen_v8_4_11 U0
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
QvjlUrRPXaHhe3zTzS15yU/P
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
