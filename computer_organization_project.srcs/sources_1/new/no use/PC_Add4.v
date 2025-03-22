`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/11 21:18:27
// Design Name: 
// Module Name: PC_Add4
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


module PC_Add4(
    input wire enable,
    input wire PC,
    output reg next_PC4
);
    
always @*
    begin
        if(enable == 1'b1)
            next_PC4 = PC + 4;
    end
endmodule
