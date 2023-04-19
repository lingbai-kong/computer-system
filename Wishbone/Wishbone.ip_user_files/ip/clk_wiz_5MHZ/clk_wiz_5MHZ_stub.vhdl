-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
-- Date        : Thu May 13 21:01:33 2021
-- Host        : kPC running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               g:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.gen/sources_1/ip/clk_wiz_5MHZ/clk_wiz_5MHZ_stub.vhdl
-- Design      : clk_wiz_5MHZ
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a100tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clk_wiz_5MHZ is
  Port ( 
    clk_out : out STD_LOGIC;
    clk_in : in STD_LOGIC
  );

end clk_wiz_5MHZ;

architecture stub of clk_wiz_5MHZ is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_out,clk_in";
begin
end;
