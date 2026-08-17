module immediate_generator(
    input logic [6:0] opcode,
    input logic [31:0] instr,
    output logic [31:0] immExt
);

    // takes immediates based on opcode and extends them to fit 32 bits
    always_comb begin
        casez (opcode)
            7'b0010011, 7'b0000011: immExt = {{20{instr[31]}}, instr[31:20]}; // i-type (load)
            7'b0100011: immExt = {{20{instr[31]}}, instr[31:25], instr[11:7]}; // s-type (store)
            7'b1100011: immExt = {{19{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0}; // b-type (branch)
            default: immExt = '0;
        endcase
    end

endmodule