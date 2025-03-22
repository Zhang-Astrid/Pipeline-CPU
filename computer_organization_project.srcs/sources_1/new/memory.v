`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/02 01:37:59
// Design Name: 
// Module Name: memory
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


module memory(
	input [31:0]Rd_data2_mem_i,
	input [31:0]loaddata_mem_wb_o,
	input forwardC_mem_i,
	output [31:0]Wr_mem_data
	
    );

	mux mem_mux (
    .data1(loaddata_mem_wb_o), 
    .data2(Rd_data2_mem_i), 
    .sel(forwardC_mem_i), 
    .dout(Wr_mem_data)
    );
    
endmodule
