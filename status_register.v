module status_register #(parameter WIDTH = 8) (
    input  wire             clk,
    input  wire             rst,
    input  wire             enable,
    input  wire             zero_in,
    input  wire             carry_in,
    input  wire             negative_in,
    input  wire [WIDTH-1:0] opcode_in,
    output reg              zero,
    output reg              carry,
    output reg              negative,
    output reg  [WIDTH-1:0] last_opcode
);
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            zero        <= 1'b0;
            carry       <= 1'b0;
            negative    <= 1'b0;
            last_opcode <= {WIDTH{1'b0}};
        end else if (enable) begin
            zero        <= zero_in;
            carry       <= carry_in;
            negative    <= negative_in;
            last_opcode <= opcode_in;
        end
    end
endmodule
