module writeback_unit import constants::writeback_type_enum; (
    input logic [31:0] alu_result,
    input logic [31:0] load_result,
    input logic [31:0] pc_plus_4,
    input logic [31:0] imm,
    input writeback_type_enum writeback_type,

    output logic [31:0] write_data
);

    always_comb begin
        write_data = 32'b0;
        
        case (writeback_type)
            WRITEBACK_ALU: write_data = alu_result;
            WRITEBACK_MEM: write_data = load_result;
            WRITEBACK_PC4: write_data = pc_plus_4;
            WRITEBACK_IMM: write_data = imm;
            default: ;
        endcase
    end

endmodule
