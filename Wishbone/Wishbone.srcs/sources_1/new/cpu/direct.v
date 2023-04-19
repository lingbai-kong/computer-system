`timescale 1ns/1ps
module direct(
    input EXE_rf_wena,
    input EXE_rf_DMEM,
    input [4:0] EXE_rf_waddr,
    input [31:0] EXE_rf_wdata,
    input MEM_rf_wena,
    input MEM_rf_DMEM,
    input [4:0] MEM_rf_waddr,
    input [31:0] MEM_rf_wdata,
    input WB_rf_wena,
    input [4:0] WB_rf_waddr,
    input [31:0] WB_rf_wdata,
    input [4:0] rs,
    input [31:0] rdata1,
    input [4:0] rt,
    input [31:0] rdata2,
    input EXE_hi_ena,
    input [31:0] EXE_hi_idata,
    input EXE_lo_ena,
    input [31:0] EXE_lo_idata,
    input MEM_hi_ena,
    input [31:0] MEM_hi_idata,
    input MEM_lo_ena,
    input [31:0] MEM_lo_idata,
    input WB_hi_ena,
    input [31:0] WB_hi_idata,
    input WB_lo_ena,
    input [31:0] WB_lo_idata,
    input [31:0] hi_odata,
    input [31:0] lo_odata,
    output reg [31:0] o_rdata1,
    output reg [31:0] o_rdata2,
    output reg [31:0] o_hi_odata,
    output reg [31:0] o_lo_odata,
    output stall
);
    reg rs_stall;
    reg rt_stall;
    always@(*)
    begin
        if(EXE_rf_wena&&EXE_rf_waddr!=5'd0&&EXE_rf_waddr==rs)
        begin
            if(!EXE_rf_DMEM)
            begin
                rs_stall<=0;
                o_rdata1<=EXE_rf_wdata;
            end
            else
            begin
                rs_stall<=1;
            end
        end
        else if(MEM_rf_wena&&MEM_rf_waddr!=5'd0&&MEM_rf_waddr==rs)
        begin
            rs_stall<=0;
            o_rdata1<=MEM_rf_wdata;
        end
        else if(WB_rf_wena&&WB_rf_waddr!=5'd0&&WB_rf_waddr==rs)
        begin
            rs_stall<=0;
            o_rdata1<=WB_rf_wdata;
        end
        else
        begin
            rs_stall<=0;
            o_rdata1<=rdata1;
        end
        
        if(EXE_rf_wena&&EXE_rf_waddr!=5'd0&&EXE_rf_waddr==rt)
        begin
            if(!EXE_rf_DMEM)
            begin
                rt_stall<=0;
                o_rdata2<=EXE_rf_wdata;
            end
            else
            begin
                rt_stall<=1;
            end
        end
        else if(MEM_rf_wena&&MEM_rf_waddr!=5'd0&&MEM_rf_waddr==rt)
        begin
            rt_stall<=0;
            o_rdata2<=MEM_rf_wdata;
        end
        else if(WB_rf_wena&&WB_rf_waddr!=5'd0&&WB_rf_waddr==rt)
        begin
            rt_stall<=0;
            o_rdata2<=WB_rf_wdata;
        end
        else
        begin
            rt_stall<=0;
            o_rdata2<=rdata2;
        end
    end
    always@(*)
    begin
        if(EXE_hi_ena)
            o_hi_odata<=EXE_hi_idata;
        else if(MEM_hi_ena)
            o_hi_odata<=MEM_hi_idata;
        else if(WB_hi_ena)
            o_hi_odata<=WB_hi_idata;
        else
            o_hi_odata<=hi_odata;
        if(EXE_lo_ena)
            o_lo_odata<=EXE_lo_idata;
        else if(MEM_lo_ena)
            o_lo_odata<=MEM_lo_idata;
        else if(WB_lo_ena)
            o_lo_odata<=WB_lo_idata;
        else
            o_lo_odata<=lo_odata;
    end
    assign stall=rs_stall|rt_stall;
endmodule