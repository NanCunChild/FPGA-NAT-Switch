# 主时钟约束：100 MHz，周期 10 ns，占空比 50%
#create_clock -period 10.000 -name clk -waveform {0.000 5.000} [get_ports clk]

# 千兆尝试，计划先尝试100MHz之后总结
create_clock -period 8.000 -name clk -waveform {0.000 4.000} [get_ports clk]