module branch_unit import constants::branch_type_enum; (
    input branch_type_enum branch_type,
    input logic [31:0] pc,
    input logic [31:0] rs1_data,
    input logic [31:0] rs2_data,
    input logic [31:0] imm,

    output logic take_branch,
    output logic [31:0] branch_target
);

    always_comb begin
        take_branch = 1'b0;
        branch_target = pc + imm;
        case (branch_type)
            BRANCH_NONE: ;
            BRANCH_BEQ: take_branch = (rs1_data == rs2_data);
            BRANCH_BNE: take_branch = (rs1_data != rs2_data);
            BRANCH_BLT: take_branch = ($signed(rs1_data) < $signed(rs2_data));
            BRANCH_BGE: take_branch = ($signed(rs1_data) >= $signed(rs2_data));
            BRANCH_BLTU: take_branch = (rs1_data < rs2_data);
            BRANCH_BGEU: take_branch = (rs1_data >= rs2_data);
            BRANCH_JAL: take_branch = 1'b1;
            BRANCH_JALR: begin
                take_branch = 1'b1;
                branch_target = (rs1_data + imm) & 32'hFFFFFFFE;
            end
        endcase
    end

endmodule
