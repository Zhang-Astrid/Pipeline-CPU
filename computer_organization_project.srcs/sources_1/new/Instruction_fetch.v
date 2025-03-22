`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/10 22:59:40
// Design Name: 
// Module Name: Instruction_fetch
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

module Instruction_fetch(
    input wire clk,
    input wire rst,
    input wire start_signal,
    input wire MUX_Enable,      //From controller
    input wire add4_Enable,
    input wire add_Address_Enable,
    output wire [31:0] instruction
);

    wire Inst_Out; 
    wire Adder1_To_MUX;
    wire ImmGen_To_PCAdressAdder;// unconnected from Imm_gen to IF
    wire Adder2_To_MUX;
    reg [31:0] PC;
    reg [31:0] Next_PC;
    wire [31:0]to_PC;
    assign to_PC = Next_PC;
    progrom urom(.clka(clk), .addra(Next_PC),.douta(instruction));
    PC_Add4 adder1(.enable(add4_Enable), .PC(PC), .next_PC4(Adder1_To_MUX));
    PC_Add_Adress adder2(
        .enable(add_Address_Enable),
        .PC(PC),
        .Imm_Gen_Out(ImmGen_To_PCAdressAdder),
        .Add_Adress_Out(Adder2_To_MUX)
    );
    IF_MUX IF_MUX(.add_4(Adder1_To_MUX), .add_Imm(Adder2_To_MUX), .selection(MUX_Enable), .to_PC(to_PC));
    
    always @(negedge clk) begin
            if (rst || ~start_signal) begin
                PC <= 32'h0000_0000;
            end else begin
                PC <= Next_PC;
            end
        end
endmodule
