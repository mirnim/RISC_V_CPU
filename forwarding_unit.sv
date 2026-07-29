module forwarding_unit import constants::*; (
    input logic [4:0] ex_rs1,
    input logic [4:0] ex_rs2,

    input logic [4:0] mem_rd,
    input logic mem_reg_write,

    input logic [4:0] wb_rd,
    input logic wb_reg_write,

    output forward_type_enum forward1,
    output forward_type_enum forward2
);

    always_comb begin
        forward1 = FORWARD_NONE;
        forward2 = FORWARD_NONE;
    
        if (mem_reg_write && (mem_rd != 5'b0) && (mem_rd == ex_rs1)) begin
            forward1 = FORWARD_EX_MEM;
        end else if (wb_reg_write && (wb_rd != 5'b0) && (wb_rd == ex_rs1)) begin
            forward1 = FORWARD_MEM_WB;
        end

        if (mem_reg_write && (mem_rd != 5'b0) && (mem_rd == ex_rs2)) begin
            forward2 = FORWARD_EX_MEM;
        end else if (wb_reg_write && (wb_rd != 5'b0) && (wb_rd == ex_rs2)) begin
            forward2 = FORWARD_MEM_WB;
        end

    end

endmodule
