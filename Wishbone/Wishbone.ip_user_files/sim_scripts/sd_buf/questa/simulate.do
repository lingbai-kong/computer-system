onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib sd_buf_opt

do {wave.do}

view wave
view structure
view signals

do {sd_buf.udo}

run -all

quit -force
