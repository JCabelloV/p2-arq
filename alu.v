module alu #(parameter WIDTH = 8, parameter OP_WIDTH = 4) (
    input  wire [WIDTH-1:0] in_a,
    input  wire [WIDTH-1:0] in_b,
    input  wire [OP_WIDTH-1:0] operation,
    output reg  [WIDTH-1:0] result,
    output reg               carry,
    output reg               zero,
    output reg               negative
);
    localparam [OP_WIDTH-1:0] OP_PASS = 4'd0;
    localparam [OP_WIDTH-1:0] OP_ADD  = 4'd1;
    localparam [OP_WIDTH-1:0] OP_SUB  = 4'd2;
    localparam [OP_WIDTH-1:0] OP_AND  = 4'd3;
    localparam [OP_WIDTH-1:0] OP_OR   = 4'd4;
    localparam [OP_WIDTH-1:0] OP_XOR  = 4'd5;
    localparam [OP_WIDTH-1:0] OP_NOT  = 4'd6;
    localparam [OP_WIDTH-1:0] OP_SHL  = 4'd7;
    localparam [OP_WIDTH-1:0] OP_SHR  = 4'd8;

    reg [WIDTH:0] extended;

    always @(*) begin
        result   = {WIDTH{1'b0}};
        carry    = 1'b0;
        zero     = 1'b0;
        negative = 1'b0;
        extended = {(WIDTH+1){1'b0}};

        case (operation)
            OP_PASS: begin
                result = in_a;
            end
            OP_ADD: begin
                extended = {1'b0, in_a} + {1'b0, in_b};
                result   = extended[WIDTH-1:0];
                carry    = extended[WIDTH];
            end
            OP_SUB: begin
                extended = {1'b0, in_a} - {1'b0, in_b};
                result   = extended[WIDTH-1:0];
                carry    = extended[WIDTH];
            end
            OP_AND: begin
                result = in_a & in_b;
            end
            OP_OR: begin
                result = in_a | in_b;
            end
            OP_XOR: begin
                result = in_a ^ in_b;
            end
            OP_NOT: begin
                result = ~in_a;
            end
            OP_SHL: begin
                result = in_a << 1;
                carry  = in_a[WIDTH-1];
            end
            OP_SHR: begin
                result = in_a >> 1;
                carry  = in_a[0];
            end
            default: begin
                result = {WIDTH{1'b0}};
            end
        endcase

        zero     = (result == {WIDTH{1'b0}});
        negative = result[WIDTH-1];
    end
endmodule
