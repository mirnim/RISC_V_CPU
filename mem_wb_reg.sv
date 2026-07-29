module mem_wb_reg import constants::writeback_type_enum; (
    input logic clk,
    input logic rst,

    input logic [31:0] mem_alu_result,
    input logic [31:0] mem_load_result,
    input logic [31:0] mem_pc_plus_4,
    input logic [31:0] mem_imm,
    input logic [4:0] mem_rd,
    input logic mem_reg_write,
    input writeback_type_enum mem_writeback_type,

    output logic [31:0] wb_alu_result,
    output logic [31:0] wb_load_result,
    output logic [31:0] wb_pc_plus_4,
    output logic [31:0] wb_imm,
    output logic [4:0] wb_rd,
    output logic wb_reg_write,
    output writeback_type_enum wb_writeback_type
);

    always_ff @(posedge clk) begin
        if (rst) begin
            wb_alu_result <= 32'b0;
            wb_load_result <= 32'b0;
            wb_pc_plus_4 <= 32'b0;
            wb_imm <= 32'b0;
            wb_rd <= 5'b0;
            wb_reg_write <= 1'b0;
            wb_writeback_type <= WRITEBACK_NONE;
        end else begin
            wb_alu_result <= mem_alu_result;
            wb_load_result <= mem_load_result;
            wb_pc_plus_4 <= mem_pc_plus_4;
            wb_imm <= mem_imm;
            wb_rd <= mem_rd;
            wb_reg_write <= mem_reg_write;
            wb_writeback_type <= mem_writeback_type;
        end
    end

endmodule
