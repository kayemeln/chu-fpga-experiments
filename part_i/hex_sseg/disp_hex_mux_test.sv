module disp_hex_mux_test
(
	input logic clk,
	input logic [15:0] sw,
	output logic [7:0] seg,
	output logic [3:0] an
);

	logic [3:0] a, b;
	logic [7:0] sum;

	disp_hex_mux unit(.clk(clk), .reset(sw[15]), .hex3(sum[7:4]), .hex2(sum[3:0]), .hex1(b), .hex0(a), .dp_in(4'b1011), .sseg(seg), .an(an));

	assign a = sw[3:0];
	assign b = sw[7:4];
	assign sum = {4'b0, a} + {4'b0, b};

endmodule
