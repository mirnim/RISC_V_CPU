module immediate_generator import constants::*; (
    input logic [31:0] instruction,
    input imm_type_enum imm_type,
    output logic [31:0] imm
);
    always_comb begin
        imm = 32'b0;
        case (imm_type)
            IMM_I: imm = {{20{instruction[31]}}, instruction[31:20]};
            IMM_S: imm = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
            IMM_B: imm = {{19{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0};
            IMM_U: imm = {instruction[31:12], 12'b0};
            IMM_J: imm = {{11{instruction[31]}}, instruction[31], instruction[19:12], instruction[20], instruction[30:21], 1'b0};
            default: ;
        endcase
    end
endmodule
