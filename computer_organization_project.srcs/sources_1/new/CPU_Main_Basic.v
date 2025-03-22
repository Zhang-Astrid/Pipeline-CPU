`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/12 22:21:59
// Design Name: 
// Module Name: CPU_Main_Basic
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


module CPU_Main_Basic(
    input clk,rst,start,
    input [31:0] loaddata,
    output [31:0] ALU_To_DM,
    output [31:0] Wr_mem_data,
    output MemWrite_ex_mem_o
   );
wire [31:0] inst;
wire [1:0] ALUOp;
wire [2:0] func3;
wire [6:0] func7;
wire [6:0] opcode;
wire [4:0] Read_reg1;
wire [4:0] Read_reg2;
wire forwardC;
wire load_use_flag;

wire branch, memReg, ALUSrc, regWrite, zero, mux_en, memRead, memWrite;
wire jal, jalr;
wire pc_jump;

wire [31:0] pc_if_i;
wire [31:0] pc_if_o;
   
wire [31:0] pc_if_id_o;
wire [31:0] instr_if_id_o;
   
wire [31:0] imme_id_o;
wire [31:0] Rd_data1_id_o;
wire [31:0] Rd_data2_id_o;
wire [4:0] Rd_id_o;
wire [2:0] funct3_id_o;
wire [6:0] funct7_id_o;
wire [6:0] opcode_id_o;
wire [4:0] Rs1_id_o;
wire [4:0] Rs2_id_o;
      
wire [31:0] pc_id_ex_o;
wire [31:0] imme_id_ex_o;
wire [31:0] Rd_data1_id_ex_o;
wire [31:0] Rd_data2_id_ex_o;
wire [4:0] Rd_id_ex_o;
wire ALUSrc_id_ex_o;
wire MemRead_id_ex_o;
wire MemWrite_id_ex_o;
wire MemtoReg_id_ex_o;
wire RegWrite_id_ex_o;  
wire Branch_id_ex_o;
wire jal_id_ex_o;
wire jalr_id_ex_o;
wire [1:0] ALUOp_id_ex_o;
       
wire [31:0] ALU_result_ex_o;
wire [31:0] imme_ex_o;
       
wire [31:0] Rd_data2_ex_mem_o;
wire [31:0] imme_ex_mem_o;
wire [4:0] Rd_ex_mem_o;
wire  MemRead_ex_mem_o;
wire  MemtoReg_ex_mem_o;
wire  RegWrite_ex_mem_o;
wire  jal_ex_mem_o;
wire  jalr_ex_mem_o;
wire [31:0] pc_ex_mem_o;
   
wire forwardC_mem_i;
   
wire [31:0] ALU_result_mem_wb_o;
wire [31:0] loaddata_mem_wb_o;
wire [31:0] imme_mem_wb_o;
wire [4:0] Rd_mem_wb_o;
wire  MemtoReg_mem_wb_o;
wire  RegWrite_mem_wb_o;
wire  jal_mem_wb_o;
wire  jalr_mem_wb_o;
wire [31:0] pc_mem_wb_o;
       
wire [31:0]Wr_reg_data_wb_o;
       


Instr_Memory IM(
    .clk(clk),
    .pc(pc_if_i),
    .instruction(inst)
);

//usage of Control
Controller ControllerU(
   .inst(opcode),        // ÊäÈëÖ¸Áî
   .Branch(branch),           // ·ÖÖ§ÐÅºÅ
   .MemRead(memRead),          // ´æ´¢Æ÷¶ÁÈ¡ÐÅºÅ
   .MemtoReg(memReg),         //´æ´¢Æ÷Ð´Èë¼Ä´æÆ÷
   .ALUOp(ALUOp),     // ALU²Ù×÷Ñ¡ÔñÐÅºÅ
   .MemWrite(memWrite),      // ´æ´¢Æ÷Ð´ÈëÐÅºÅ
   .ALUSrc(ALUSrc),      // ALUÔ´Ñ¡ÔñÐÅºÅ
   .RegWrite(regWrite),     // ¼Ä´æÆ÷Ð´ÈëÐÅºÅ
   .Jal(jal),
   .Jalr(jalr)
);

//usage of IF
IFetch IF(
    .clk(clk),
    .rst(rst),
    .start(start),
    .jalr(jalr_id_ex_o),
    .Rd1(Rd_data1_id_ex_o),
    .pc_jump(pc_jump),
    .imm_jump(imme_ex_o),
    .pc_if_i(pc_if_i),
    .pc_if_o(pc_if_o),
    .pc_next(pc_if_i),
    .load_use_flag(load_use_flag)
);

IF_ID_Reg IF_ID_Reg(
    .clk(clk),
    .rst(rst),
    .pc_if_id_i(pc_if_o), 
    .instr_if_id_i(inst), 
    .pc_if_id_o(pc_if_id_o), 
    .instr_if_id_o(instr_if_id_o),
    .load_use_flag(load_use_flag)
);

//usage of ID
Instruction_decode ID(
    .clk1(clk),
    .rst1(rst),
    .Reg_write1(RegWrite_mem_wb_o),              //From controller
    .Rd_reg_i(Rd_mem_wb_o),
    .Write_data1(Wr_reg_data_wb_o),             //From MUX
    .instruction(inst),
    .jal(jal),
    .jalr(jalr),
    
    .func3(func3),
    .func7(func7),
    .opcode(opcode),
    .Read_data_1(Rd_data1_id_o),             //To ALU
    .Read_data_2(Rd_data2_id_o),             //To ALU
    .immediate(imme_id_o),
    .Write_reg(Rd_id_o),   
    .Read_reg1(Read_reg1),
    .Read_reg2(Read_reg2)
);

ID_EX_Reg ID_EX_Reg(
   .clk(clk),
   .rst(rst),
   .pc_jump(pc_jump),
   .pc_id_ex_i(pc_if_id_o),
   .imme_id_ex_i(imme_id_o), 
   .Rd_data1_id_ex_i(Rd_data1_id_o), 
   .Rd_data2_id_ex_i(Rd_data2_id_o), 
   .Rd_id_ex_i(Rd_id_o),
   .funct3_id_ex_i(func3),
   .funct7_id_ex_i(func7),
   .opcode_id_ex_i(opcode),
   .Rs1_id_ex_i(Read_reg1),
   .Rs2_id_ex_i(Read_reg2),
   
   .pc_id_ex_o(pc_id_ex_o), 
   .imme_id_ex_o(imme_id_ex_o), 
   .Rd_data1_id_ex_o(Rd_data1_id_ex_o), 
   .Rd_data2_id_ex_o(Rd_data2_id_ex_o),
   .Rd_id_ex_o(Rd_id_ex_o),
   .funct3_id_ex_o(funct3_id_o),
   .funct7_id_ex_o(funct7_id_o),
   .opcode_id_ex_o(opcode_id_o),
   .Rs1_id_ex_o(Rs1_id_o),
   .Rs2_id_ex_o(Rs2_id_o),
   
   .Branch_id_ex_i(branch),
   .MemRead_id_ex_i(memRead),
   .MemtoReg_id_ex_i(memReg),
   .ALUOp_id_ex_i(ALUOp),
   .MemWrite_id_ex_i(memWrite),
   .ALUSrc_id_ex_i(ALUSrc),
   .RegWrite_id_ex_i(regWrite),
   .jal_id_ex_i(jal),
   .jalr_id_ex_i(jalr),
       
   .Branch_id_ex_o(Branch_id_ex_o),
   .MemRead_id_ex_o(MemRead_id_ex_o),
   .MemtoReg_id_ex_o(MemtoReg_id_ex_o),
   .ALUOp_id_ex_o(ALUOp_id_ex_o),
   .MemWrite_id_ex_o(MemWrite_id_ex_o),
   .ALUSrc_id_ex_o(ALUSrc_id_ex_o),
   .RegWrite_id_ex_o(RegWrite_id_ex_o),
   .jal_id_ex_o(jal_id_ex_o),
   .jalr_id_ex_o(jalr_id_ex_o),
   
   .load_use_flag(load_use_flag)
);

Execute EX(
    .clk(clk),
    .rst(rst),
    .pc_ex_i(pc_id_ex_o),
    .imme_ex_i(imme_id_ex_o),
    .Rd_data1_ex_i(Rd_data1_id_ex_o),
    .Rd_data2_ex_i(Rd_data2_id_ex_o),
    .ALU_result_ex_o(ALU_result_ex_o),
    .imme_ex_o(imme_ex_o),
    .pc_jump(pc_jump),
    .Branch_ex_i(Branch_id_ex_o),
    .MemRead_ex_i(MemRead_id_ex_o),
    .MemtoReg_ex_i(MemtoReg_id_ex_o),
    .ALUOp_ex_i(ALUOp_id_ex_o),
    .MemWrite_ex_i(MemWrite_id_ex_o),
    .ALUSrc_ex_i(ALUSrc_id_ex_o),
    .RegWrite_ex_i(RegWrite_id_ex_o),
    .funct3_ex_i(funct3_id_o),
    .funct7_ex_i(funct7_id_o),
    .jal_ex_i(jal_id_ex_o),
    .jalr_ex_i(jalr_id_ex_o),
    
    .Rs1_ex_i(Rs1_id_o),
    .Rs2_ex_i(Rs2_id_o),
    .Rd_ex_mem_o(Rd_ex_mem_o),
    .Rd_mem_wb_o(Rd_mem_wb_o),
    .RegWrite_ex_mem_o(RegWrite_ex_mem_o),
    .RegWrite_mem_wb_o(RegWrite_mem_wb_o),
    .MemWrite_id_ex_o(MemWrite_id_ex_o),
    .MemRead_ex_mem_o(MemRead_ex_mem_o),
    .ALU_result_ex_mem_o(ALU_To_DM),
    .ALU_result_mem_wb_o(Wr_reg_data_wb_o),
    .forwardC(forwardC),
    
    .Rs1_id_ex_i(Read_reg1),
    .Rs2_id_ex_i(Read_reg2),
    .Rd_id_ex_o(Rd_id_ex_o),
    .MemRead_id_ex_o(MemRead_id_ex_o),
    .MemWrite_id_ex_i(memWrite),
    .RegWrite_id_ex_o(RegWrite_id_ex_o),
        
    .load_use_flag(load_use_flag)
);

EX_MEM_Reg EX_MEM_Reg(
    .clk(clk),
    .rst(rst),
	.ALU_result_ex_mem_i(ALU_result_ex_o),
	.Rd_data2_ex_mem_i(Rd_data2_id_ex_o),
	.imme_ex_mem_i(imme_ex_o),
	.pc_ex_mem_i(pc_id_ex_o),
	.Rd_ex_mem_i(Rd_id_ex_o),
	.forwardC_ex_mem_i(forwardC),

	.ALU_result_ex_mem_o(ALU_To_DM),   
	.Rd_data2_ex_mem_o(Rd_data2_ex_mem_o),   
	.imme_ex_mem_o(imme_ex_mem_o),
	.pc_ex_mem_o(pc_ex_mem_o),
	.Rd_ex_mem_o(Rd_ex_mem_o),
	.forwardC_ex_mem_o(forwardC_mem_i),
	
	//control signals
	.MemRead_ex_mem_i(MemRead_id_ex_o),
	.MemWrite_ex_mem_i(MemWrite_id_ex_o),
	.MemtoReg_ex_mem_i(MemtoReg_id_ex_o),
	.RegWrite_ex_mem_i(RegWrite_id_ex_o),
	.jal_ex_mem_i(jal_id_ex_o),
	.jalr_ex_mem_i(jalr_id_ex_o),
	
	.MemRead_ex_mem_o(MemRead_ex_mem_o),
	.MemWrite_ex_mem_o(MemWrite_ex_mem_o),
	.MemtoReg_ex_mem_o(MemtoReg_ex_mem_o),
	.RegWrite_ex_mem_o(RegWrite_ex_mem_o),
	.jal_ex_mem_o(jal_ex_mem_o),
	.jalr_ex_mem_o(jalr_ex_mem_o)
);

memory MEM(
    .Rd_data2_mem_i(Rd_data2_ex_mem_o),
	.loaddata_mem_wb_o(loaddata_mem_wb_o),
	.forwardC_mem_i(forwardC_mem_i),
	.Wr_mem_data(Wr_mem_data)
);

MEM_WB_Reg MEM_WB_Reg(
    .clk(clk),
    .rst(rst),
    .ALU_result_mem_wb_i(ALU_To_DM),   
	.loaddata_mem_wb_i(loaddata),     //DM
	.imme_mem_wb_i(imme_ex_mem_o),
	.pc_mem_wb_i(pc_ex_mem_o),
	.Rd_mem_wb_i(Rd_ex_mem_o),
	.ALU_result_mem_wb_o(ALU_result_mem_wb_o),   
	.loaddata_mem_wb_o(loaddata_mem_wb_o),     //DM
	.imme_mem_wb_o(imme_mem_wb_o),
	.pc_mem_wb_o(pc_mem_wb_o),
	.Rd_mem_wb_o(Rd_mem_wb_o),
	
	.MemtoReg_mem_wb_i(MemtoReg_ex_mem_o),
	.RegWrite_mem_wb_i(RegWrite_ex_mem_o),
	.jal_mem_wb_i(jal_ex_mem_o),
	.jalr_mem_wb_i(jalr_ex_mem_o),
	
	.MemtoReg_mem_wb_o(MemtoReg_mem_wb_o),
	.RegWrite_mem_wb_o(RegWrite_mem_wb_o),
	.jal_mem_wb_o(jal_mem_wb_o),
	.jalr_mem_wb_o(jalr_mem_wb_o)
);

Write_Back WB(
    .MemtoReg(MemtoReg_mem_wb_o),
    .jal(jal_mem_wb_o),
    .jalr(jalr_mem_wb_o),
	.ALU_result_wb_i(ALU_result_mem_wb_o),   
	.loaddata_wb_i(loaddata_mem_wb_o),    
	.imme_wb_i(imme_mem_wb_o),
	.pc_wb_i(pc_mem_wb_o),
	.Wr_reg_data_wb_o(Wr_reg_data_wb_o)
);
    
endmodule
