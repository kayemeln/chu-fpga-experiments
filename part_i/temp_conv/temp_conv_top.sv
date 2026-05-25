module temp_conv_top
(
	input logic clk,
	input logic [15:0] sw,
	output logic [7:0] seg,
	output logic [3:0] an
);

	logic [7:0] temp;
	logic [7:0] temp_conv;
	logic [3:0] bcd3, bcd2, bcd1, bcd0;

	bcd_to_bin inst0(.clk(clk), .reset(sw[14]), .bcd(sw[11:0]), .start(1'b1), .ready(), .done_tick(), .bin(temp));
	temp_conv inst1(.clk(clk), .format(sw[15]), .temp(temp), .temp_conv(temp_conv));
	bin_to_bcd inst2(.clk(clk), .reset(sw[14]), .start(1'b1), .bin(temp_conv), .ready(), .done_tick(), .bcd3(bcd3), .bcd2(bcd2), .bcd1(bcd1), .bcd0(bcd0));
	disp_hex_mux inst3(.clk(clk), .reset(sw[14]), .hex0(bcd3), .hex1(bcd2), .hex2(bcd1), .hex3(bcd0), .dp_in(4'b1111), .sseg(seg), .an(an));

endmodule
