# =============================================================
# upboard.xdc - NAT 模块上板验证约束
# 目标器件: xcvu13p-fhgb2104-2-i
# =============================================================

# 200 MHz 差分晶振 (BADJ_CLK1_P/N)
set_property PACKAGE_PIN AV18 [get_ports sys_clk_p]
set_property PACKAGE_PIN AW18 [get_ports sys_clk_n]
set_property IOSTANDARD LVDS  [get_ports sys_clk_p]
set_property IOSTANDARD LVDS  [get_ports sys_clk_n]
create_clock -period 5.000 -name sys_clk [get_ports sys_clk_p]