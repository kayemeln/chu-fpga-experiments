module fifo
#(
	parameter	ADDR_WIDTH=4,
			DATA_WIDTH=8
)
(
	input logic clk, reset,
	input logic rd, wr,
	input logic [2*DATA_WIDTH-1:0] w_data,
	output logic empty, full,
	output logic [DATA_WIDTH-1:0] r_data
);

	logic [ADDR_WIDTH-1:0] w_addr, r_addr;
	logic w_en, full_tmp;

	assign w_en = wr & ~full_tmp;
	assign full = full_tmp;

	// Instantiate modules
	fifo_ctrl #(.ADDR_WIDTH(ADDR_WIDTH)) c_unit(.*, .full(full_tmp));
	reg_file #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH)) f_unit(.*);

endmodule
