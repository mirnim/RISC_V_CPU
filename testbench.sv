module testbench();
    logic clk, rst;
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end
    initial begin
        rst = 1'b1;
        #20 rst = 1'b0;
    end

    initial begin
        $dumpfile("testbench.vcd");
        $dumpvars(0, testbench);
    end
    
    core risc_v(.clk(clk), .rst(rst));
    
    always @(posedge clk) begin
        $display(
            "x1=%d x2=%d x5=%d, #256=%d, #255 = %d",
            risc_v.reg_file.registers[1],
            risc_v.reg_file.registers[2],
            risc_v.reg_file.registers[5],
            risc_v.data_mem.mem[64],
            risc_v.data_mem.mem[255]
        );
    end

    initial begin
        #200;
        $finish;
    end
endmodule
