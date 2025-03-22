`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/24 22:12:22
// Design Name: 
// Module Name: keyboard_led
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


module MemOrIO(
    input clk,  rst, start,  //a bottum to execute inst's start
    input [4:0] address_ctrl,               //control register address
    input [7:0] input_data,         // a, b, case_num 
    input keyboard_mem_write,    //keyboard input, Remember to turn off before start!!!
    output start_signal,             //show case on led
    output [3:0] seg_enable1,
    output [3:0] seg_enable2,
    output [7:0] seg_out1,
    output [7:0] seg_out2             
    );
    
    reg[31:0] data;
    reg[31:0] write_address;
    wire clk_new, mem_rORw, ctrl_mem_write;  // controler to dM; 
    wire[31:0] dM_to_Reg;       //dM to Register Write data
    wire[31:0] write_Data;        //Register Read_data2 to dM
    wire[31:0] input_address;      // address from ALU 

    assign start_signal = start;
    assign mem_rORw = ctrl_mem_write || keyboard_mem_write;
    // step1: input a from keyboard
    // step2: change addr_ctrl to wanted address
    // step3: input b from keyboard
    // controler is always optimal to keyboard input on write address and read data.
    // if ctrl_mem_write = 0, can use keyboard to input data.
    always@(posedge clk)begin
        if (rst) 
            write_address <= 32'b0;
        else if (ctrl_mem_write) 
            write_address <= input_address>>2;   
        else
            write_address <= {27'b0, address_ctrl};
    end
    
    always@(posedge clk) begin
        if (rst) 
            data <= 32'b0;
        else if (ctrl_mem_write)    
            data <= write_Data;
        else if (keyboard_mem_write)
            data <= {24'b0, input_data};
    end
    
    // x1 in coe is 1, x31 in coe is 31
    // RAM ip core's address spacing is 1 (not 4)
    // data memory address from 0x0000_0000,to 0x0000_001f 
    // always x0 to store 0, x1 to store a, x2 to store case_num
    data_Memory dM(.clk(clk),.mem_Write(ctrl_mem_write),.address(write_address),.write_Data(data), .read_Data(dM_to_Reg));
    clk_freq uclk_freq(.clk(clk), .clk_new(clk_new));
  
    seg_tubes useg_tubes1(.clk(clk), .rst(rst), .in(dM_to_Reg[15:0]), .seg_enable(seg_enable1), .seg_out(seg_out1));
    seg_tubes useg_tubes2(.clk(clk), .rst(rst), .in(dM_to_Reg[31:16]), .seg_enable(seg_enable2), .seg_out(seg_out2));
    
    /*
    module CPU_Main_Basic(
        input wire [31:0]dm_To_Reg,
        input clk,rst,start,
        output wire [31:0] ALU_To_DM,
        output wire memWrite,
        output wire [31:0] Reada2
       );
    */
    CPU_Main_Basic uCPU(
        .clk(clk),.rst(rst),.start(start),
        .loaddata(dM_to_Reg),
        .ALU_To_DM(input_address),
        .MemWrite_ex_mem_o(ctrl_mem_write), 
        .Wr_mem_data(write_Data)
    );
endmodule
