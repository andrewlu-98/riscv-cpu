// Register File
module register_file(
    input logic clk, nrst, regWrite,
    input logic [4:0] rs1, rs2, rd,
    input logic [31:0] write_data,
    
    output logic [31:0] read_data1, read_data2
);
    logic [31:0] register[31:0];

    initial begin
        register[0]  = 0;
        register[1]  = 4;
        register[2]  = 2;
        register[3]  = 24;
        register[4]  = 4;
        register[5]  = 1;
        register[6]  = 44;
        register[7]  = 4;
        register[8]  = 2;
        register[9]  = 1;
        register[10] = 23;
        register[11] = 4;
        register[12] = 90;
        register[13] = 10;
        register[14] = 20;
        register[15] = 30;
        register[16] = 6;
        register[17] = 50;
        register[18] = 60;
        register[19] = 70;
        register[20] = 80;
        register[21] = 80;
        register[22] = 90;
        register[23] = 70;
        register[24] = 60;
        register[25] = 5;
        register[26] = 4;
        register[27] = 32;
        register[28] = 12;
        register[29] = 34;
        register[30] = 5;
        register[31] = 10;
    end

    always_ff @(posedge clk) begin
        if(regWrite) begin
            register[rd] <= write_data;
        end
    end

    assign read_data1 = register[rs1];
    assign read_data2 = register[rs2];

endmodule