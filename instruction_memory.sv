module instruction_memory(
    output logic [31:0] value,
    input logic [31:0] PC
);
    logic [31:0] mem [4095:0];

    initial begin
        $readmemh("program.hex", mem);
    end

    assign value = mem[(PC[13:2])];
endmodule