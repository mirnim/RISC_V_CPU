module instruction_memory(
    output logic [31:0] value,
    input logic [31:0] pc
);
    logic [31:0] mem [4095:0];

    initial begin
        $readmemh("program_hex.txt", mem);
    end

    assign value = mem[(pc[13:2])];
endmodule
