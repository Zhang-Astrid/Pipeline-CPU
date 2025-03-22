module Controller(
    input wire [21:0] Alu_resultHigh, // ALU ����ĸ�λ����
    input [2:0] funct3,//funct3�������Լ���loadָ�������
    input wire [6:0] inst, // ����ָ��
    output reg Branch, // ��֧�ź�
    output reg [1:0] ALUOp, // ALU ����ѡ���ź�
    output reg ALUSrc, // ALU Դѡ���ź�
    output reg MemRead, // �洢����ȡ�ź�
    output reg MemWrite, // �洢��д���ź�
    output reg IORead, // IO ��ȡ�ź�
    output reg IOWrite, // IO д���ź�
    output reg RegWrite, // �Ĵ���д���ź�
    output reg Jal, // ��ת�������ź�
    output reg Jalr, // ��ת�����ӼĴ����ź�
    output reg[1:0] LType//��ͬ��load�����źţ�00Ϊlw,01Ϊlb��10Ϊlbu
);

always @* begin
    // Ĭ��ֵ
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
            RegWrite = 1'b1; // д�뷵�ص�ַ���Ĵ���
        end
        7'b1100111: begin // JALR instruction (I-type)
            Jalr = 1'b1;
            RegWrite = 1'b1; // д�뷵�ص�ַ���Ĵ���
            ALUSrc = 1'b1; // ʹ����������Ϊƫ����
        end
        default: begin
            // ����Ĭ��ֵ
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
