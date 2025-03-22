`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/10 17:23:58
// Design Name: 
// Module Name: ALU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ALU(
    input[31:0] ReadData1,
    input[31:0] ReadData2,
    input[31:0] imm32,
    input ALUSrc,
    input[1:0] ALUOp,
    input[2:0] funct3,
    input [6:0] funct7,
    
    output reg [31:0] ALUResult,
    output reg zero
);
    
    reg [3:0] ALUControl ;
    reg [31:0] operand2 ;
    
always @* begin
    case(ALUOp)
        2'b00: ALUControl = {ALUOp, 2'b10}; // I-type load or S-Type sw ????add
        2'b10: begin
            case ({funct7, funct3})
                10'b0000000_000: ALUControl = 4'b0010; // ADD
                10'b0100000_000: ALUControl = 4'b0110; // SUB
                10'b0000000_111: ALUControl = 4'b0000; // AND
                10'b0000000_110: ALUControl = 4'b0001; // OR
                10'b0000000_100: ALUControl = 4'b0011; // XOR
                10'b0000000_001: ALUControl = 4'b0100; // SLL
                10'b0000000_101: ALUControl = 4'b0101; // SRL
                10'b0100000_101: ALUControl = 4'b0111; // SRA
                default: ALUControl = 4'b0000; // Default case
            endcase
        end
        2'b01: begin // B-Type instructions
            case(funct3)
                3'b000: ALUControl = 4'b1000; // BEQ
                3'b001: ALUControl = 4'b1001; // BNE
                3'b100: ALUControl = 4'b1010; // BLT
                3'b101: ALUControl = 4'b1011; // BGE
                3'b110: ALUControl = 4'b1100; // BLTU
                3'b111: ALUControl = 4'b1101; // BGEU
                default: ALUControl = 4'b0000; // Default case
            endcase
        end
        2'b11: begin // I-Type instructions
            case(funct3)
                3'b000: ALUControl = 4'b0010; // ADDI
                3'b100: ALUControl = 4'b0011; // XORI
                3'b110: ALUControl = 4'b0001; // ORI
                3'b111: ALUControl = 4'b0000; // ANDI
                3'b001: ALUControl = 4'b0100; // SLLI
                3'b101: ALUControl = 4'b0101; // SRLI
                default: ALUControl = 4'b0000; // Default case
            endcase
        end
    endcase
end

always @(*) begin
    case(ALUSrc)
        1'b1: operand2 = imm32;
        1'b0: operand2 = ReadData2;
    endcase   
end

always @ (*) begin
    case (ALUControl)
        4'b0010: ALUResult = ReadData1 + operand2; // ADD
        4'b0110: ALUResult = ReadData1 - operand2; // SUB
        4'b0000: ALUResult = ReadData1 & operand2; // AND
        4'b0001: ALUResult = ReadData1 | operand2; // OR
        4'b0011: ALUResult = ReadData1 ^ operand2; // XOR
        4'b0100: ALUResult = ReadData1 << operand2[4:0]; // SLL, ???? operand2 ???5¦Ë
        4'b0101: ALUResult = ReadData1 >> operand2[4:0]; // SRL, ???? operand2 ???5¦Ë
        4'b0111: ALUResult = $signed(ReadData1) >>> operand2[4:0]; // SRA, ????????
        4'b1000: ALUResult = (ReadData1 == operand2) ? 32'b0 : 32'b1; // BEQ
        4'b1001: ALUResult = (ReadData1 != operand2) ? 32'b0 : 32'b1; // BNE
        4'b1010: ALUResult = ($signed(ReadData1) < $signed(operand2)) ? 32'b0 : 32'b1; // BLT
        4'b1011: ALUResult = ($signed(ReadData1) >= $signed(operand2)) ? 32'b0 : 32'b1; // BGE
        4'b1100: ALUResult = ($unsigned(ReadData1) < $unsigned(operand2)) ? 32'b0 : 32'b1; // BLTU
        4'b1101: ALUResult = ($unsigned(ReadData1) >= $unsigned(operand2)) ? 32'b0 : 32'b1; // BGEU
        default: ALUResult = 32'b0; // ??????
    endcase
    zero = (ALUResult == 0) ? 1'b1 : 1'b0;
end

endmodule
