module test;
    reg clk = 0;
    reg rst = 1;

    wire [7:0] alu_out_bus;
    wire [7:0] pc_out_bus;
    wire [15:0] instruction_bus;
    wire [7:0] regA_out_bus;
    wire [7:0] regB_out_bus;
    wire [7:0] data_memory_out_bus;
    wire zero_flag;
    wire carry_flag;
    wire negative_flag;
    wire [7:0] last_opcode;

    computer Comp(
        .clk(clk),
        .rst(rst),
        .alu_out_bus(alu_out_bus),
        .pc_out_bus(pc_out_bus),
        .instruction_bus(instruction_bus),
        .regA_out_bus(regA_out_bus),
        .regB_out_bus(regB_out_bus),
        .data_memory_out_bus(data_memory_out_bus),
        .zero_flag(zero_flag),
        .carry_flag(carry_flag),
        .negative_flag(negative_flag),
        .last_opcode(last_opcode)
    );

    initial begin
        $dumpfile("out/dump.vcd");
        $dumpvars(0, test);

        $readmemb("im.dat", Comp.IM.mem);
        $readmemb("mem.dat", Comp.DM.mem);

        repeat (2) @(posedge clk);
        rst = 0;

        repeat (30) @(posedge clk);

        $display("Final A: 0x%0h", regA_out_bus);
        $display("Final B: 0x%0h", regB_out_bus);
        $display("Zero flag: %b, Carry flag: %b, Negative flag: %b", zero_flag, carry_flag, negative_flag);
        $display("Last opcode: 0x%0h", last_opcode);

        if (regA_out_bus !== 8'h81) begin
            $fatal(1, "Unexpected value for register A: 0x%0h", regA_out_bus);
        end
        if (regB_out_bus !== 8'h7E) begin
            $fatal(1, "Unexpected value for register B: 0x%0h", regB_out_bus);
        end
        if (last_opcode !== 8'h12) begin
            $fatal(1, "Unexpected last opcode: 0x%0h", last_opcode);
        end
        if (zero_flag !== 1'b0) begin
            $fatal(1, "Unexpected zero flag: %b", zero_flag);
        end
        if (negative_flag !== 1'b1) begin
            $fatal(1, "Unexpected negative flag: %b", negative_flag);
        end

        $display("Simulation completed successfully.");
        $finish;
    end

    always #1 clk = ~clk;
endmodule
