onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib clk_wiz_200MHZ_opt

do {wave.do}

view wave
view structure
view signals

do {clk_wiz_200MHZ.udo}

run -all

quit -force
