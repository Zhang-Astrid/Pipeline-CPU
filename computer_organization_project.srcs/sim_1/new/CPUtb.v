`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/30 10:32:15
// Design Name: 
// Module Name: CPUtb
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


module CPUtb();
reg clk,rst,mem_wOrR;
reg start;
reg [7:0] in_data;
reg [4:0] addr_ctrl;
reg [31:0] readData;
wire [31:0] ALU_To_DM;
wire [31:0] Reada2;
wire memWrite;
//MemOrIO uTope(
//    .clk(clk),  
//    .rst(rst),
//    .start(start),                             //a bottun to execute inst's start
//    .input_data(in_data),         // a, b, case_num 
//    .address_ctrl(addr_ctrl),               //control register address
//    .keyboard_mem_write(mem_wOrR)        //control write to data memory or read to led
//);

CPU_Main_Basic cpu(
    .clk(clk),  
    .rst(rst),
    .start(start),    
    .loaddata(readData),
    .ALU_To_DM(ALU_To_DM),
    .Reada2(Reada2),
    .memWrite(memWrite)
);
initial begin
    clk = 1'b0;
    start = 1'b0;
    rst = 1;
//    mem_wOrR = 1;
//    addr_ctrl = 5'b00000;
//    in_data = 8'b0000_0000;
    forever #10 clk=~clk;
end

initial fork
    #15 rst = 0;
    #10 start = 1'b1;
//    #1000 mem_wOrR = 0;
    #10000000 $finish;
join
endmodule
