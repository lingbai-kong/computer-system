`timescale 1ns / 1ps
module decoder(
    input [31:0] inst,
    output [4:0] rs,
    output [4:0] rt,
    output [4:0] rd,
    output [4:0] shamt,
    output [15:0] immediate,
    output [25:0] address,
    output reg [7:0] out
    );
    assign rs = inst[25:21];
    assign rt = inst[20:16];
    assign rd = inst[15:11];
    assign shamt = inst[10:6];
    assign immediate = inst[15:0];
    assign address = inst[25:0];
    assign base = inst[25:21];
    assign offset = inst[15:0];
    
    parameter ADD=8'd1,ADDU=8'd2,SUB=8'd3,SUBU=8'd4,AND=8'd5,OR=8'd6,XOR=8'd7,NOR=8'd8,SLT=8'd9,SLTU=8'd10,SLL=8'd11,SRL=8'd12,SRA=8'd13,SLLV=8'd14,SRLV=8'd15,SRAV=8'd16,JR=8'd17,
    ADDI=8'd18,ADDIU=8'd19,ANDI=8'd20,ORI=8'd21,XORI=8'd22,LW=8'd23,SW=8'd24,BEQ=8'd25,BNE=8'd26,SLTI=8'd27,SLTIU=8'd28,LUI=8'd29,J=8'd30,JAL=8'd31,
    
    DIV=8'd32,DIVU=8'd33,MULT=8'd34,MULTU=8'd35,BGEZ=8'd36,JALR=8'd37,LBU=8'd38,LHU=8'd39,LB=8'd40,LH=8'd41,SB=8'd42,SH=8'd43,BREAK=8'd44,SYSCALL=8'd45,ERET=8'd46,MFHI=8'd47,MFLO=8'd48,
    MTHI=8'd49,MTLO=8'd50,MFC0=8'd51,MTC0=8'd52,CLZ=8'd53,TEQ=8'd54,MUL=8'd55,
    
    MOVN=8'd56,MOVZ=8'd57,CLO=8'd58,MADD=8'd59,MADDU=8'd60,MSUB=8'd61,MSUBU=8'd62,
    BGEZAL=8'd63,BGTZ=8'd64,BLEZ=8'd65,BLTZ=8'd66,BLTZAL=8'd67,
    LL=8'd68,LWL=8'd69,LWR=8'd70,SC=8'd71,SWL=8'd72,SWR=8'd73,
    TGE=8'd74,TGEU=8'd75,TLT=8'd76,TLTU=8'd77,TNE=8'd78,TEQI=8'd79,TGEI=8'd80,TGEIU=8'd81,TLTI=8'd82,TLTIU=8'd83,TNEI=8'd84;
    
    wire [11:0] tmp;
    assign tmp = {inst[31:26],inst[5:0]};
    always @ (*)
    begin
        casez(tmp)
            12'b000000100000 :out <= ADD;
            12'b000000100001 :out <= ADDU;
            12'b000000100010 :out <= SUB;
            12'b000000100011 :out <= SUBU;
            12'b000000100100 :out <= AND;
            12'b000000100101 :out <= OR;
            12'b000000100110 :out <= XOR;
            12'b000000100111 :out <= NOR;
            12'b000000101010 :out <= SLT;
            12'b000000101011 :out <= SLTU;
            12'b000000000000 :out <= SLL;
            12'b000000000010 :out <= SRL;
            12'b000000000011 :out <= SRA;
            12'b000000000100 :out <= SLLV;
            12'b000000000110 :out <= SRLV;
            12'b000000000111 :out <= SRAV;
            12'b000000001000 :out <= JR;
            12'b001000?????? :out <= ADDI;
            12'b001001?????? :out <= ADDIU;
            12'b001100?????? :out <= ANDI;
            12'b001101?????? :out <= ORI;
            12'b001110?????? :out <= XORI;
            12'b100011?????? :out <= LW;
            12'b101011?????? :out <= SW;
            12'b000100?????? :out <= BEQ;
            12'b000101?????? :out <= BNE;
            12'b001010?????? :out <= SLTI;
            12'b001011?????? :out <= SLTIU;
            12'b001111?????? :out <= LUI;
            12'b000010?????? :out <= J;
            12'b000011?????? :out <= JAL;
            //23extend
            12'b000000011010 :out <= DIV;
            12'b000000011011 :out <= DIVU;
            12'b000000011000 :out <= MULT;
            12'b000000011001 :out <= MULTU;
            12'b000001?????? :begin
                case(rt)
                5'b00000:out <= BLTZ;
                5'b10000:out <= BLTZAL;
                5'b00001:out <= BGEZ;
                5'b10001:out <= BGEZAL;
                5'b01100 :out <= TEQI;
                5'b01000 :out <= TGEI;
                5'b01001 :out <= TGEIU;
                5'b01010 :out <= TLTI;
                5'b01011 :out <= TLTIU;
                5'b01110 :out <= TNEI;
                endcase    
            end
            12'b000000001001 :out <= JALR;
            12'b100100?????? :out <= LBU;
            12'b100101?????? :out <= LHU;
            12'b100000?????? :out <= LB;
            12'b100001?????? :out <= LH;
            12'b101000?????? :out <= SB;
            12'b101001?????? :out <= SH;
            12'b000000001101 :out <= BREAK;
            12'b000000001100 :out <= SYSCALL;
            12'b010000011000 :out <= ERET;
            12'b000000010000 :out <= MFHI;
            12'b000000010010 :out <= MFLO;
            12'b000000010001 :out <= MTHI;
            12'b000000010011 :out <= MTLO;
            12'b010000000000 :begin
                if(rs==5'b00000) out <= MFC0;
                else if(rs==5'b00100) out <= MTC0;
            end
            12'b011100100000 :out <= CLZ;
            12'b000000110100 :out <= TEQ;
            //extend
            12'b011100000010 :out <= MUL;
            12'b000000001011 :out <= MOVN;
            12'b000000001010 :out <= MOVZ;
            12'b011100100001 :out <= CLO;
            12'b011100000000 :out <= MADD;
            12'b011100000001 :out <= MADDU;
            12'b011100000100 :out <= MSUB;
            12'b011100000101 :out <= MSUBU;
            12'b000111?????? :out <= BGTZ;
            12'b000110?????? :out <= BLEZ;
            12'b100010?????? :out <= LWL;
            12'b100110?????? :out <= LWR;
            12'b101010?????? :out <= SWL;
            12'b101110?????? :out <= SWR;
            12'b110000?????? :out <= LL;
            12'b111000?????? :out <= SC;
            12'b000000110000 :out <= TGE;
            12'b000000110001 :out <= TGEU;
            12'b000000110010 :out <= TLT;
            12'b000000110011 :out <= TLTU;
            12'b000000110110 :out <= TNE;
            default:          out <= 8'hFF;
        endcase
    end 
endmodule