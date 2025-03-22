`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/11 20:30:55
// Design Name: 
// Module Name: IF_MUX
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


module IF_MUX(
    input wire add_4,
    input wire add_Imm,
    input wire selection,
    output reg to_PC
    );

always@* begin
    case(selection) 
        1'b0: to_PC = add_4;
        1'b1: to_PC = add_Imm;
    endcase
end

endmodule
