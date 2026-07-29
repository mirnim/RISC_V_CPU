module instruction_fetch( 
    input logic [31:0] pc,
    
    output logic [31:0] instruction,
    output logic [31:0] pc_plus_4
);
    instruction_memory imem (.value(instruction), .pc(pc));
    assign pc_plus_4 = pc + 4;

endmodule
