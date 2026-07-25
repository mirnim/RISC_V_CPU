module data_memory(
    input logic clk,
    input logic write_enable,
    input logic [3:0] byte_enable,
    input logic [31:0] address,
    input logic [31:0] write_data,
    
    output logic [31:0] read_data    
);
    logic [31:0] mem [0:4095];

    assign read_data = mem[(address[13:2])];

    always_ff @(posedge clk) begin
        if (write_enable) begin
            if (byte_enable[0]) mem[address[13:2]][7:0] <= write_data [7:0];
            if (byte_enable[1]) mem[address[13:2]][15:8] <= write_data [15:8];
            if (byte_enable[2]) mem[address[13:2]][23:16] <= write_data [23:16];
            if (byte_enable[3]) mem[address[13:2]][31:24] <= write_data [31:24];
        end
    end
endmodule