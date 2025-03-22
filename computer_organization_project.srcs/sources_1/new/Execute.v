`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/31 23:15:34
// Design Name: 
// Module Name: Execute
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


module Execute(
	input clk,
	input rst,
	input [31:0] pc_ex_i,
	input [31:0] imme_ex_i,
	input [31:0] Rd_data1_ex_i,
	input [31:0] Rd_data2_ex_i,
	
	output [31:0] ALU_result_ex_o,
	output [31:0] imme_ex_o,
	output pc_jump,
	
    input Branch_ex_i,
    input MemRead_ex_i,
    input MemtoReg_ex_i,
    input [1:0] ALUOp_ex_i,
    input MemWrite_ex_i,
    input ALUSrc_ex_i,
    input RegWrite_ex_i,
    input [2:0] funct3_ex_i,
    input [6:0] funct7_ex_i,
    input jal_ex_i,
    input jalr_ex_i,
    
	input [4:0]Rs1_ex_i,
    input [4:0]Rs2_ex_i,
    input [4:0]Rd_ex_mem_o,
    input [4:0]Rd_mem_wb_o,
    input RegWrite_ex_mem_o,
    input RegWrite_mem_wb_o,
    input MemWrite_id_ex_o,
    input MemRead_ex_mem_o,
    input [31:0] ALU_result_ex_mem_o,
    input [31:0] ALU_result_mem_wb_o,
    output forwardC,
    
    input [4:0]Rs1_id_ex_i,
    input [4:0]Rs2_id_ex_i,
    input [4:0]Rd_id_ex_o,
    input MemRead_id_ex_o,
    input MemWrite_id_ex_i,
    input RegWrite_id_ex_o,
        
    output load_use_flag
    );
    
    wire zero;
    wire [1:0]forwardA;
    wire [1:0]forwardB;
    wire [31:0] A;
    wire [31:0] B;
    
    ALU alu(
        .ReadData1(A),
        .ReadData2(B),
        .imm32(imme_ex_i),
        .ALUSrc(ALUSrc_ex_i),
        .ALUOp(ALUOp_ex_i),
        .funct3(funct3_ex_i),
        .funct7(funct7_ex_i),
        .ALUResult(ALU_result_ex_o),
        .zero(zero)
    );
    assign pc_jump = (Branch_ex_i && zero) || jal_ex_i || jalr_ex_i;
    assign imme_ex_o=imme_ex_i;

    forward_unit forward_unit_inst (
        .Rs1_id_ex_o(Rs1_ex_i), 
        .Rs2_id_ex_o(Rs2_ex_i), 
        .Rd_ex_mem_o(Rd_ex_mem_o), 
        .Rd_mem_wb_o(Rd_mem_wb_o), 
        .RegWrite_ex_mem_o(RegWrite_ex_mem_o), 
        .RegWrite_mem_wb_o(RegWrite_mem_wb_o), 
        .MemWrite_id_ex_o(MemWrite_id_ex_o), 
        .MemRead_ex_mem_o(MemRead_ex_mem_o), 
        .forwardA(forwardA), 
        .forwardB(forwardB), 
        .forwardC(forwardC),
        
        .Rs1_id_ex_i(Rs1_id_ex_i),
        .Rs2_id_ex_i(Rs2_id_ex_i),
        .Rd_id_ex_o(Rd_id_ex_o),
        .MemRead_id_ex_o(MemRead_id_ex_o),
        .MemWrite_id_ex_i(MemWrite_id_ex_i),
        .RegWrite_id_ex_o(RegWrite_id_ex_o),
            
        .load_use_flag(load_use_flag)
        );
        
    ///forwardA
    mux3_1 mux3_1_forwardA (
        .din1(ALU_result_ex_mem_o), 
        .din2(ALU_result_mem_wb_o), 
        .din3(Rd_data1_ex_i), 
        .sel(forwardA), 
        .dout(A)
        );
    
        
    ///forwardB
    mux3_1 mux3_1_forwardB (
        .din1(ALU_result_ex_mem_o), 
        .din2(ALU_result_mem_wb_o), 
        .din3(Rd_data2_ex_i), 
        .sel(forwardB), 
        .dout(B)
        );

endmodule
