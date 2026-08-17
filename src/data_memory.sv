module data_memory(
    input logic clk, nrst,
    input logic memWrite, memRead,
    input logic [31:0] addr, write_data,

    output logic [31:0] mem_data_out
);
    logic [31:0] d_mem[63:0];

    initial begin
        d_mem[19] = 56;
        d_mem[27] = 57;
    end
  
    always_ff @(negedge clk) begin
        if(memWrite) begin
            d_mem[addr] <= write_data;
        end
        mem_data_out = (memRead) ? d_mem[addr] : '0;
    end

endmodule