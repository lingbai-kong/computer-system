onbreak {quit -force}
onerror {quit -force}

asim +access +r +m+sdram -L xpm -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.sdram xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {sdram.udo}

run -all

endsim

quit -force
