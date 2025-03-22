module MemOrIO(
    input wire [1:0] LType,//读取当前指令的funct3
    input wire mRead, // 读取内存信号，从 Controller
    input wire mWrite, // 写入内存信号，从 Controller
    input wire ioRead, // 读取 I/O 信号，从 Controller
    input wire ioWrite, // 写入 I/O 信号，从 Controller
    input wire [31:0] addr_in, // 从 ALU 结果
    input wire [31:0] m_rdata, // 从 Data-Memory 读取的数据
    input wire [15:0] io_rdata, // 从 I/O 读取的数据，16 bits
    input wire [31:0] r_rdata, // 从 Decoder (寄存器文件) 读取的数据
    output wire [31:0] addr_out, // 发送给 Data-Memory 的地址
    output reg [31:0] r_wdata, // 发送给 Decoder (寄存器文件) 的数据
    output reg [31:0] write_data, // 写入内存或 I/O 的数据（m_wdata, io_wdata）
    output wire LEDCtrl, // LED 芯片选择信号，为1时led灯/数码管显示当前输出
    output wire SwitchCtrl // 开关芯片选择信号，为1时开关的输入有效
);

assign addr_out = addr_in;

// 根据 ioRead 和 mRead 信号决定数据来源
always @* begin
    if (ioRead) begin
        r_wdata = {16'b0, io_rdata};
    end else if (mRead) begin
        case (LType)
            2'b00: r_wdata = m_rdata; // LW
            2'b01: r_wdata = {{24{m_rdata[7]}}, m_rdata[7:0]}; // LB, 符号扩展
            2'b10: r_wdata = {24'b0, m_rdata[7:0]}; // LBU, 零扩展
            default: r_wdata = m_rdata; // 默认读取32位数据
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
