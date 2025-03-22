`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/31 22:01:55
// Design Name: 
// Module Name: ID_EX_Reg
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

module ID_EX_Reg(
    input clk,
	input rst,
	input pc_jump,
	
	input [31:0] pc_id_ex_i,//pc code
	input [31:0] imme_id_ex_i,//immediate
	input [31:0] Rd_data1_id_ex_i,
	input [31:0] Rd_data2_id_ex_i,
	input [4:0] Rd_id_ex_i,
	input [2:0] funct3_id_ex_i,
	input [6:0] funct7_id_ex_i,
	input [6:0] opcode_id_ex_i,
	input [4:0] Rs1_id_ex_i,
	input [4:0] Rs2_id_ex_i,

	output reg [31:0] pc_id_ex_o,
	output reg [31:0] imme_id_ex_o,
	output reg [31:0] Rd_data1_id_ex_o,
	output reg [31:0] Rd_data2_id_ex_o,
	output reg [4:0] Rd_id_ex_o,
	output reg [2:0] funct3_id_ex_o,
    output reg [6:0] funct7_id_ex_o,
    output reg [6:0] opcode_id_ex_o,
    output reg [4:0] Rs1_id_ex_o,
    output reg [4:0] Rs2_id_ex_o,

	input Branch_id_ex_i,
	input MemRead_id_ex_i,
	input MemtoReg_id_ex_i,
	input [1:0] ALUOp_id_ex_i,
	input MemWrite_id_ex_i,
	input ALUSrc_id_ex_i,
	input RegWrite_id_ex_i,
	input jal_id_ex_i,
	input jalr_id_ex_i,
	
    output reg Branch_id_ex_o,
    output reg MemRead_id_ex_o,
    output reg MemtoReg_id_ex_o,
    output reg [1:0] ALUOp_id_ex_o,
    output reg MemWrite_id_ex_o,
    output reg ALUSrc_id_ex_o,
    output reg RegWrite_id_ex_o,
    output reg jal_id_ex_o,
    output reg jalr_id_ex_o,
    
    input load_use_flag
    );

always@(posedge clk)
	begin
		if(rst)
			pc_id_ex_o<=`zeroword;
		else
			pc_id_ex_o<=pc_id_ex_i;
	end
	
always@(posedge clk)
	begin
		if(rst)
			imme_id_ex_o<=`zeroword;
		else
			imme_id_ex_o<=imme_id_ex_i;
	end
	
always@(posedge clk)
	begin
		if(rst)
			Rd_data1_id_ex_o<=`zeroword;
		else
			Rd_data1_id_ex_o<=Rd_data1_id_ex_i;
	end

always@(posedge clk)
	begin
		if(rst)
			Rd_data2_id_ex_o<=`zeroword;
		else
			Rd_data2_id_ex_o<=Rd_data2_id_ex_i;
	end

always@(posedge clk)
	begin
		if(rst )
			Rd_id_ex_o<=`zero;
		else
			Rd_id_ex_o<=Rd_id_ex_i;
	end
	
always@(posedge clk)
        begin
            if(rst || pc_jump)
                funct3_id_ex_o<=`zero;
            else
                funct3_id_ex_o<=funct3_id_ex_i;
        end
        
always@(posedge clk)
            begin
                if(rst || pc_jump || load_use_flag)
                    funct7_id_ex_o<=`zero;
                else
                    funct7_id_ex_o<=funct7_id_ex_i;
            end
            
always@(posedge clk)
            begin
                 if(rst || pc_jump || load_use_flag)
                       opcode_id_ex_o<=`zero;
                 else
                       opcode_id_ex_o<=opcode_id_ex_i;
             end       
                  	
always@(posedge clk)
            begin
                  if(rst || pc_jump || load_use_flag)
                        Rs1_id_ex_o<=`zero;
                  else
                        Rs1_id_ex_o<=Rs1_id_ex_i;
            end  
               
always@(posedge clk)
            begin
                   if(rst || pc_jump || load_use_flag)
                          Rs2_id_ex_o<=`zero;
                   else
                          Rs2_id_ex_o<=Rs2_id_ex_i;
            end     
            
always@(posedge clk)
        begin
            if(rst || pc_jump || load_use_flag)
                Branch_id_ex_o<=`zero;
            else
                Branch_id_ex_o<=Branch_id_ex_i;
        end
 
 always@(posedge clk)
            begin
                if(rst || pc_jump || load_use_flag)
                    ALUOp_id_ex_o<=`zero;
                else
                    ALUOp_id_ex_o<=ALUOp_id_ex_i;
            end	

always@(posedge clk)
           begin
               if(rst || pc_jump || load_use_flag)
                    MemtoReg_id_ex_o<=`zero;
               else
                    MemtoReg_id_ex_o<=MemtoReg_id_ex_i;
            end

always@(posedge clk)
	begin
		if(rst || pc_jump || load_use_flag)
			ALUSrc_id_ex_o<=`zero;
		else
			ALUSrc_id_ex_o<=ALUSrc_id_ex_i;
	end


always@(posedge clk)
	begin
		if(rst || pc_jump || load_use_flag)
			MemRead_id_ex_o<=`zero;
		else
			MemRead_id_ex_o<=MemRead_id_ex_i;
	end

always@(posedge clk)
	begin
		if(rst || pc_jump || load_use_flag)
			MemWrite_id_ex_o<=`zero;
		else
			MemWrite_id_ex_o<=MemWrite_id_ex_i;
	end

always@(posedge clk)
	begin
		if(rst || pc_jump || load_use_flag)
			RegWrite_id_ex_o<=`zero;
		else
			RegWrite_id_ex_o<=RegWrite_id_ex_i;
	end

always@(posedge clk)
	begin
		if(rst || pc_jump || load_use_flag)
			jal_id_ex_o<=`zero;
		else
			jal_id_ex_o<=jal_id_ex_i;
	end

always@(posedge clk)
	begin
		if(rst || pc_jump || load_use_flag)
			jalr_id_ex_o<=`zero;
		else
			jalr_id_ex_o<=jalr_id_ex_i;
	end

endmodule

