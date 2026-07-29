module alu_control import constants::*; (
    input logic [31:0] pc,
    input logic [31:0] rs1_data,
    input logic [31:0] rs2_data,
    input logic [31:0] imm,

    input alu_source1_enum alu_source1,
    input alu_source2_enum alu_source2,

    output logic [31:0] alu_input1,
    output logic [31:0] alu_input2
);

    assign alu_input1 = (alu_source1 == INPUT1_REG) ? rs1_data : pc;
    assign alu_input2 = (alu_source2 == INPUT2_REG) ? rs2_data : imm;

endmodule
