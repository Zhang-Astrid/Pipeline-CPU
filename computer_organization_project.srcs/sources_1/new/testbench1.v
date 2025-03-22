`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/10 20:34:28
// Design Name: 
// Module Name: testbench1
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


module testbench1(
    input [2:0] test_Code,
    input [7:0] In_a,
    input [7:0] In_b,
    output reg [7:0] LED_Out_a,
    output reg [7:0] LED_Out_b
    );

always@*
   
    if(test_Code==3'b000) begin    
            LED_Out_a = In_a;
            LED_Out_b = In_b;
        end
    else if(test_Code==3'b001) begin
    
        end
endmodule
