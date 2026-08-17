// Control Unit
module control(
    input logic [6:0] opcode,

    output logic branch, memRead, memtoReg, memWrite, ALUSrc, regWrite,
    output logic [1:0] ALUOp
);
    always_comb begin
        case(opcode)
            7'b0110011: {ALUSrc, memtoReg, regWrite, memRead, memWrite, branch, ALUOp} = 8'b001000_10; // R
            7'b0010011: {ALUSrc, memtoReg, regWrite, memRead, memWrite, branch, ALUOp} = 8'b101000_10; // I
            7'b0000011: {ALUSrc, memtoReg, regWrite, memRead, memWrite, branch, ALUOp} = 8'b111100_00; // L
            7'b0100011: {ALUSrc, memtoReg, regWrite, memRead, memWrite, branch, ALUOp} = 8'b100010_00; // S
            7'b1100011: {ALUSrc, memtoReg, regWrite, memRead, memWrite, branch, ALUOp} = 8'b000001_01; // B
            default: {ALUSrc, memtoReg, regWrite, memRead, memWrite, branch, ALUOp} = '0;
        endcase
    end

endmodule
