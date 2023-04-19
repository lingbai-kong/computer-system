`timescale 1ns / 1ps
//2021.4.4修复了大端小端的错误
//2021.5.13重新恢复了大端模式
//2021.5.13增加了sel
module cpmem(
    input [3:0] data_type,
    input [31:0] exact_addr,
    output [31:0] appr_addr,
    output reg [31:0] rdata32,
    output reg [15:0] rdata16,
    output reg [7:0] rdata8,
    input [31:0] rdata,
    input [31:0] wdata32,
    input [15:0] wdata16,
    input [7:0] wdata8,
    output reg [31:0] wdata,
    output reg [3:0] sel
);
    wire [1:0] offset;
    assign offset = exact_addr[1:0];
    assign appr_addr = exact_addr & 32'hfffffffc;
    parameter Wdata=4'd0,Hdata=4'd1,Bdata=4'd2,Ldata=4'd3,Rdata=4'd4;
    always@(*)
    begin
        case(data_type)
        //big-endian
        Wdata:begin
            sel<=4'b1111;
            rdata32<=rdata;
            wdata<=wdata32;
        end
        Hdata:begin
            case(offset)
            2'b00:begin
                sel<=4'b1100;
                rdata16<=rdata[31:16];
                wdata<={wdata16,16'b0};
            end
            2'b10:begin
                sel<=4'b0011;
                rdata16<=rdata[15:0];
                wdata<={16'b0,wdata16};
            end
            endcase
        end
        Bdata:begin
            case(offset)
            2'b00:begin
                sel<=4'b1000;
                rdata8<=rdata[31:24];
                wdata<={wdata8,24'b0};
            end
            2'b01:begin
                sel<=4'b0100;
                rdata8<=rdata[23:16];
                wdata<={8'b0,wdata8,16'b0};
            end
            2'b10:begin
                sel<=4'b0010;
                rdata8<=rdata[15:8];
                wdata<={16'b0,wdata8,8'b0};
            end
            2'b11:begin
                sel<=4'b0001;
                rdata8<=rdata[7:0];
                wdata<={24'b0,wdata8};
            end
            endcase
        end
        Ldata:begin
            case(offset)
            2'b00:begin
                sel<=4'b1111;
                rdata32<=rdata;
                wdata<=wdata32;
            end
            2'b01:begin
                sel<=4'b0111;
                rdata32<={rdata[23:0],wdata32[7:0]};
                wdata<={8'b0,wdata32[31:8]};
            end
            2'b10:begin
                sel<=4'b0011;
                rdata32<={rdata[15:0],wdata32[15:0]};
                wdata<={16'b0,wdata32[31:16]};
            end
            2'b11:begin
                sel<=4'b0001;
                rdata32<={rdata[7:0],wdata32[23:0]};
                wdata<={24'b0,wdata32[31:24]};
            end
            endcase
        end
        Rdata:begin
            case(offset)
            2'b00:begin
                sel<=4'b1000;
                rdata32<={wdata32[31:8],rdata[31:24]};
                wdata<={wdata32[7:0],24'b0};
            end
            2'b01:begin
                sel<=4'b1100;
                rdata32<={wdata32[31:16],rdata[31:16]};
                wdata<={wdata32[15:0],16'b0};
            end
            2'b10:begin
                sel<=4'b1110;
                rdata32<={wdata32[31:24],rdata[31:8]};
                wdata<={wdata32[23:0],8'b0};
            end
            2'b11:begin
                sel<=4'b1111;
                rdata32<=rdata;
                wdata<=wdata32;
            end
            endcase
        end
        endcase
    end
endmodule