module data_memory #(parameter ADDR_WIDTH = 8, parameter DATA_WIDTH = 8) (
    input  wire                     clk,
    input  wire                     write_enable,
    input  wire [ADDR_WIDTH-1:0]    address,
    input  wire [DATA_WIDTH-1:0]    write_data,
    output wire [DATA_WIDTH-1:0]    read_data
);
    reg [DATA_WIDTH-1:0] mem [0:(1<<ADDR_WIDTH)-1];

    always @(posedge clk) begin
        if (write_enable) begin
            mem[address] <= write_data;
        end
    end

    assign read_data = mem[address];
endmodule
