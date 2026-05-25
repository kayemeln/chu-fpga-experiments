module reg_file
#(
	parameter	DATA_WIDTH = 8,
			ADDR_WIDTH = 3	
)
(
	input logic clk,
	input logic [ADDR_WIDTH-1:0] w_addr, r_addr,
	input logic w_en,
	input logic [2*DATA_WIDTH-1:0] w_data,
	output logic [DATA_WIDTH-1:0] r_data
);

	logic [DATA_WIDTH-1:0] array_reg [0:2**ADDR_WIDTH-1];

	always_ff @(posedge clk)
		if (w_en) begin
			array_reg[w_addr] <= w_data[(2*DATA_WIDTH-1):DATA_WIDTH];
			array_reg[w_addr + 1] <= w_data[(DATA_WIDTH-1):0];
		end

	assign r_data = array_reg[r_addr];

endmodule
