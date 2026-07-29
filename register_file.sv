module register_file(
    input logic clk,

    input logic [4:0] rs1,
    input logic [4:0] rs2,

    input logic reg_write,
    input logic [4:0] rd,
    input logic [31:0] write_data,

    output logic [31:0] rs1_data,
    output logic [31:0] rs2_data
);

    logic [31:0] registers [0:31];
    
    assign rs1_data = (rs1 == 5'd0) ? 32'b0 : registers[rs1];
    assign rs2_data = (rs2 == 5'd0) ? 32'b0 : registers[rs2];

    always_ff @(posedge clk) begin
        if (reg_write && (rd != 5'b0)) begin
            registers[rd] <= write_data;
        end
    end
endmodule
