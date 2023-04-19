-makelib xcelium_lib/xpm -sv \
  "M:/Xilinx/Vivado/2020.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
-endlib
-makelib xcelium_lib/xpm \
  "M:/Xilinx/Vivado/2020.2/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib xcelium_lib/dist_mem_gen_v8_0_13 \
  "../../../ipstatic/simulation/dist_mem_gen_v8_0.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../../Wishbone.gen/sources_1/ip/sd_buf/sim/sd_buf.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib

