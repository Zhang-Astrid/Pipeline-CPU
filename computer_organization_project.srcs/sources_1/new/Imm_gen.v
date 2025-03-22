`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/10 16:23:18
// Design Name: 
// Module Name: Imm_gen
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

module Imm_gen(
    input [31:0] instruction,
    output reg [31:0] immediate
);

    wire [6:0] opcode = instruction[6:0];

   always @(*) begin
            case (opcode)
               7'b1100111:begin //I-type, jalr
                    immediate = {{20{instruction[31]}}, instruction[31:20]};
                end
                7'b0000011: begin // I-type, Load instructions like LW
                    immediate = {{20{instruction[31]}}, instruction[31:20]};
                end
                7'b0010011: begin // I-type, Arithmetic and logical instructions like ADDI, SLTI, XORI
                    immediate = {{20{instruction[31]}}, instruction[31:20]};
                end
                7'b0100011: begin // S-type, Store instructions like SW
                    immediate = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
                end
                7'b1100011: begin // B-type, Branch instructions like BEQ
                    immediate = {{19{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0};
                end
                7'b0110111, 7'b0010111: begin // U-type, such as LUI
                    immediate = {instruction[31:12], 12'd0};
                end
                7'b1101111: begin // J-type, Jump instructions like JAL
                    immediate = {{11{instruction[31]}}, instruction[31], instruction[19:12], instruction[20], instruction[30:21], 1'b0};
                end
                default: immediate = 32'd0; // Default case for unsupported opcodes
            endcase
        end

endmodule