module core(
    input logic clk,
    input logic rst
);

    logic take_branch;

    logic flush_if_id, flush_id_ex;
    assign flush_if_id = take_branch;
    assign flush_id_ex = (take_branch || hazard_flush_id_ex);

    instruction_fetch if_module(
        .clk(clk),
        .rst(rst),
           
    )

endmodule