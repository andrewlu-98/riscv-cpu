// ALU Control
module alu_control(
    input logic [1:0] ALUOp,
    input logic fun7,
    input logic [2:0] fun3,

    output logic [3:0] control_out
);
    always_comb begin
        casez({ALUOp, fun7, fun3})
            6'b00_?_???: control_out = 4'b0010; // add (ld/sd)
            6'b01_?_???: control_out = 4'b0110; // sub (beq)
            6'b10_0_000: control_out = 4'b0010; // add (R-type)
            6'b10_1_000: control_out = 4'b0110; // sub (R-type)
            6'b10_0_111: control_out = 4'b0000; // and (R-type)
            6'b10_0_110: control_out = 4'b0001; // or (R-type)
            default: control_out = '0; // and
        endcase
    end

endmodule