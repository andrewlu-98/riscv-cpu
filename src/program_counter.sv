// Program Counter
module program_counter(
    input logic clk, nrst,
    input logic [31:0] PC_in,
    output logic [31:0] PC_out
);
    always_ff @(posedge clk or negedge nrst) begin
        if (!nrst) begin
            PC_out <= '0;
        end
        else begin
            PC_out <= PC_in;
        end
    end

endmodule


// PC + 4
module PC_plus_4(
    input logic [31:0] fromPC,
    output logic [31:0] nextPC
);
    assign nextPC = fromPC + 4;

endmodule