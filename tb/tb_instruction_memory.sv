module tb_instruction_memory;
    logic clk, nrst;
    logic [5:0] read_addr;
    logic [31:0] instr_out;

    instruction_memory dut(
        .clk (clk),
        .nrst (nrst),
        .read_addr (read_addr),
        .instr_out (instr_out)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("wf.vcd");
        $dumpvars(0, tb_instruction_memory);

        clk = 0; nrst = 0;
        #5;
        nrst = 1;
        #10;
        read_addr = 6'd41; // instr currently filled with 0 from nrst
        #30;
        $finish;
    end

endmodule