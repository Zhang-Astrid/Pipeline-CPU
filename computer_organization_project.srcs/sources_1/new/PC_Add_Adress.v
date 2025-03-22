`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/11 21:54:53
// Design Name: 
// Module Name: PC_Add_Adress
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


module PC_Add_Adress(
    input wire [31:0] PC,
    input wire [31:0] Imm_Gen_Out,
    input wire enable,
    output reg Add_Adress_Out
    );
    wire [31:0] shifted_imm; // ×óshift left
    assign shifted_imm = Imm_Gen_Out << 1;
    
    always @*
        begin
            if(enable == 1'b1)
                Add_Adress_Out = PC + shifted_imm;
        end
endmodule
