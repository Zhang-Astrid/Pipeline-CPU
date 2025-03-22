`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/01 01:43:46
// Design Name: 
// Module Name: Write_Back
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


module Write_Back(
    input MemtoReg,
    input jal,
    input jalr,
	input [31:0] ALU_result_wb_i,   
	input [31:0] loaddata_wb_i,    
	input [31:0] imme_wb_i,
	input [31:0] pc_wb_i,
	output reg [31:0] Wr_reg_data_wb_o
    );
	
	
	always @(*) begin
        if (MemtoReg) begin
            Wr_reg_data_wb_o = loaddata_wb_i;
        end
        else if(jal || jalr) begin
            Wr_reg_data_wb_o = pc_wb_i;
        end
        else begin
            Wr_reg_data_wb_o = ALU_result_wb_i;
        end
    end

endmodule
