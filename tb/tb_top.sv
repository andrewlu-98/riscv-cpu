module tb_top;
    logic clk, nrst;

    top dut(
        .clk (clk),
        .nrst (nrst)
    );

    always #10 clk = ~clk;

    initial begin
        $dumpfile("wf.vcd");
        $dumpvars(0, tb_top);

        clk=0; nrst=0;
        #5 nrst=1;
        #300;
        $finish;
    end

endmodule