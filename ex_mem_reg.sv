module ex_mem_reg import constants::*; (
    input logic clk,
    input logic rst,

    input logic [31:0] ex_alu_result,
    input logic [31:0] ex_rs2,
    input logic [4:0]  ex_rd,
    input logic [31:0] ex_pc_plus_4,
    input logic [31:0] ex_imm,

    input logic ex_reg_write,
    input writeback_type_enum ex_writeback_type,
    input load_type_enum ex_load_type,
    input store_type_enum ex_store_type,

    output logic [31:0] mem_alu_result,
    output logic [31:0] mem_rs2,
    output logic [4:0]  mem_rd,
    output logic [31:0] mem_pc_plus_4,
    output logic [31:0] mem_imm,

    output logic mem_reg_write,
    output writeback_type_enum mem_writeback_type,
    output load_type_enum mem_load_type,
    output store_type_enum mem_store_type
);

    always_ff @(posedge clk) begin
        if (rst) begin
            mem_alu_result <= 32'b0;
            mem_rs2 <= 32'b0;
            mem_rd <= 5'b0;
            mem_pc_plus_4 <= 32'b0;
            mem_imm <= 32'b0;

            mem_reg_write <= 1'b0;
            mem_writeback_type <= WRITEBACK_NONE;
            mem_load_type <= LOAD_NONE;
            mem_store_type <= STORE_NONE;
        end else begin
            mem_alu_result <= ex_alu_result;
            mem_rs2 <= ex_rs2;
            mem_rd <= ex_rd;
            mem_pc_plus_4 <= ex_pc_plus_4;
            mem_imm <= ex_imm;

            mem_reg_write <= ex_reg_write;
            mem_writeback_type <= ex_writeback_type;
            mem_load_type <= ex_load_type;
            mem_store_type <= ex_store_type;
        end
    end

endmodule