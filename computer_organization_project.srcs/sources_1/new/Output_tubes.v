`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/25 10:28:23
// Design Name: 
// Module Name: 7seg_tubes
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


module seg_tubes(
    input clk,
    input rst,
    input [15:0] in,
    output reg [3:0] seg_enable,
    output reg [7:0] seg_out
    );
    reg [2:0] counter = 0;
    reg [4:0] data = 0;
    always@(posedge clk) begin
        if (counter == 3)
            counter <= 0;
        else
            counter <= counter + 1;
    end
    
    // select tube, dynamic scan
    always@(counter) begin
        case(counter)
            0: seg_enable = 8'b0000_0001;
            1: seg_enable = 8'b0000_0010;
            2: seg_enable = 8'b0000_0100;
            3: seg_enable = 8'b0000_1000;
        endcase
    end
    
    // control the num show on different tube
    always@(counter) begin
        case(counter)
            0: data = in[3:0]; // tube 1
            1: data = in[7:4]; // tube 2
            2: data = in[11:8];
            3: data = in[15:12];
        endcase
    end
    
    // mapping
    always@(counter) begin
        case(data)
            4'h0: seg_out = 8'b1111_1100;//0
            4'h1: seg_out = 8'b0110_0000;//1
            4'h2: seg_out = 8'b1101_1010;//2
            4'h3: seg_out = 8'b1111_0010;//3
            4'h4: seg_out = 8'b0110_0110;//4
            4'h5: seg_out = 8'b1011_0110;//5
            4'h6: seg_out = 8'b1011_1110;//6
            4'h7: seg_out = 8'b1110_0000;//7
            4'h8: seg_out = 8'b1111_1110;//8
            4'h9: seg_out = 8'b1111_0110;//9
            4'ha: seg_out = 8'b1110_1110;//A
            4'hb: seg_out = 8'b0011_1110;//B
            4'hc: seg_out = 8'b1001_1100;//C
            4'hd: seg_out = 8'b0111_1010;//D
            4'he: seg_out = 8'b1001_1110;//E
            4'hf: seg_out = 8'b1000_1110;//F
            default: seg_out = 8'b0000_0001;
        endcase
    end
    

endmodule
