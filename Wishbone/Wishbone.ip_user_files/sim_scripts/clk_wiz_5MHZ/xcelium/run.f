-makelib xcelium_lib/xpm -sv \
  "M:/Xilinx/Vivado/2020.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
-endlib
-makelib xcelium_lib/xpm \
  "M:/Xilinx/Vivado/2020.2/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../../Wishbone.gen/sources_1/ip/clk_wiz_5MHZ/clk_wiz_5MHZ_clk_wiz.v" \
  "../../../../Wishbone.gen/sources_1/ip/clk_wiz_5MHZ/clk_wiz_5MHZ.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib
