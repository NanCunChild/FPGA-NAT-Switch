// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.1 (win64) Build 6140274 Thu May 22 00:12:29 MDT 2025
// Date        : Sun Mar  8 18:52:59 2026
// Host        : WINServ25 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top blk_mem_gen_5 -prefix
//               blk_mem_gen_5_ blk_mem_gen_4_sim_netlist.v
// Design      : blk_mem_gen_4
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7vx485tffg1157-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "blk_mem_gen_4,blk_mem_gen_v8_4_11,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_11,Vivado 2025.1" *) 
(* NotValidForBitStream *)
module blk_mem_gen_5
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
  blk_mem_gen_5_blk_mem_gen_v8_4_11 U0
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
uyhbFZ/wF8Pfrdpr0+riM7hT
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
