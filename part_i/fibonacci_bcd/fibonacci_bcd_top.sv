module fibonacci_bcd_top
(
	input logic clk,
	input logic [15:0] sw,
	input logic btnC,
	output logic [7:0] seg,
	output logic [3:0] an
);

	fibonacci_bcd unit(.clk(clk), .reset(sw[15]), .start(btnC), .bcd(sw[7:0]), .sseg(seg), .aan(an));

endmodule
