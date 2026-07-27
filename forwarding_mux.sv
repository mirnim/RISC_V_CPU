module forwarding_mux import constants::forward_type_enum; (
    input logic [31:0] register_data,
    input logic [31:0] ex_mem_data,
    input logic [31:0] mem_wb_data,

    input forward_type_enum forward_type,

    output logic [31:0] forwarded_data
);

    always_comb begin
        case(forward_type)
            FORWARD_NONE: forwarded_data = register_data;
            FORWARD_EX_MEM: forwarded_data = ex_mem_data;
            FORWARD_MEM_WB: forwarded_data = mem_wb_data;
        endcase
    end

endmodule