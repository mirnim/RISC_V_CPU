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

    always_comb begin

        if (rs1 == 5'd0)
            rs1_data = 32'b0;
        else if (reg_write && (rd == rs1) && (rd != 5'd0))
            rs1_data = write_data;
        else
            rs1_data = registers[rs1];


        if (rs2 == 5'd0)
            rs2_data = 32'b0;
        else if (reg_write && (rd == rs2) && (rd != 5'd0))
            rs2_data = write_data;
        else
            rs2_data = registers[rs2];

    end
    always_ff @(posedge clk) begin
        if (reg_write && (rd != 5'b0)) begin
            registers[rd] <= write_data;
        end
    end
endmodule
