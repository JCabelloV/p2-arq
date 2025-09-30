module instruction_memory #(parameter ADDR_WIDTH = 8, parameter DATA_WIDTH = 16) (
    input  wire [ADDR_WIDTH-1:0] address,
    output wire [DATA_WIDTH-1:0] out
);
    reg [DATA_WIDTH-1:0] mem [0:(1<<ADDR_WIDTH)-1];

    assign out = mem[address];
endmodule
