module mux_data #(parameter WIDTH = 8) (
    input  wire [WIDTH-1:0] alu_data,
    input  wire [WIDTH-1:0] memory_data,
    input  wire             select_memory,
    output wire [WIDTH-1:0] out
);
    assign out = select_memory ? memory_data : alu_data;
endmodule
