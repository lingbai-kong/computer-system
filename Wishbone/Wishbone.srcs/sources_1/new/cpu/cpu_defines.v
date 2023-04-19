//`define MARS
`ifdef MARS
`define IMEM_ADDR 32'h00400000
`define IMEM_addr_corr 32'h30000000-32'h00400000
`define DMEM_addr_corr 32'h10010000
`else
`define IMEM_ADDR 32'h30000000
`define IMEM_addr_corr 32'h0
`define DMEM_addr_corr 32'h0
`define delay_slot
`endif