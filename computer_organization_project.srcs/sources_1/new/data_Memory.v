`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/10 22:25:44
// Design Name: 
// Module Name: data_Memory
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

module data_Memory(
    input wire clk,
//    input wire rst,
//    input mem_Read,
    input mem_Write,
    input [31:0] address,
    input [31:0] write_Data,
    output[31:0] read_Data
);
RAM udram(
    .clka(clk),
    .wea(mem_Write),
    .addra(address[13:0]),
    .dina(write_Data),
    .douta(read_Data)
);

endmodule