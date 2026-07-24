import constants::*;

module ex_mem_reg (
    input logic [31:0] ex_alu_result,
    input logic [31:0] ex_rs2,
    input logic [31:0] ex_rd,
    input logic [31:0] ex_pc_plus_4,

    input logic ex_reg_write,
    input writeback_type_enum ex_writeback_type,
    input load_type_enum ex_load_type,
    input store_type_enum ex_store_type

);

endmodule