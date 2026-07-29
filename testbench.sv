module testbench();
    logic clk, rst;
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end
    initial begin
        rst = 1'b1;
        #20 rst = 1'b0;

        repeat (20) @(posedge clk);

        $finish;
    end
    
    core risc_v(.clk(clk), .rst(rst));

    $monitor("%t PC=%h INST=%h",
         $time,
         risc_v.if_pc,
         risc_v.if_instruction);

endmodule
