module MemOrIO(
    input wire [1:0] LType,//��ȡ��ǰָ���funct3
    input wire mRead, // ��ȡ�ڴ��źţ��� Controller
    input wire mWrite, // д���ڴ��źţ��� Controller
    input wire ioRead, // ��ȡ I/O �źţ��� Controller
    input wire ioWrite, // д�� I/O �źţ��� Controller
    input wire [31:0] addr_in, // �� ALU ���
    input wire [31:0] m_rdata, // �� Data-Memory ��ȡ������
    input wire [15:0] io_rdata, // �� I/O ��ȡ�����ݣ�16 bits
    input wire [31:0] r_rdata, // �� Decoder (�Ĵ����ļ�) ��ȡ������
    output wire [31:0] addr_out, // ���͸� Data-Memory �ĵ�ַ
    output reg [31:0] r_wdata, // ���͸� Decoder (�Ĵ����ļ�) ������
    output reg [31:0] write_data, // д���ڴ�� I/O �����ݣ�m_wdata, io_wdata��
    output wire LEDCtrl, // LED оƬѡ���źţ�Ϊ1ʱled��/�������ʾ��ǰ���
    output wire SwitchCtrl // ����оƬѡ���źţ�Ϊ1ʱ���ص�������Ч
);

assign addr_out = addr_in;

// ���� ioRead �� mRead �źž���������Դ
always @* begin
    if (ioRead) begin
        r_wdata = {16'b0, io_rdata};
    end else if (mRead) begin
        case (LType)
            2'b00: r_wdata = m_rdata; // LW
            2'b01: r_wdata = {{24{m_rdata[7]}}, m_rdata[7:0]}; // LB, ������չ
            2'b10: r_wdata = {24'b0, m_rdata[7:0]}; // LBU, ����չ
            default: r_wdata = m_rdata; // Ĭ�϶�ȡ32λ����
        endcase
    end else begin
        r_wdata = 32'b0;
    end
end

// Address ranges for LEDs and switches
 assign LEDCtrl = (ioWrite == 1'b1)? 1'b1:1'b0;
 assign SwitchCtrl = (ioRead == 1'b1)? 1'b1:1'b0;

always @* begin
    if (mWrite || ioWrite) begin
        if (ioWrite) 
            write_data = {16'b0, r_rdata[15:0]};
        else 
            write_data = r_rdata;
    end else begin
        write_data = 32'hZZZZZZZZ;
    end
end

endmodule
