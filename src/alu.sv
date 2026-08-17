/* verilator lint_off CASEINCOMPLETE */
module alu(
    input logic [31:0] a, b,
    input logic [3:0] control_in,

    output logic zero,
    output logic [31:0] ALU_result
);

    always_comb begin
        case (control_in)
            4'b0000: begin
                zero = 0;
                ALU_result = a & b;
            end
            4'b0001: begin
                zero = 0;
                ALU_result = a | b;
            end
            4'b0010: begin
                zero = 0;
                ALU_result = a + b;
            end
            4'b0110: begin
                zero = (a == b);
                ALU_result = a - b;
            end
            default: begin
                zero = 0;
                ALU_result = '0;
            end
        endcase
    end

endmodule