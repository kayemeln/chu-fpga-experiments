module b_shft_top
(
	input logic [15:0] sw,
	output logic [15:0] led
);

	b_shft_r unit(.x(sw[7:0]), .amnt(sw[14:12]), .lr(sw[15]), .y(led[7:0]));

endmodule