`timescale 1ns / 1ps                                                              
//////////////////////////////////////////////////////////////////////////////////
// Company:                                                                       
// Engineer:                                                                      
//                                                                                
// Create Date: 2024/05/10 09:32:57                                               
// Design Name:                                                                   
// Module Name: control                                                       
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
`include "opcode_para.v"

module control(
    input wire [6:0] instruction, // 输入指令
    output reg branch,           // 分支信号
    output reg mem_Read,          // 存储器读取信号
    output reg mem_To_Reg,         //存储器写入寄存器
    output reg [1:0] ALU_Op,     // ALU操作选择信号
    output reg mem_Write,      // 存储器写入信号
    output reg ALU_Src,      // ALU源选择信号
    output reg reg_Write     // 寄存器写入信号
    );
    
    always @ * begin
//assign ALU_Op
    if(instruction[6:0]==7'b0000011 ||instruction[6:0]==7'b0100011)
        ALU_Op = 2'b00;                  //I type and S type
    else if(instruction[6:0]==7'b1100011)//B type
        ALU_Op = 2'b01;
    else                                 //R type                  
        ALU_Op = 2'b10;
//assign branch
    if(instruction[6:0]==7'b1100011)      //B type
        branch = 1'b1;
    else
        branch = 1'b0;
//assign ALU_Src
    if(instruction[6:0]==7'b0000011 ||instruction[6:0]==7'b0100011)
        ALU_Src = 1'b1;                   // I type and S type
    else
        ALU_Src = 1'b0;
//assign mem_Read, mem_To_Reg
    if(instruction[6:0]==7'b0000011)              //I type
       begin
            mem_Read = 1'b1;
            mem_To_Reg = 1'b1;
        end
    else
        begin
                mem_Read = 1'b0;
                mem_To_Reg = 1'b0;
            end
            
//assign mem_Write
    if(instruction[6:0]==7'b0100011)                //S type
        mem_Write = 1'b1;
    else 
        mem_Write = 1'b0;
        
//assign reg_Write
    if(instruction[6:0]==7'b1100011 ||instruction[6:0]==7'b0100011)
        reg_Write = 1'b0;
    else
        reg_Write = 1'b1;
end
endmodule
