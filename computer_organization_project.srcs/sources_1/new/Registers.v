`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/10 13:19:43
// Design Name: 
// Module Name: Registers
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


module Registers(
    input clk,                  // 时钟信号
    input rst,                  // 重置信号
    input Reg_write,         // 寄存器写使能
    input [4:0] Read_register1,      // 读寄存器1地址
    input [4:0]  Read_register2,      // 读寄存器2地址
    input [4:0] Write_register,      // 写寄存器地址
    input [31:0] Write_data,    // 写入的数据
    output [31:0] Read_data1,   // 输出的数据1
    output [31:0] Read_data2    // 输出的数据2
);

// 寄存器数组
reg [31:0] reg_file[31:0];
integer i;
// 读取寄存器数据
assign Read_data1 = (Read_register1 != 0) ? reg_file[Read_register1] : 0;
assign Read_data2 = (Read_register2 != 0) ? reg_file[Read_register2] : 0;

// 寄存器写操作
always @(negedge clk) begin
    if (rst) begin
        // 重置所有寄存器为0      
        for (i = 0; i < 32; i = i + 1)
            reg_file[i] <= 0;
        reg_file[1] <= 1;
    end 
    else if (Reg_write && ( Write_register != 0)) begin
        // 写入数据到寄存器
        reg_file[Write_register] <= Write_data;
    end
end

endmodule
