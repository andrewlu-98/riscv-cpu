module tb_program_counter;
    logic clk, nrst;
    logic [31:0] PC_in, PC_out;

    program_counter dut(
        .clk (clk),
        .nrst (nrst),
        .PC_in (PC_in),
        .PC_out (PC_out)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("wf.vcd");
        $dumpvars(0, tb_program_counter);

        clk = 0; nrst = 0;
        #5;
        nrst = 1;
        #10;
        PC_in = 32'h0F00;
        #20;
        PC_in = '0;
        #30;
        $finish;
    end

endmodule