module Controller(
    input wire [21:0] Alu_resultHigh, // ALU 结果的高位部分
    input [2:0] funct3,//funct3部分用以计算load指令的类型
    input wire [6:0] inst, // 输入指令
    output reg Branch, // 分支信号
    output reg [1:0] ALUOp, // ALU 操作选择信号
    output reg ALUSrc, // ALU 源选择信号
    output reg MemRead, // 存储器读取信号
    output reg MemWrite, // 存储器写入信号
    output reg IORead, // IO 读取信号
    output reg IOWrite, // IO 写入信号
    output reg RegWrite, // 寄存器写入信号
    output reg Jal, // 跳转并链接信号
    output reg Jalr, // 跳转并链接寄存器信号
    output reg[1:0] LType//不同的load类型信号，00为lw,01为lb，10为lbu
);

always @* begin
    // 默认值
    Branch = 1'b0;
    ALUOp = 2'b00;
    ALUSrc = 1'b0;
    MemRead = 1'b0;
    MemWrite = 1'b0;
    IORead = 1'b0;
    IOWrite = 1'b0;
    RegWrite = 1'b0;
    Jal = 1'b0;
    Jalr = 1'b0;
    LType = 2;b00;
    case (inst[6:0])
        7'b0000011: begin // Load instructions (I-type)
            ALUOp = 2'b00;
            ALUSrc = 1'b1;
            RegWrite = 1'b1;
            if (Alu_resultHigh != 22'h3FFFFF) begin
                MemRead = 1'b1;
            end else begin
                IORead = 1'b1;
            end
        end
        7'b0100011: begin // Store instructions (S-type)
            ALUOp = 2'b00;
            ALUSrc = 1'b1;
            if (Alu_resultHigh != 22'h3FFFFF) begin
                MemWrite = 1'b1;
            end else begin
                IOWrite = 1'b1;
            end
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
            Jal = 1'b1;
            RegWrite = 1'b1; // 写入返回地址到寄存器
        end
        7'b1100111: begin // JALR instruction (I-type)
            Jalr = 1'b1;
            RegWrite = 1'b1; // 写入返回地址到寄存器
            ALUSrc = 1'b1; // 使用立即数作为偏移量
        end
        default: begin
            // 保持默认值
        end
        
    endcase
    case(funct3)
            3'b010:
            LType = 2'b00;
            3'b000:
            LType = 2'b01;
            3'b100:
            LType = 2'b10;
            default:
            LType = 2'b00;
       endcase
end

endmodule
