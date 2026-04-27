vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xpm
vlib modelsim_lib/msim/xil_defaultlib

vmap xpm modelsim_lib/msim/xpm
vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xpm -64 -incr -mfcu  -sv "+incdir+../../../../../../../Xilinx/2025.2/data/rsb/busdef" "+incdir+../../../../project_NAT.gen/sources_1/ip/vio_nat/hdl/verilog" "+incdir+../../../../project_NAT.gen/sources_1/ip/vio_nat/hdl" \
"/home/nancunchild/Xilinx/2025.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"/home/nancunchild/Xilinx/2025.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -64 -93  \
"/home/nancunchild/Xilinx/2025.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib -64 -incr -mfcu  "+incdir+../../../../../../../Xilinx/2025.2/data/rsb/busdef" "+incdir+../../../../project_NAT.gen/sources_1/ip/vio_nat/hdl/verilog" "+incdir+../../../../project_NAT.gen/sources_1/ip/vio_nat/hdl" \
"../../../../project_NAT.gen/sources_1/ip/vio_nat/sim/vio_nat.v" \

vlog -work xil_defaultlib \
"glbl.v"

