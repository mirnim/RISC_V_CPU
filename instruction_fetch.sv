module instruction_fetch(
    output logic [31:0] instruction,
    input logic clk,
    input logic [0:0] PCnext,
    input logic [31:0] PC,
);
    logic [31:0] value;
    instruction_memory imem (.value(value), .PC(PC));

    always_ff @(posedge clk) begin
        if (PCnext) begin
            instruction <= value;
        end
    end

endmodule