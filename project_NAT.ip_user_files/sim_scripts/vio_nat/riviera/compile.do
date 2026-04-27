transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vlib riviera/xpm
vlib riviera/xil_defaultlib

vmap xpm riviera/xpm
vmap xil_defaultlib riviera/xil_defaultlib

vlog -work xpm  -incr "+incdir+../../../../../../../Xilinx/2025.2/data/rsb/busdef" "+incdir+../../../../project_NAT.gen/sources_1/ip/vio_nat/hdl/verilog" "+incdir+../../../../project_NAT.gen/sources_1/ip/vio_nat/hdl" -l xpm -l xil_defaultlib \
"/home/nancunchild/Xilinx/2025.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"/home/nancunchild/Xilinx/2025.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93  -incr \
"/home/nancunchild/Xilinx/2025.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../../../../Xilinx/2025.2/data/rsb/busdef" "+incdir+../../../../project_NAT.gen/sources_1/ip/vio_nat/hdl/verilog" "+incdir+../../../../project_NAT.gen/sources_1/ip/vio_nat/hdl" -l xpm -l xil_defaultlib \
"../../../../project_NAT.gen/sources_1/ip/vio_nat/sim/vio_nat.v" \

vlog -work xil_defaultlib \
"glbl.v"

