module hazard_unit import constants::load_type_enum; (
    input load_type_enum ex_load_type,
    input logic [4:0] ex_rd,
    input logic [4:0] id_rs1,
    input logic [4:0] id_rs2,

    output logic stall_pc,
    output logic stall_if_id,
    output logic flush_id_ex
);

    always_comb begin
        stall_pc = 1'b0;
        stall_if_id = 1'b0;
        flush_id_ex = 1'b0;

        if ((ex_load_type != LOAD_NONE) 
            && (ex_rd != 5'b0) 
            && ((ex_rd == id_rs1) || (ex_rd == id_rs2))) begin
                stall_pc = 1'b1;
                stall_if_id = 1'b1;
                flush_id_ex = 1'b1;
            end
    end

endmodule
