module instruction_memory(
    output logic [31:0] value,
    input logic [31:0] address
);
    logic [31:0] mem [4095:0];

    

    assign value = mem[(address[13:2])];
endmodule