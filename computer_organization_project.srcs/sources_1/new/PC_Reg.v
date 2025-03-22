`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/01 00:05:22
// Design Name: 
// Module Name: PC_Reg
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
`include "opcode_para.v"

module PC_Reg(
    input clk,
	input rst,
	input [31:0] pc,
	input load_use_flag,
	output reg [31:0] pc_out
    );

	always@(posedge clk)
	begin
		if(rst)
			pc_out<=`zeroword;
		else if(load_use_flag)
		    pc_out<=pc_out;
		else
			pc_out<= pc;
	end	

endmodule
