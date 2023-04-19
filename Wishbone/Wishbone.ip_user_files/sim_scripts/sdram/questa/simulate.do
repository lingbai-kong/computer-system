onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib sdram_opt

do {wave.do}

view wave
view structure
view signals

do {sdram.udo}

run -all

quit -force
