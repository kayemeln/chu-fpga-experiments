module square_wave_top
(
	input logic clk,
	input logic [15:0] sw,
	output logic [0:0] JA
);

	square_wave unit(.clk(clk), .reset(sw[15]), .m(sw[3:0]), .n(sw[7:4]), .wave(JA[0]));

endmodule