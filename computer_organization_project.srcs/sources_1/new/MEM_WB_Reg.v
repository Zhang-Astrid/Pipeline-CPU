`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/31 22:12:26
// Design Name: 
// Module Name: MEM_WB_Reg
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

module MEM_WB_Reg(
    input clk,
	input rst,
	
	input [31:0] ALU_result_mem_wb_i,   
	input [31:0] loaddata_mem_wb_i,     //DM
	input [31:0] imme_mem_wb_i,
	input [31:0] pc_mem_wb_i,
	input [4:0] Rd_mem_wb_i,
	
	output reg [31:0] ALU_result_mem_wb_o,   
	output reg [31:0] loaddata_mem_wb_o,     //DM
	output reg [31:0] imme_mem_wb_o,
	output reg [31:0] pc_mem_wb_o,
	output reg [4:0] Rd_mem_wb_o,
	//control signals
	input MemtoReg_mem_wb_i,
	input RegWrite_mem_wb_i,
	input jal_mem_wb_i,
	input jalr_mem_wb_i,
	
	output reg MemtoReg_mem_wb_o,
	output reg RegWrite_mem_wb_o,
	output reg jal_mem_wb_o,
	output reg jalr_mem_wb_o

    );
	
	always@(posedge clk)
	begin
		if(rst)
			ALU_result_mem_wb_o<=`zeroword;
		else
			ALU_result_mem_wb_o<=ALU_result_mem_wb_i;
	end
	
	always@(posedge clk)
	begin
		if(rst)
			loaddata_mem_wb_o<=`zeroword;
		else
			loaddata_mem_wb_o<=loaddata_mem_wb_i;
	end
	
	always@(posedge clk)
	begin
		if(rst)
			imme_mem_wb_o<=`zeroword;
		else
			imme_mem_wb_o<=imme_mem_wb_i;
	end
	
	always@(posedge clk)
	begin
		if(rst)
			pc_mem_wb_o<=`zeroword;
		else
			pc_mem_wb_o<=pc_mem_wb_i;
	end
	
	always@(posedge clk)
	begin
		if(rst)
			Rd_mem_wb_o<=5'd0;
		else
			Rd_mem_wb_o<=Rd_mem_wb_i;
	end
	
	always@(posedge clk)
	begin
		if(rst)
			MemtoReg_mem_wb_o<=`zero;
		else
			MemtoReg_mem_wb_o<=MemtoReg_mem_wb_i;
	end
	
	always@(posedge clk)
	begin
		if(rst)
			RegWrite_mem_wb_o<=`zero;
		else
			RegWrite_mem_wb_o<=RegWrite_mem_wb_i;
	end
	
	always@(posedge clk)
    begin
        if(rst)
            jal_mem_wb_o<=`zero;
        else
            jal_mem_wb_o<=jal_mem_wb_i;
    end
    
    always@(posedge clk)
    begin
        if(rst)
            jalr_mem_wb_o<=`zero;
        else
            jalr_mem_wb_o<=jalr_mem_wb_i;
    end	

endmodule

