`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/31 21:47:57
// Design Name: 
// Module Name: IF_ID_Reg
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

module IF_ID_Reg(
    input clk,
	input rst,
	input [31:0] pc_if_id_i,
	input [31:0] instr_if_id_i,
	output reg [31:0] pc_if_id_o,
	output reg [31:0] instr_if_id_o,
	
	input load_use_flag
    );

	always@(posedge clk)
	begin
		if(rst)
			pc_if_id_o<= `zeroword;
		else
			pc_if_id_o<=pc_if_id_i;
	end
	
	always@(posedge clk)
	begin
		if(rst)
			instr_if_id_o<= `zeroword;
		else if(load_use_flag)
		    instr_if_id_o<=instr_if_id_o;
		else 
			instr_if_id_o<=instr_if_id_i;
	end

endmodule

