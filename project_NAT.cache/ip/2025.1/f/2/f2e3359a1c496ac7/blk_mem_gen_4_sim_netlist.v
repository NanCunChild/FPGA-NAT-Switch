// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.1 (win64) Build 6140274 Thu May 22 00:12:29 MDT 2025
// Date        : Sun Mar  8 18:52:59 2026
// Host        : WINServ25 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ blk_mem_gen_4_sim_netlist.v
// Design      : blk_mem_gen_4
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7vx485tffg1157-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "blk_mem_gen_4,blk_mem_gen_v8_4_11,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_11,Vivado 2025.1" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
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
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_blk_mem_gen_v8_4_11 U0
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 20272)
`pragma protect data_block
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
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
