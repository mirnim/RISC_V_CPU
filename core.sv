module core import constants::*; (
    input logic clk,
    input logic rst
);


    // #region IF
    logic stall_pc;
    logic take_branch;
    logic [31:0] branch_target;
    logic [31:0] if_pc_plus_4;
    logic [31:0] if_pc;

    program_counter pc_register(
        .clk(clk),
        .rst(rst),
        .stall(stall_pc),
        .take_branch(take_branch),
        .branch_target(branch_target),
        .pc_plus_4(if_pc_plus_4),
        .pc(if_pc)
    );

    logic [31:0] if_instruction;

    instruction_fetch if_module(
        .pc(if_pc),
        .pc_plus_4(if_pc_plus_4),
        .instruction(if_instruction)
    );

    // #endregion IF

    // #region IF_ID

    logic stall_if_id;
    logic flush_if_id;
    logic [31:0] id_pc;
    logic [31:0] id_pc_plus_4;
    logic [31:0] id_instruction;

    if_id_reg if_id_register(
        .clk(clk),
        .rst(rst),
        .stall(stall_if_id),
        .flush(flush_if_id),
        .if_pc(if_pc),
        .if_pc_plus_4(if_pc_plus_4),
        .if_instruction(if_instruction),
        .id_pc(id_pc),
        .id_pc_plus_4(id_pc_plus_4),
        .id_instruction(id_instruction)
    );

    // #endregion IF_ID

    // #region ID

    logic id_reg_write;
    load_type_enum id_load_type;
    store_type_enum id_store_type;
    writeback_type_enum id_writeback_type;
    branch_type_enum id_branch_type;
    alu_source1_enum id_alu_source1;
    alu_source2_enum id_alu_source2;
    alu_op_enum id_alu_op;
    logic [4:0] id_rd;
    logic [4:0] id_rs1;
    logic [4:0] id_rs2;

    imm_type_enum imm_type;

    instruction_decode id_module(
        .instruction(id_instruction),
        .reg_write(id_reg_write),
        .load_type(id_load_type),
        .store_type(id_store_type),
        .writeback_type(id_writeback_type),
        .branch_type(id_branch_type),
        .alu_source1(id_alu_source1),
        .alu_source2(id_alu_source2),
        .alu_op(id_alu_op),
        .imm_type(imm_type),
        .rd(id_rd),
        .rs1(id_rs1),
        .rs2(id_rs2)
    );

    logic [31:0] id_imm;
    immediate_generator imm_gen_module(
        .instruction(id_instruction),
        .imm_type(imm_type),
        .imm(id_imm)
    );

    logic [31:0] id_rs1_data;
    logic [31:0] id_rs2_data;

    logic wb_reg_write;
    logic [4:0] wb_rd;
    logic [31:0] wb_write_data;

    register_file reg_file(
        .clk(clk),
        .rs1(id_rs1),
        .rs2(id_rs2),
        .reg_write(wb_reg_write),
        .rd(wb_rd),
        .write_data(wb_write_data),
        .rs1_data(id_rs1_data),
        .rs2_data(id_rs2_data)
    );

    load_type_enum ex_load_type;
    logic [4:0] ex_rd;
    logic flush_id_ex;

    hazard_unit hazard(
        .ex_load_type(ex_load_type),
        .ex_rd(ex_rd),
        .id_rs1(id_rs1),
        .id_rs2(id_rs2),
        .stall_pc(stall_pc),
        .stall_if_id(stall_if_id),
        .flush_id_ex(flush_id_ex)
    );

    // #endregion ID

    // #region ID_EX
    logic [31:0] ex_pc;
    logic [31:0] ex_pc_plus_4;
    logic [31:0] ex_rs1_data;
    logic [31:0] ex_rs2_data;
    logic [31:0] ex_imm;
    logic ex_reg_write;
    load_type_enum ex_load_type;
    store_type_enum ex_store_type;
    writeback_type_enum ex_writeback_type;
    branch_type_enum ex_branch_type;
    alu_source1_enum ex_alu_source1;
    alu_source2_enum ex_alu_source2;
    alu_op_enum ex_alu_op;
    logic [4:0] ex_rd;
    logic [4:0] ex_rs1;
    logic [4:0] ex_rs2;

    id_ex_reg id_ex_register(
        .clk(clk),
        .rst(rst),
        .flush(flush_id_ex),
        .id_pc(id_pc),
        .id_pc_plus_4(id_pc_plus_4),
        .id_rs1_data(id_rs1_data),
        .id_rs2_data(id_rs2_data),
        .id_imm(id_imm),
        .id_rd(id_rd),
        .id_rs1(id_rs1),
        .id_rs2(id_rs2),
        .id_reg_write(id_reg_write),
        .id_load_type(id_load_type),
        .id_store_type(id_store_type),
        .id_writeback_type(id_writeback_type),
        .id_branch_type(id_branch_type),
        .id_alu_source1(id_alu_source1),
        .id_alu_source2(id_alu_source2),
        .id_alu_op(id_alu_op),
        .ex_pc(ex_pc),
        .ex_pc_plus_4(ex_pc_plus_4),
        .ex_rs1_data(ex_rs1_data),
        .ex_rs2_data(ex_rs2_data),
        .ex_imm(ex_imm),
        .ex_rd(ex_rd),
        .ex_rs1(ex_rs1),
        .ex_rs2(ex_rs2),
        .ex_reg_write(ex_reg_write),
        .ex_load_type(ex_load_type),
        .ex_store_type(ex_store_type),
        .ex_writeback_type(ex_writeback_type),
        .ex_branch_type(ex_branch_type),
        .ex_alu_source1(ex_alu_source1),
        .ex_alu_source2(ex_alu_source2),
        .ex_alu_op(ex_alu_op)
    );
    // #endregion ID_EX

    // #region EX

    logic [4:0] mem_rd;
    logic mem_reg_write;
    logic [4:0] wb_rd;
    logic wb_reg_write;

    forward_type_enum ex_forward1;
    forward_type_enum ex_forward2;

    forwarding_unit forwarding(
        .ex_rs1(ex_rs1),
        .ex_rs2(ex_rs2),
        .mem_rd(mem_rd),
        .mem_reg_write(mem_reg_write),
        .wb_rd(wb_rd),
        .wb_reg_write(wb_reg_write),
        .forward1(ex_forward1),
        .forward2(ex_forward2)
    );

    logic [31:0] mem_forward_data;
    logic [31:0] wb_forward_data;
    logic [31:0] ex_forwarded_data1;

    forwarding_mux forwarding_mux1(
        .register_data(ex_rs1_data),
        .mem_forward_data(mem_forward_data),
        .wb_forward_data(wb_forward_data),
        .forward_type(ex_forward1),
        .forwarded_data(ex_forwarded_data1)
    );

    logic [31:0] ex_forwarded_data2;

    forwarding_mux forwarding_mux2(
        .register_data(ex_rs2_data),
        .mem_forward_data(mem_forward_data),
        .wb_forward_data(wb_forward_data),
        .forward_type(ex_forward2),
        .forwarded_data(ex_forwarded_data2)
    );
    
    logic [31:0] ex_source1_data;
    logic [31:0] ex_source2_data;

    alu_control alu_ctrl(
        .pc(ex_pc),
        .rs1_data(ex_forwarded_data1),
        .rs2_data(ex_forwarded_data2),
        .imm(ex_imm),
        .alu_source1(ex_alu_source1),
        .alu_source2(ex_alu_source2),
        .alu_input1(ex_source1_data),
        .alu_input2(ex_source2_data)
    );

    logic [31:0] ex_alu_result;

    alu alu_module(
        .alu_op(ex_alu_op),
        .input1(ex_source1_data),
        .input2(ex_source2_data),
        .result(ex_alu_result)
    );

    logic ex_take_branch;
    logic [31:0] ex_branch_target;
    branch_unit branch (
        .branch_type(ex_branch_type),
        .pc(ex_pc),
        .rs1_data(ex_forwarded_data1),
        .rs2_data(ex_forwarded_data2),
        .imm(ex_imm),
        .take_branch(ex_take_branch),
        .branch_target(ex_branch_target)
    );
    // #endregion EX

    
/*

alu_control

alu

branch_unit

ex_mem_reg

data_memory

load_store_unit

mem_wb_reg

writeback_unit
*/


    logic flush_if_id, flush_id_ex;
    assign flush_if_id = take_branch;
    assign flush_id_ex = (take_branch || hazard_flush_id_ex);


endmodule