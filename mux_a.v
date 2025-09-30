module mux_a #(parameter WIDTH = 8) (
    input  wire [WIDTH-1:0] reg_a,
    input  wire [WIDTH-1:0] reg_b,
    input  wire [WIDTH-1:0] immediate,
    input  wire [1:0]       select,
    output reg  [WIDTH-1:0] out
);
    always @(*) begin
        case (select)
            2'd0: out = reg_a;
            2'd1: out = reg_b;
            2'd2: out = immediate;
            default: out = {WIDTH{1'b0}};
        endcase
    end
endmodule
