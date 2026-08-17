module main(
    output logic red, b5, b4, b3, b2, b1, b0
);
    assign red = clk_top;
    // assign {b5, b4, b3, b2, b1, b0} = mux_from_data_top[5:0]; // R, I, L type
    // assign {b5, b4, b3, b2, b1, b0} = read_data2_top[5:0]; // S type
    assign {b5, b4, b3, b2, b1, b0} = PC_top[7:2]; // SB type

    logic nrst = 1'b0;
    logic [1:0] counter = 2'b00;

    always_ff @(posedge clk_top) begin
        if (counter < 2'b10) begin
            nrst <= 1'b0;
            counter <= counter + 1;
        end
        else begin
            nrst <= 1'b1;
        end
    end

    logic clk_top;
    // PC, PC adder, instruction memory
    logic [31:0] PC_top, PC_adder_top, instr_top;

    // Control
    logic branch_top, memRead_top, memtoReg_top, memWrite_top, ALUSrc_top, regWrite_top;
    logic [1:0] ALUOp_top;

    // Register file
    logic [31:0] read_data1_top, read_data2_top;

    // Immediate generator
    logic [31:0] immExt_top;

    // ALU and peripherals
    logic [31:0] mux_to_alu_top;
    logic [3:0] ctrl_out_top;
    logic [31:0] alu_result_top;

    // Data memory
    logic [31:0] mem_data_top, mux_from_data_top;

    // Other logic
    logic [31:0] shift_left_top;
    logic [31:0] adder_top;
    logic zero_top, and_top;
    logic [31:0] mux_to_PC_top;

    clock clk(
        .clk(clk_top)
    );

    program_counter PC(
        .clk (clk_top), .nrst (nrst),
        .PC_in (mux_to_PC_top),
        .PC_out (PC_top)
    );

    PC_plus_4 PC_adder(
        .fromPC (PC_top),
        .nextPC (PC_adder_top)
    );

    instruction_memory instr_mem(
        .clk (clk_top), .nrst (nrst),
        .read_addr (PC_top),
        .instr_out (instr_top)
    );

    control ctrl(
        .opcode (instr_top[6:0]),
        .branch (branch_top), 
        .memRead (memRead_top), 
        .memtoReg (memtoReg_top), 
        .memWrite (memWrite_top), 
        .ALUSrc (ALUSrc_top), 
        .regWrite (regWrite_top),
        .ALUOp (ALUOp_top)
    );

    register_file reg_file(
        .clk (clk_top), .nrst (nrst), 
        .regWrite (regWrite_top),
        .rs1 (instr_top[19:15]),
        .rs2 (instr_top[24:20]),
        .rd (instr_top[11:7]),
        .write_data (mux_from_data_top),
        .read_data1 (read_data1_top),
        .read_data2 (read_data2_top)
    );

    immediate_generator imm_gen(
        .opcode (instr_top[6:0]),
        .instr (instr_top),
        .immExt (immExt_top)
    );
    
    mux mux_to_alu(
        .sel (ALUSrc_top),
        .a (immExt_top),
        .b (read_data2_top),
        .mux_out (mux_to_alu_top)
    );

    alu_control alu_ctrl(
        .ALUOp (ALUOp_top),
        .fun7 (instr_top[30]),
        .fun3 (instr_top[14:12]),
        .control_out (ctrl_out_top)
    );
    
    alu alu(
        .a (read_data1_top),
        .b (mux_to_alu_top),
        .control_in (ctrl_out_top),
        .zero (zero_top),
        .ALU_result (alu_result_top)
    );

    data_memory data_mem(
        .clk (clk_top), .nrst (nrst),
        .memWrite (memWrite_top),
        .memRead (memRead_top),
        .addr (alu_result_top),
        .write_data (read_data2_top),
        .mem_data_out (mem_data_top)
    );

    mux mux_from_data(
        .sel (memtoReg_top),
        .a (mem_data_top),
        .b (alu_result_top),
        .mux_out (mux_from_data_top)
    );

    shift_left shift_left(
        .in (immExt_top),
        .out (shift_left_top)
    );

    adder adder(
        .in1 (PC_top),
        .in2 (shift_left_top),
        .sum (adder_top)
    );

    logic_and logic_and(
        .branch (branch_top),
        .zero (zero_top),
        .and_out (and_top)
    );

    mux mux_to_PC(
        .sel (and_top),
        .a (adder_top),
        .b (PC_adder_top),
        .mux_out (mux_to_PC_top)
    );



endmodule