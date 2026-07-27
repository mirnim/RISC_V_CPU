module if_id_reg(
    input logic clk,
    input logic rst,
    input logic stall,
    input logic flush,
    input logic [31:0] if_pc,
    input logic [31:0] if_pc_plus_4,
    input logic [31:0] if_instruction,

    output logic [31:0] id_pc,
    output logic [31:0] id_pc_plus_4,
    output logic [31:0] id_instruction
);

    always_ff @(posedge clk) begin
        if (rst || flush) begin
            id_pc <= 0;
            id_pc_plus_4 <= 0;
            id_instruction <= 0;
        end else if (!stall) begin
            id_pc <= if_pc;
            id_pc_plus_4 <= if_pc_plus_4;
            id_instruction <= if_instruction;
        end
    end

endmodule