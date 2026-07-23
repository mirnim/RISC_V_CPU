import constants::alu_source_enum;

module alu_control(
    input logic [31:0] pc,
    input logic [31:0] rs1,
    input logic [31:0] rs2,
    input logic [31:0] imm,

    input alu_source1_enum alu_source1,
    input alu_source2_enum alu_source2,

    output logic [31:0] alu_input1,
    output logic [31:0] alu_input2
);

    assign alu_input1 = (alu_source1 == INPUT1_REG) ? rs1 : pc;
    assign alu_input2 = (alu_source2 == INPUT2_REG) ? rs2 : imm;

endmodule