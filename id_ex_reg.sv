module id_ex_reg import constants::*; (
    input logic clk,
    input logic rst,
    input logic flush,

    input logic [31:0] id_pc,
    input logic [31:0] id_pc_plus_4,
    input logic [31:0] id_rs1_data,
    input logic [31:0] id_rs2_data,

    input logic [31:0] id_imm,

    input logic [4:0] id_rd,
    input logic [4:0] id_rs1,
    input logic [4:0] id_rs2,

    input logic id_reg_write,

    input load_type_enum id_load_type,
    input store_type_enum id_store_type,
    input writeback_type_enum id_writeback_type,
    input branch_type_enum id_branch_type,
    input alu_source_enum id_alu_source1,
    input alu_source_enum id_alu_source2,
    input alu_op_enum id_alu_op,

    output logic [31:0] ex_pc,
    output logic [31:0] ex_pc_plus_4,
    output logic [31:0] ex_rs1_data,
    output logic [31:0] ex_rs2_data,

    output logic [31:0] ex_imm,

    output logic [4:0] ex_rd,
    output logic [4:0] ex_rs1,
    output logic [4:0] ex_rs2,

    output logic ex_reg_write,

    output load_type_enum ex_load_type,
    output store_type_enum ex_store_type,
    output writeback_type_enum ex_writeback_type,
    output branch_type_enum ex_branch_type,
    output alu_source_enum ex_alu_source1,
    output alu_source_enum ex_alu_source2,
    output alu_op_enum ex_alu_op
);

    always_ff @(posedge clk) begin
        if (rst || flush) begin
            ex_pc             <= 32'b0;
            ex_pc_plus_4      <= 32'b0;
            ex_rs1_data       <= 32'b0;
            ex_rs2_data       <= 32'b0;
            ex_imm            <= 32'b0;

            ex_rd             <= 5'b0;
            ex_rs1            <= 5'b0;
            ex_rs2            <= 5'b0;

            ex_reg_write      <= 1'b0;

            ex_load_type      <= LOAD_NONE;
            ex_store_type     <= STORE_NONE;
            ex_writeback_type <= WRITEBACK_NONE;
            ex_branch_type    <= BRANCH_NONE;
            ex_alu_source1     <= INPUT1_REG;
            ex_alu_source1     <= INPUT2_REG;
            ex_alu_op         <= ALU_ADD;
        end
        else begin
            ex_pc             <= id_pc;
            ex_pc_plus_4      <= id_pc_plus_4;
            ex_rs1_data       <= id_rs1_data;
            ex_rs2_data       <= id_rs2_data;
            ex_imm            <= id_imm;

            ex_rd             <= id_rd;
            ex_rs1            <= id_rs1;
            ex_rs2            <= id_rs2;

            ex_reg_write      <= id_reg_write;

            ex_load_type      <= id_load_type;
            ex_store_type     <= id_store_type;
            ex_writeback_type <= id_writeback_type;
            ex_branch_type    <= id_branch_type;
            ex_alu_source1     <= id_alu_source1;
            ex_alu_source2     <= id_alu_source2;
            ex_alu_op         <= id_alu_op;
        end
    end
endmodule