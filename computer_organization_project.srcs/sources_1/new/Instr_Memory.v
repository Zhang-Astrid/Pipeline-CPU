`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/31 23:50:20
// Design Name: 
// Module Name: Instr_Memory
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


module Instr_Memory(
    input clk,
    input [31:0] pc,
    output [31:0] instruction
    );
    progrom urom(
        .clka(clk),
        .addra(pc >> 2), 
        .douta(instruction)
    );
    
endmodule
