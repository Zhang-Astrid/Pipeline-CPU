`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/02 01:30:50
// Design Name: 
// Module Name: forward_unit
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


module forward_unit(
	input [4:0]Rs1_id_ex_o,
	input [4:0]Rs2_id_ex_o,
	input [4:0]Rd_ex_mem_o,
	input [4:0]Rd_mem_wb_o,
	input RegWrite_ex_mem_o,
	input RegWrite_mem_wb_o,
	input MemWrite_id_ex_o,
	input MemRead_ex_mem_o,
	
	output  [1:0]forwardA,
	output  [1:0]forwardB,
	output forwardC,
	
    input [4:0]Rs1_id_ex_i,
    input [4:0]Rs2_id_ex_i,
    input [4:0]Rd_id_ex_o,
    input MemRead_id_ex_o,
    input MemWrite_id_ex_i,
    input RegWrite_id_ex_o,
        
    output load_use_flag

    );
	
	assign forwardA[1]=(RegWrite_ex_mem_o &&(Rd_ex_mem_o!=5'd0)&&(Rd_ex_mem_o==Rs1_id_ex_o));
	assign forwardA[0]=(RegWrite_mem_wb_o && (Rd_mem_wb_o !=5'd0) &&(Rd_mem_wb_o==Rs1_id_ex_o));
	
	assign forwardB[1]=(RegWrite_ex_mem_o &&(Rd_ex_mem_o!=5'd0)&&(Rd_ex_mem_o==Rs2_id_ex_o));
	assign forwardB[0]=(RegWrite_mem_wb_o && (Rd_mem_wb_o !=5'd0) &&(Rd_mem_wb_o==Rs2_id_ex_o));
	
	//load后紧跟sw但是不需要停顿
    assign forwardC=(RegWrite_ex_mem_o &&(Rd_ex_mem_o!=5'd0)&&(Rd_ex_mem_o!=Rs1_id_ex_o)&& (Rd_ex_mem_o==Rs2_id_ex_o)&& MemWrite_id_ex_o && MemRead_ex_mem_o );
    
    //load-use
    assign load_use_flag=     MemRead_id_ex_o & RegWrite_id_ex_o & (Rd_id_ex_o!=5'd0)   //load
                            &(!MemWrite_id_ex_i)     //非store
                            & ((Rd_id_ex_o ==Rs1_id_ex_i) | (Rd_id_ex_o ==Rs2_id_ex_i))
                            |
                            MemRead_id_ex_o & RegWrite_id_ex_o & (Rd_id_ex_o!=5'd0)     //load
                            &(MemWrite_id_ex_i)     //store
                            & (Rd_id_ex_o ==Rs1_id_ex_i);

endmodule
