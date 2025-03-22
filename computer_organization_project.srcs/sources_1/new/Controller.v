module Controller(
    input wire [6:0] inst, // 输入指令
    output reg Branch, // 分支信号
    output reg [1:0] ALUOp, // ALU 操作选择信号
    output reg ALUSrc, // ALU 源选择信号
    output reg MemRead, // 存储器读取信号
    output reg MemWrite, // 存储器写入信号
    output reg RegWrite, // 寄存器写入信号
    output reg MemtoReg,  // 存储器到寄存器的信号
    output reg Jal,
    output reg Jalr
);

always @* begin
    // 默认值
    Branch = 1'b0;
    ALUOp = 2'b00;
    ALUSrc = 1'b0;
    MemRead = 1'b0;
    MemWrite = 1'b0;
    RegWrite = 1'b0;
    MemtoReg = 1'b0;
    case (inst[6:0])
        7'b0000011: begin // Load instructions (I-type)
            ALUOp = 2'b00;
            ALUSrc = 1'b1;
            RegWrite = 1'b1;
            MemRead = 1'b1;
            MemtoReg = 1'b1;
        end
        7'b0100011: begin // Store instructions (S-type)
            ALUOp = 2'b00;
            ALUSrc = 1'b1;
            MemWrite = 1'b1;
        end
        7'b1100011: begin // Branch instructions (B-type)
            Branch = 1'b1;
            ALUOp = 2'b01;
        end
        7'b0110011: begin // R-type instructions
            ALUOp = 2'b10;
            RegWrite = 1'b1;
        end
        7'b1101111: begin // JAL instruction (J-type)
            RegWrite = 1'b1; // 写入返回地址到寄存器
            Jal = 1'b1;
        end
        7'b1100111: begin // JALR instruction (I-type)
            RegWrite = 1'b1; // 写入返回地址到寄存器
            ALUSrc = 1'b1; // 使用立即数作为偏移量
            Jalr = 1'b1;
        end
        7'b0010011: begin // I-type instructions (ADDI, SLTI, XORI, etc.)
            ALUOp = 2'b11; // 自定义一个新的 ALU 操作码来区分 I-type 指令
            ALUSrc = 1'b1;
            RegWrite = 1'b1;
        end
        default: begin
            // 保持默认值
        end
    endcase
end

endmodule
