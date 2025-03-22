`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/31 22:09:37
// Design Name: 
// Module Name: EX_MEM_Reg
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

module EX_MEM_Reg(
    input clk,
	input rst,
	input [31:0] ALU_result_ex_mem_i,
	input [31:0] Rd_data2_ex_mem_i,
	input [31:0] imme_ex_mem_i,
	input [31:0] pc_ex_mem_i,
	input [4:0] Rd_ex_mem_i,
	input forwardC_ex_mem_i,

	output reg [31:0]ALU_result_ex_mem_o,   
	output reg [31:0]Rd_data2_ex_mem_o,     //DM
	output reg [31:0]imme_ex_mem_o,
	output reg [31:0]pc_ex_mem_o,
	output reg [4:0]Rd_ex_mem_o,
	output reg forwardC_ex_mem_o,
	
	//control signals
	input MemRead_ex_mem_i,
	input MemWrite_ex_mem_i,
	input MemtoReg_ex_mem_i,
	input RegWrite_ex_mem_i,
	input jal_ex_mem_i,
	input jalr_ex_mem_i,
	
	output reg  MemRead_ex_mem_o,
	output reg  MemWrite_ex_mem_o,
	output reg  MemtoReg_ex_mem_o,
	output reg  RegWrite_ex_mem_o,
	output reg  jal_ex_mem_o,
	output reg  jalr_ex_mem_o
	
    );

	always@(posedge clk)
	begin
		if(rst)
			ALU_result_ex_mem_o<=`zeroword;
		else
			ALU_result_ex_mem_o<=ALU_result_ex_mem_i;
	end
	
	always@(posedge clk)
	begin
		if(rst)
			Rd_data2_ex_mem_o<=`zeroword;
		else
			Rd_data2_ex_mem_o<=Rd_data2_ex_mem_i;
	end
	
	always@(posedge clk)
	begin
		if(rst)
			imme_ex_mem_o<=`zeroword;
		else
			imme_ex_mem_o<=imme_ex_mem_i;
	end
	
	always@(posedge clk)
	begin
		if(rst)
			pc_ex_mem_o<=`zeroword;
		else
			pc_ex_mem_o<=pc_ex_mem_i;
	end
	
	always@(posedge clk)
	begin
		if(rst)
			Rd_ex_mem_o<=5'd0;
		else
			Rd_ex_mem_o<=Rd_ex_mem_i;
	end
	
	always@(posedge clk)
    begin
        if(rst)
            forwardC_ex_mem_o<=`zero;
        else
            forwardC_ex_mem_o<=forwardC_ex_mem_i;
    end

	always@(posedge clk)
	begin
		if(rst)
			MemRead_ex_mem_o<=`zero;
		else
			MemRead_ex_mem_o<=MemRead_ex_mem_i;
	end
	
	always@(posedge clk)
	begin
		if(rst)
			MemWrite_ex_mem_o<=`zero;
		else
			MemWrite_ex_mem_o<=MemWrite_ex_mem_i;
	end
	
	
	always@(posedge clk)
	begin
		if(rst)
			MemtoReg_ex_mem_o<=`zero;
		else
			MemtoReg_ex_mem_o<=MemtoReg_ex_mem_i;
	end
	
	always@(posedge clk)
	begin
		if(rst)
			RegWrite_ex_mem_o<=`zero;
		else
			RegWrite_ex_mem_o<=RegWrite_ex_mem_i;
	end
	
	always@(posedge clk)
    begin
        if(rst)
            jal_ex_mem_o<=`zero;
        else
            jal_ex_mem_o<=jal_ex_mem_i;
    end
    
    always@(posedge clk)
    begin
        if(rst)
            jalr_ex_mem_o<=`zero;
        else
            jalr_ex_mem_o<=jalr_ex_mem_i;
    end	
    
endmodule

 
