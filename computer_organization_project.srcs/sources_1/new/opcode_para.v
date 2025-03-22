`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/14 17:31:58
// Design Name: 
// Module Name: opcode_para
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
`define I_type 7'b0010011
`define R_type 7'b0110011
`define S_type 7'b0100011
`define B_type 7'b1100011
`define J_type 7'b1101111
`define I_type_jalr 7'b1100111
`define U_type 7'b0110111//lui, no auipc
`define I_type_ecall 7'b1110011 
`define zeroword 32'h00000000
`define zero 0