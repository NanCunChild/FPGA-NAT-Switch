# =============================================================
# File: upboard.xdc
# Description: NAT 模块上板验证的约束文件
# =============================================================

# -------------------------------------------------------------
# 200 MHz 差分晶振 (BADJ_CLK1_P/N)
# -------------------------------------------------------------
set_property PACKAGE_PIN AV18 [get_ports sys_clk_p]
set_property PACKAGE_PIN AW18 [get_ports sys_clk_n]
set_property IOSTANDARD LVDS  [get_ports sys_clk_p]
set_property IOSTANDARD LVDS  [get_ports sys_clk_n]
create_clock -period 5.000 -name sys_clk [get_ports sys_clk_p]

# -------------------------------------------------------------
# 系统复位按钮
# -------------------------------------------------------------
# 注意：你需要根据板卡手册确定具体的复位按钮引脚和电平极性
# 下面的 XX 是占位符，需要替换为实际引脚
# set_property PACKAGE_PIN <XXX> [get_ports sys_rst]
# set_property IOSTANDARD LVCMOS18 [get_ports sys_rst]

# 如果板子上没有合适的复位按钮，可以暂时把 sys_rst 接地：
# 直接在顶层把 sys_rst 端口删除，复位完全依赖 MMCM 的 locked 信号