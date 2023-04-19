-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
-- Date        : Thu May 20 18:08:39 2021
-- Host        : kPC running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               g:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.gen/sources_1/ip/clk_wiz_200MHZ/clk_wiz_200MHZ_stub.vhdl
-- Design      : clk_wiz_200MHZ
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a100tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clk_wiz_200MHZ is
  Port ( 
    clk_out : out STD_LOGIC;
    reset : in STD_LOGIC;
    locked : out STD_LOGIC;
    clk_in : in STD_LOGIC
  );

end clk_wiz_200MHZ;

architecture stub of clk_wiz_200MHZ is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_out,reset,locked,clk_in";
begin
end;
