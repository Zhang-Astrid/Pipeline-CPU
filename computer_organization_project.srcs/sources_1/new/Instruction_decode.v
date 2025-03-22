`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/12 21:44:59
// Design Name: 
// Module Name: Instruction_decode
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


module Instruction_decode(
    input wire clk1, rst1,
    input wire Reg_write1,//sign
    input wire [4:0] Rd_reg_i,
    input wire [31:0] Write_data1,
    input wire [31:0] instruction,
    input wire jal,
    input wire jalr,
    
    output wire [2:0] func3,
    output wire [6:0] func7,
    output wire [31:0] Read_data_1,
    output wire [31:0] Read_data_2,
    output wire [31:0] immediate,
    output wire [4:0] Write_reg,
    output wire [6:0] opcode,
    output wire [4:0] Read_reg1,
    output wire [4:0] Read_reg2
    );
    
    assign Read_reg1 = instruction[19:15];
    assign Read_reg2 = instruction[24:20];
    assign Write_reg = instruction[11:7];
    assign func3 = instruction[14:12];
    assign func7 = instruction[31:25];
    assign opcode = instruction[6:0];
    
    Registers register(
        .clk(clk1), 
        .rst(rst1),
        .Reg_write(Reg_write1),
        .Read_register1(Read_reg1), 
        .Read_register2(Read_reg2),
        .Write_register(Rd_reg_i), 
        .Write_data(Write_data1),
        .Read_data1(Read_data_1), 
        .Read_data2(Read_data_2)
    );
    
    Imm_gen imm_G(
        .instruction(instruction),
        .immediate(immediate)
    );
    
endmodule
