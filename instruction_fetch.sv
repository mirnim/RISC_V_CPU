module instruction_fetch( //COMBINATORIAL
    input logic [31:0] PC,
    
    output logic [31:0] instruction,
    output logic [31:0] PC_plus_4
);
    instruction_memory imem (.value(instruction), .PC(PC));
    assign PC_plus_4 = PC + 4;

endmodule