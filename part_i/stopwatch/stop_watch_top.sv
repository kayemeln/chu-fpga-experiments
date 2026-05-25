module stop_watch_cascade_top
(
	input logic clk,
	input logic [1:0] sw,
	output [7:0] seg,
	output [3:0] an
);

	logic [3:0] d2, d1, d0;

	stop_watch_cascade sw_unit(.clk(clk), .clr(sw[0]), .go(sw[1]), .d2(d2), .d1(d1), .d0(d0));

	disp_hex_mux disp_unit(.clk(clk), .reset(0), .hex0(4'b0), .hex1(d2), .hex2(d1), .hex3(d0), .dp_in(4'b1011), .sseg(seg), .an(an));

endmodule
