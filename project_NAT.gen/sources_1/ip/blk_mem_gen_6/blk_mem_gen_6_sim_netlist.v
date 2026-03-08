// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.1 (win64) Build 6140274 Thu May 22 00:12:29 MDT 2025
// Date        : Sun Mar  8 18:52:59 2026
// Host        : WINServ25 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top blk_mem_gen_6 -prefix
//               blk_mem_gen_6_ blk_mem_gen_4_sim_netlist.v
// Design      : blk_mem_gen_4
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7vx485tffg1157-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "blk_mem_gen_4,blk_mem_gen_v8_4_11,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_11,Vivado 2025.1" *) 
(* NotValidForBitStream *)
module blk_mem_gen_6
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
  blk_mem_gen_6_blk_mem_gen_v8_4_11 U0
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
TyTIuEbylxbK1vwuDDlaWDnA
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
