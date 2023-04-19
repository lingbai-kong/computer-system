vlib work
vlib riviera

vlib riviera/xpm
vlib riviera/xil_defaultlib

vmap xpm riviera/xpm
vmap xil_defaultlib riviera/xil_defaultlib

vlog -work xpm  -sv2k12 "+incdir+../../../ipstatic" \
"M:/Xilinx/Vivado/2020.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -93 \
"M:/Xilinx/Vivado/2020.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../ipstatic" \
"../../../../Wishbone.gen/sources_1/ip/clk_wiz_25MHZ/clk_wiz_25MHZ_clk_wiz.v" \
"../../../../Wishbone.gen/sources_1/ip/clk_wiz_25MHZ/clk_wiz_25MHZ.v" \

vlog -work xil_defaultlib \
"glbl.v"

