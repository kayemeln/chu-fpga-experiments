module heartbeat_top
(
	input logic clk,
	input logic [0:0] sw,
	output logic [7:0] seg,
	output logic [3:0] an
);

	heartbeat unit(.clk(clk), .reset(sw[0]), .sseg(seg), .an(an));

endmodule
