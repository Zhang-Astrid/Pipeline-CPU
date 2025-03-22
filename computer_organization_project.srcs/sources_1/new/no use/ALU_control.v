`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/10 16:48:00
// Design Name: 
// Module Name: ALU_control
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


module ALU_control(
    input[1:0]ALUOp,       // ²Ù×÷Âë
    input [6:0]funct7,
    input [2:0]funct3,
    output reg [3:0]ALUControl    // ALU ²Ù×÷Âë
);
    
always @(*) begin

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

endmodule
