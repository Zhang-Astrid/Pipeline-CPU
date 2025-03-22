`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/12 22:19:05
// Design Name: 
// Module Name: Execution
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


module Execution(
    input[31:0]ReadData1,
    input[31:0]ReadData2,
    input[31:0]imm32,
    input ALUSrc,
    input[1:0]ALUOp,
    input[2:0]funct3,
    input [6:0] funct7,
    
    output reg [31:0] ALUResult,
    output reg zero
);
    
    reg [3:0] ALUControl;
    reg [31:0]operand2;
    
always @*begin
    case( ALUOp)
        2'b00,2'b01: ALUControl = { ALUOp, 2'b10};//I-type
        2'b10:begin
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
    endcase
end

always @(*)begin
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
        4'b0100: ALUResult = ReadData1 << operand2[4:0]; // SLL, 只使用 operand2 的低5位
        4'b0101: ALUResult = ReadData1 >> operand2[4:0]; // SRL, 只使用 operand2 的低5位
        4'b0111: ALUResult = $signed(ReadData1) >>> operand2[4:0]; // SRA, 算术右移
        default: ALUResult = 32'b0; // 默认情况
    endcase
    zero = (ALUResult == 0) ? 1'b1 : 1'b0;
end
