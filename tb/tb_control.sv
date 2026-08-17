module tb_control;
    logic [6:0] opcode;
    logic branch, memRead, memtoReg, memWrite, ALUSrc, regWrite;
    logic [1:0] ALUOp;

    control dut(
        .opcode (opcode),
        .branch (branch),
        .memRead (memRead),
        .memtoReg (memtoReg),
        .memWrite (memWrite),
        .ALUSrc (ALUSrc),
        .regWrite (regWrite),
        .ALUOp (ALUOp)
    );

    initial begin
        $dumpfile("wf.vcd");
        $dumpvars(0, tb_control);

        #5;
        instr = 7'b0110011;
        #5;
        instr = 7'b0000011;
        #5;
        instr = 7'b0100011;
        #5;
        instr = 7'b1100011;
        #20;
        $finish;
    end

endmodule