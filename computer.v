module computer(
    input  wire        clk,
    input  wire        rst,
    output wire [7:0]  alu_out_bus,
    output wire [7:0]  pc_out_bus,
    output wire [15:0] instruction_bus,
    output wire [7:0]  regA_out_bus,
    output wire [7:0]  regB_out_bus,
    output wire [7:0]  data_memory_out_bus,
    output wire        zero_flag,
    output wire        carry_flag,
    output wire        negative_flag,
    output wire [7:0]  last_opcode
);
    wire [7:0]  pc_next_value;
    wire [7:0]  pc_value;
    wire [15:0] instruction;
    wire [7:0]  opcode;
    wire [7:0]  immediate;

    wire        load_a;
    wire        load_b;
    wire        pc_load;
    wire        mem_write;
    wire        select_memory;
    wire [1:0]  select_a;
    wire [1:0]  select_b;
    wire [3:0]  alu_operation;

    wire [7:0]  mux_a_out;
    wire [7:0]  mux_b_out;
    wire [7:0]  mux_data_out;

    wire        alu_carry;
    wire        alu_zero;
    wire        alu_negative;

    assign opcode     = instruction[15:8];
    assign immediate  = instruction[7:0];
    assign pc_out_bus = pc_value;
    assign instruction_bus = instruction;
    assign pc_next_value   = immediate;

    pc #(8) PC(
        .clk(clk),
        .rst(rst),
        .load(pc_load),
        .data(pc_next_value),
        .value(pc_value)
    );

    instruction_memory #(8, 16) IM(
        .address(pc_value),
        .out(instruction)
    );

    register #(8) regA(
        .clk(clk),
        .rst(rst),
        .data(mux_data_out),
        .load(load_a),
        .out(regA_out_bus)
    );

    register #(8) regB(
        .clk(clk),
        .rst(rst),
        .data(mux_data_out),
        .load(load_b),
        .out(regB_out_bus)
    );

    mux_a #(8) muxA(
        .reg_a(regA_out_bus),
        .reg_b(regB_out_bus),
        .immediate(immediate),
        .select(select_a),
        .out(mux_a_out)
    );

    mux_b #(8) muxB(
        .reg_a(regA_out_bus),
        .reg_b(regB_out_bus),
        .immediate(immediate),
        .select(select_b),
        .out(mux_b_out)
    );

    alu #(8, 4) ALU(
        .in_a(mux_a_out),
        .in_b(mux_b_out),
        .operation(alu_operation),
        .result(alu_out_bus),
        .carry(alu_carry),
        .zero(alu_zero),
        .negative(alu_negative)
    );

    data_memory #(8, 8) DM(
        .clk(clk),
        .write_enable(mem_write),
        .address(regB_out_bus),
        .write_data(regA_out_bus),
        .read_data(data_memory_out_bus)
    );

    mux_data #(8) muxData(
        .alu_data(alu_out_bus),
        .memory_data(data_memory_out_bus),
        .select_memory(select_memory),
        .out(mux_data_out)
    );

    control_unit CU(
        .opcode(opcode),
        .load_a(load_a),
        .load_b(load_b),
        .pc_load(pc_load),
        .mem_write(mem_write),
        .select_memory(select_memory),
        .select_a(select_a),
        .select_b(select_b),
        .alu_operation(alu_operation)
    );

    status_register #(8) STATUS(
        .clk(clk),
        .rst(rst),
        .enable(1'b1),
        .zero_in(alu_zero),
        .carry_in(alu_carry),
        .negative_in(alu_negative),
        .opcode_in(opcode),
        .zero(zero_flag),
        .carry(carry_flag),
        .negative(negative_flag),
        .last_opcode(last_opcode)
    );
endmodule
