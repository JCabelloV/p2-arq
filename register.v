module register #(parameter WIDTH = 8) (
    input  wire                 clk,
    input  wire                 rst,
    input  wire [WIDTH-1:0]     data,
    input  wire                 load,
    output reg  [WIDTH-1:0]     out
);
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            out <= {WIDTH{1'b0}};
        end else if (load) begin
            out <= data;
        end
    end
endmodule
