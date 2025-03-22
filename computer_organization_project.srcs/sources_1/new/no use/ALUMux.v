`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/10 17:30:08
// Design Name: 
// Module Name: ALUMux
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


module ALUMux(
input ALUSrc,
input [31:0] Read_data2,
input [31:0]immdiate,
output reg[31:0]operand2
    );
 always @(ALUSrc)
 case(ALUSrc)
 1'b1: operand2 = immdiate;
 1'b0: operand2 = Read_data2;
 endcase   
endmodule
