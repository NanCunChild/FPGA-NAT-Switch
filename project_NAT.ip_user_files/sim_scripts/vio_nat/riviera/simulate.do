transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

asim +access +r +m+vio_nat  -L xil_defaultlib -L xpm -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.vio_nat xil_defaultlib.glbl

do {vio_nat.udo}

run 1000ns

endsim

quit -force
