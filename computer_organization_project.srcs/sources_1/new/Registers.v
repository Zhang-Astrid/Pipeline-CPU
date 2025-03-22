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
    input clk,                  // ʱ���ź�
    input rst,                  // �����ź�
    input Reg_write,         // �Ĵ���дʹ��
    input [4:0] Read_register1,      // ���Ĵ���1��ַ
    input [4:0]  Read_register2,      // ���Ĵ���2��ַ
    input [4:0] Write_register,      // д�Ĵ�����ַ
    input [31:0] Write_data,    // д�������
    output [31:0] Read_data1,   // ���������1
    output [31:0] Read_data2    // ���������2
);

// �Ĵ�������
reg [31:0] reg_file[31:0];
integer i;
// ��ȡ�Ĵ�������
assign Read_data1 = (Read_register1 != 0) ? reg_file[Read_register1] : 0;
assign Read_data2 = (Read_register2 != 0) ? reg_file[Read_register2] : 0;

// �Ĵ���д����
always @(negedge clk) begin
    if (rst) begin
        // �������мĴ���Ϊ0      
        for (i = 0; i < 32; i = i + 1)
            reg_file[i] <= 0;
        reg_file[1] <= 1;
    end 
    else if (Reg_write && ( Write_register != 0)) begin
        // д�����ݵ��Ĵ���
        reg_file[Write_register] <= Write_data;
    end
end

endmodule
