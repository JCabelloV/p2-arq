module control_unit (
    input  wire [7:0]  opcode,
    output reg         load_a,
    output reg         load_b,
    output reg         pc_load,
    output reg         mem_write,
    output reg         select_memory,
    output reg  [1:0]  select_a,
    output reg  [1:0]  select_b,
    output reg  [3:0]  alu_operation
);
    localparam [7:0] OP_MOV_A_B   = 8'h00;
    localparam [7:0] OP_MOV_B_A   = 8'h01;
    localparam [7:0] OP_MOV_A_LIT = 8'h02;
    localparam [7:0] OP_MOV_B_LIT = 8'h03;
    localparam [7:0] OP_ADD_A_B   = 8'h04;
    localparam [7:0] OP_ADD_B_A   = 8'h05;
    localparam [7:0] OP_ADD_A_LIT = 8'h06;
    localparam [7:0] OP_ADD_B_LIT = 8'h07;
    localparam [7:0] OP_SUB_A_B   = 8'h08;
    localparam [7:0] OP_SUB_B_A   = 8'h09;
    localparam [7:0] OP_SUB_A_LIT = 8'h0A;
    localparam [7:0] OP_SUB_B_LIT = 8'h0B;
    localparam [7:0] OP_AND_A_B   = 8'h0C;
    localparam [7:0] OP_AND_B_A   = 8'h0D;
    localparam [7:0] OP_AND_A_LIT = 8'h0E;
    localparam [7:0] OP_AND_B_LIT = 8'h0F;
    localparam [7:0] OP_OR_A_B    = 8'h10;
    localparam [7:0] OP_OR_B_A    = 8'h11;
    localparam [7:0] OP_OR_A_LIT  = 8'h12;
    localparam [7:0] OP_OR_B_LIT  = 8'h13;
    localparam [7:0] OP_NOT_A     = 8'h14;
    localparam [7:0] OP_NOT_B     = 8'h15;
    localparam [7:0] OP_XOR_A_B   = 8'h16;
    localparam [7:0] OP_XOR_B_A   = 8'h17;
    localparam [7:0] OP_XOR_A_LIT = 8'h18;
    localparam [7:0] OP_XOR_B_LIT = 8'h19;
    localparam [7:0] OP_SHL_A     = 8'h1A;
    localparam [7:0] OP_SHL_B     = 8'h1B;
    localparam [7:0] OP_SHR_A     = 8'h1C;
    localparam [7:0] OP_SHR_B     = 8'h1D;
    localparam [7:0] OP_INC_A     = 8'h1E;
    localparam [7:0] OP_INC_B     = 8'h1F;

    localparam [3:0] ALU_PASS = 4'd0;
    localparam [3:0] ALU_ADD  = 4'd1;
    localparam [3:0] ALU_SUB  = 4'd2;
    localparam [3:0] ALU_AND  = 4'd3;
    localparam [3:0] ALU_OR   = 4'd4;
    localparam [3:0] ALU_XOR  = 4'd5;
    localparam [3:0] ALU_NOT  = 4'd6;
    localparam [3:0] ALU_SHL  = 4'd7;
    localparam [3:0] ALU_SHR  = 4'd8;

    always @(*) begin
        load_a        = 1'b0;
        load_b        = 1'b0;
        pc_load       = 1'b0;
        mem_write     = 1'b0;
        select_memory = 1'b0;
        select_a      = 2'd0;
        select_b      = 2'd0;
        alu_operation = ALU_PASS;

        case (opcode)
            OP_MOV_A_B: begin
                load_a        = 1'b1;
                select_a      = 2'd1; // B
                alu_operation = ALU_PASS;
            end
            OP_MOV_B_A: begin
                load_b        = 1'b1;
                select_a      = 2'd0; // A
                alu_operation = ALU_PASS;
            end
            OP_MOV_A_LIT: begin
                load_a        = 1'b1;
                select_a      = 2'd2; // immediate
                alu_operation = ALU_PASS;
            end
            OP_MOV_B_LIT: begin
                load_b        = 1'b1;
                select_a      = 2'd2; // immediate
                alu_operation = ALU_PASS;
            end
            OP_ADD_A_B: begin
                load_a        = 1'b1;
                select_a      = 2'd0; // A
                select_b      = 2'd0; // B
                alu_operation = ALU_ADD;
            end
            OP_ADD_B_A: begin
                load_b        = 1'b1;
                select_a      = 2'd1; // B
                select_b      = 2'd1; // A
                alu_operation = ALU_ADD;
            end
            OP_ADD_A_LIT: begin
                load_a        = 1'b1;
                select_a      = 2'd0; // A
                select_b      = 2'd2; // immediate
                alu_operation = ALU_ADD;
            end
            OP_ADD_B_LIT: begin
                load_b        = 1'b1;
                select_a      = 2'd1; // B
                select_b      = 2'd2; // immediate
                alu_operation = ALU_ADD;
            end
            OP_SUB_A_B: begin
                load_a        = 1'b1;
                select_a      = 2'd0; // A
                select_b      = 2'd0; // B
                alu_operation = ALU_SUB;
            end
            OP_SUB_B_A: begin
                load_b        = 1'b1;
                select_a      = 2'd1; // B
                select_b      = 2'd1; // A
                alu_operation = ALU_SUB;
            end
            OP_SUB_A_LIT: begin
                load_a        = 1'b1;
                select_a      = 2'd0; // A
                select_b      = 2'd2; // immediate
                alu_operation = ALU_SUB;
            end
            OP_SUB_B_LIT: begin
                load_b        = 1'b1;
                select_a      = 2'd1; // B
                select_b      = 2'd2; // immediate
                alu_operation = ALU_SUB;
            end
            OP_AND_A_B: begin
                load_a        = 1'b1;
                select_a      = 2'd0;
                select_b      = 2'd0;
                alu_operation = ALU_AND;
            end
            OP_AND_B_A: begin
                load_b        = 1'b1;
                select_a      = 2'd1;
                select_b      = 2'd1;
                alu_operation = ALU_AND;
            end
            OP_AND_A_LIT: begin
                load_a        = 1'b1;
                select_a      = 2'd0;
                select_b      = 2'd2;
                alu_operation = ALU_AND;
            end
            OP_AND_B_LIT: begin
                load_b        = 1'b1;
                select_a      = 2'd1;
                select_b      = 2'd2;
                alu_operation = ALU_AND;
            end
            OP_OR_A_B: begin
                load_a        = 1'b1;
                select_a      = 2'd0;
                select_b      = 2'd0;
                alu_operation = ALU_OR;
            end
            OP_OR_B_A: begin
                load_b        = 1'b1;
                select_a      = 2'd1;
                select_b      = 2'd1;
                alu_operation = ALU_OR;
            end
            OP_OR_A_LIT: begin
                load_a        = 1'b1;
                select_a      = 2'd0;
                select_b      = 2'd2;
                alu_operation = ALU_OR;
            end
            OP_OR_B_LIT: begin
                load_b        = 1'b1;
                select_a      = 2'd1;
                select_b      = 2'd2;
                alu_operation = ALU_OR;
            end
            OP_NOT_A: begin
                load_a        = 1'b1;
                select_a      = 2'd0;
                alu_operation = ALU_NOT;
            end
            OP_NOT_B: begin
                load_b        = 1'b1;
                select_a      = 2'd1;
                alu_operation = ALU_NOT;
            end
            OP_XOR_A_B: begin
                load_a        = 1'b1;
                select_a      = 2'd0;
                select_b      = 2'd0;
                alu_operation = ALU_XOR;
            end
            OP_XOR_B_A: begin
                load_b        = 1'b1;
                select_a      = 2'd1;
                select_b      = 2'd1;
                alu_operation = ALU_XOR;
            end
            OP_XOR_A_LIT: begin
                load_a        = 1'b1;
                select_a      = 2'd0;
                select_b      = 2'd2;
                alu_operation = ALU_XOR;
            end
            OP_XOR_B_LIT: begin
                load_b        = 1'b1;
                select_a      = 2'd1;
                select_b      = 2'd2;
                alu_operation = ALU_XOR;
            end
            OP_SHL_A: begin
                load_a        = 1'b1;
                select_a      = 2'd0;
                alu_operation = ALU_SHL;
            end
            OP_SHL_B: begin
                load_b        = 1'b1;
                select_a      = 2'd1;
                alu_operation = ALU_SHL;
            end
            OP_SHR_A: begin
                load_a        = 1'b1;
                select_a      = 2'd0;
                alu_operation = ALU_SHR;
            end
            OP_SHR_B: begin
                load_b        = 1'b1;
                select_a      = 2'd1;
                alu_operation = ALU_SHR;
            end
            OP_INC_A: begin
                load_a        = 1'b1;
                select_a      = 2'd0;
                select_b      = 2'd2;
                alu_operation = ALU_ADD;
            end
            OP_INC_B: begin
                load_b        = 1'b1;
                select_a      = 2'd1;
                select_b      = 2'd2;
                alu_operation = ALU_ADD;
            end
            default: begin
                load_a        = 1'b0;
                load_b        = 1'b0;
                select_a      = 2'd0;
                select_b      = 2'd0;
                alu_operation = ALU_PASS;
            end
        endcase
    end
endmodule
