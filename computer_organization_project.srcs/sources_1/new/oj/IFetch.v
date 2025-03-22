module IFetch(
    input clk,
	input rst,
	input start,
	input pc_jump,
	input jalr,
	input [31:0] Rd1,
	input [31:0] imm_jump,
	input [31:0] pc_if_i,
	output [31:0] pc_if_o,
	output reg [31:0] pc_next,
	input load_use_flag
    );
    
    PC_Reg pc_reg_inst (
        .clk(clk), 
        .rst(rst), 
        .pc(pc_if_i), 
        .pc_out(pc_if_o),
        .load_use_flag(load_use_flag)
    );
    
    always@(negedge clk) begin
                if(rst || !start)
                    pc_next <= 0;
                else if(load_use_flag)
                    pc_next <= pc_if_i;
                else if(jalr)
                    pc_next <= Rd1 + imm_jump;
                else if(pc_jump)
                    pc_next <= pc_if_i - 4 + imm_jump;
                else            //add 4
                    pc_next <= pc_if_i + 4;
            end
        
endmodule