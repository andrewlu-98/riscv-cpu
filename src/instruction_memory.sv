// Instruction Memory
module instruction_memory(
    input logic clk, nrst,
    input logic [31:0] read_addr,
    output logic [31:0] instr_out
);
    logic [31:0] mem [63:0];

    initial begin
        mem[0] = 32'b00000000000000000000000000000000;   // no operation

        // R-type
        mem[4] = 32'b0000000_11001_10000_000_01101_0110011;   // add x13, x16, x25 (x13=6+5)
        mem[8] = 32'b0100000_00011_01000_000_00101_0110011;   // sub x5, x8, x3
        mem[12] = 32'b0000000_00011_00010_111_00001_0110011;   // and x1, x2, x3
        mem[16] = 32'b0000000_00101_00011_110_00100_0110011;   // or x4, x3, x5

        // I-type
        mem[20] = 32'b000000000011_10101_000_10110_0010011;   // addi x22, x21, 3
        mem[24] = 32'b000000000001_01000_110_01001_0010011;   // ori x9, x8, 1

        // L-type:    imm          rs1   fun3 rd   opcode
        mem[28] = 32'b000000001111_00111_010_01000_0000011;   //lw x8, 15(x7) -> x8 = d_mem[19]
        mem[32] = 32'b000000000011_00011_010_01001_0000011;   // lw x9, 3(x3) -> x9 = d_mem[27]

        // S-type:    imm     rs2   rs1   fun3 imm  opcode
        mem[36] = 32'b0000000_01111_00101_010_11001_0100011;   // sw x15, 25(x5) -> d_mem[25+x5=3]=x15
        mem[40] = 32'b0000000_01110_11100_010_01010_0100011;   // sw x14, 10(x28) -> d_mem[10+x28=22]=x14

        // B-type
        mem[44] = 32'b00000000100101001000011001100011; // beq x9,x9, 12
    end

    assign instr_out = mem[read_addr];

endmodule