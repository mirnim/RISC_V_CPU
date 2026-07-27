module program_counter(
    input logic clk,
    input logic rst,
    input logic stall,

    input logic take_branch,
    input logic [31:0] branch_target,

    input logic [31:0] pc_plus_4,

    output logic [31:0] pc
);

    always_ff @(posedge clk) begin
        if (rst) begin
            pc <= 32'b0;
        end
        else if (take_branch) begin
            pc <= branch_target;
        end
        else if (!stall) begin
            pc <= pc_plus_4;
        end
    end

endmodule