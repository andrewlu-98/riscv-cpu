module mux(
    input logic sel,
    input logic [31:0] a, b,

    output logic [31:0] mux_out
);
    assign mux_out = (sel) ? a : b;

endmodule

module adder(
    input logic [31:0] in1, in2,

    output logic [31:0] sum
);
    assign sum = in1 + in2;

endmodule

module logic_and(
    input logic branch, zero,

    output logic and_out
);
    assign and_out = branch & zero;

endmodule

module shift_left(
    input logic [31:0] in,
    
    output logic [31:0] out
);
    assign out = {in[30:0], 1'b0};

endmodule