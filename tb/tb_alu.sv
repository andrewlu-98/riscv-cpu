module tb_alu;
    logic [31:0] a, b;
    logic [3:0] control_in;
    logic zero;
    logic [31:0] ALU_result;

    alu dut(
        .a (a),
        .b (b),
        .control_in (control_in),
        .zero (zero),
        .ALU_result (ALU_result)
    );

    initial begin
        $dumpfile("wf.vcd");
        $dumpvars(0, tb_alu);

        #5;
        a = 32'hFFF0;
        b = 32'h0010;
        control_in = 4'b0010;
        #10;
        control_in = 4'b0001;
        #20;
        $finish;
    end

endmodule