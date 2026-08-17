module tb_alu_control;
    logic [1:0] ALUOp;
    logic fun7;
    logic [2:0] fun3;
    logic [3:0] control_out;

    alu_control dut(
        .ALUOp (ALUOp),
        .fun7 (fun7),
        .fun3 (fun3),
        .control_out (control_out)
    );

    initial begin
        $dumpfile("wf.vcd");
        $dumpvars(0, tb_alu_control);

        #5;
        ALUOp = 2'b10;
        fun7 = 1'b1;
        fun3 = 3'b000;
        #20;
        $finish;
    end

endmodule