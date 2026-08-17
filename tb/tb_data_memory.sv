module tb_data_memory;
    logic clk, nrst, memWrite, memRead;
    logic [31:0] addr, write_data, mem_data_out;

    data_memory dut(
        .clk (clk),
        .nrst (nrst),
        .memWrite (memWrite),
        .memRead (memRead),
        .addr (addr),
        .write_data (write_data),
        .mem_data_out (mem_data_out)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("wf.vcd");
        $dumpvars(0, tb_data_memory);

        clk = 0; nrst = 0;
        #5;
        nrst = 1;
        #10;
        memWrite = 1'b1;
        addr = 32'h0004;
        write_data = 32'h0FF0;
        #10;
        memRead = 1'b1;
        #30;
        $finish;
    end

endmodule