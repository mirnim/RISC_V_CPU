module forwarding_mux import constants::*; (
    input logic [31:0] register_data,
    input logic [31:0] mem_forward_data,
    input logic [31:0] wb_forward_data,

    input forward_type_enum forward_type,

    output logic [31:0] forwarded_data
);

    always_comb begin
        forwarded_data = register_data;
        
        case(forward_type)
            FORWARD_NONE: forwarded_data = register_data;
            FORWARD_EX_MEM: forwarded_data = mem_forward_data;
            FORWARD_MEM_WB: forwarded_data = wb_forward_data;
            default: ;
        endcase
    end

endmodule
