`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/13 09:36:07
// Design Name: 
// Module Name: MUX_32
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


module mux (
    input wire [31:0] data1,  // First 32-bit data input
    input wire [31:0] data2,  // Second 32-bit data input
    input wire sel,         // 1-bit wide selector signal
    output reg [31:0] dout  // 32-bit wide output data
);

// MUX logic
always @(*) begin
    case (sel)
        1'b1: dout = data1; // When sel is 0, choose the first input (in0)
        1'b0: dout = data2; // When sel is 1, choose the second input (in1)
    endcase
end

endmodule
