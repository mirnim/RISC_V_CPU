import constants::branch_type_enum;

module branch_unit(
    input branch_type_enum branch_type,
    input logic [31:0] pc,
    input logic [31:0] rs1,
    input logic [31:0] rs2,
    input logic [31:0] imm,

    output logic take_branch,
    output logic [31:0] branch_target
);

    always_comb begin
        take_branch = 1'b0;
        branch_target = pc + imm;
        case (branch_type)
            BRANCH_NONE: ;
            BRANCH_BEQ: take_branch = (rs1 == rs2);
            BRANCH_BNE: take_branch = (rs1 != rs2);
            BRANCH_BLT: take_branch = ($signed(rs1) < $signed(rs2));
            BRANCH_BGE: take_branch = ($signed(rs1) >= $signed(rs2));
            BRANCH_BLTU: take_branch = (rs1 < rs2);
            BRANCH_BGEU: take_branch = (rs1 >= rs2);
            BRANCH_JAL: take_branch = 1'b1;
            BRANCH_JALR: begin
                take_branch = 1'b1;
                branch_target = (rs1 + imm) & 32'hFFFFFFFE;
            end
        endcase
    end

endmodule