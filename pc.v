module pc #(parameter WIDTH = 8) (
    input  wire             clk,
    input  wire             rst,
    input  wire             load,
    input  wire [WIDTH-1:0] data,
    output reg  [WIDTH-1:0] value
);
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            value <= {WIDTH{1'b0}};
        end else if (load) begin
            value <= data;
        end else begin
            value <= value + 1'b1;
        end
    end
endmodule
