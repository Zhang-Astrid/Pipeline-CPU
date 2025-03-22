`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/30 19:55:34
// Design Name: 
// Module Name: cpu_sim
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


module cpu_sim( );
reg clk;
reg rst;
reg start;

CPU_Main_Basic uut (
    .clk(clk),
    .rst(rst),
    .start(start)
);
initial begin
    clk = 0;
    forever #10 clk = ~clk;  // Generate a clock with a period of 20 ns
end

initial begin
    rst = 1;
    start = 0;

    #10;
    rst = 0; 
    start = 1; 
end
endmodule