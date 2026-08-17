module tb_register_file;
    logic clk, nrst, regWrite;
    logic [4:0] rs1, rs2, rd;
    logic [31:0] write_data, read_data1, read_data2;

    register_file dut(
        .clk (clk),
        .nrst (nrst),
        .regWrite(regWrite),
        .rs1 (rs1),
        .rs2 (rs2),
        .rd (rd),
        .write_data(write_data),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("wf.vcd");
        $dumpvars(0, tb_register_file);

        clk = 0; nrst = 0;
        #5;
        nrst = 1;
        #10;
        regWrite = 1'b1;
        rd = 5'b10000;
        write_data = 32'h002F;
        #10;
        rs1 = 5'b10000;
        #30;
        $finish;
    end

endmodule