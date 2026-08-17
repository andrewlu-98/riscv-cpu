module clock(
    output logic clk
);
    logic [22:0] counter = '0;
    logic flip = 1'b0; // flip clock
    logic clk_6m;

    // UPduino's internal high frequency oscillator
    SB_HFOSC #(
        .CLKHF_DIV("0b11") // divide 48 MHz by 2^(input)
    ) u_hfosc (
        .CLKHFPU(1'b1),    // power up the oscillator (1 = ON, 0 = OFF)
        .CLKHFEN(1'b1),    // enable the clock output
        .CLKHF(clk_6m)    // output clock signal
    );

    always_ff @(posedge clk_6m) begin
        if (counter > 6000000) begin
            clk <= ~clk;
            counter <= '0;
        end
        else begin
            counter <= counter + 1;
            if (!flip) begin
                clk <= ~clk;
                flip <= 1'b1;
            end
        end
    end
endmodule