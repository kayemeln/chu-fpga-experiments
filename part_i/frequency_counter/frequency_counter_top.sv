module frequency_counter_top
(
	input logic clk,
	input logic [1:0] sw,
	input logic [0:0] JA,
	output logic [7:0] seg,
	output logic [3:0] an
);
	logic [3:0] bcd3, bcd2, bcd1, bcd0;
	logic [3:0] ann;
	frequency_counter freq_unit(.clk(clk), .reset(sw[0]), .si(JA[0]), .start(sw[1]), .done_tick(), .ann(ann), .bcd3(bcd3), .bcd2(bcd2), .bcd1(bcd1), .bcd0(bcd0));
	disp_hex_mux disp_unit(.clk(clk), .reset(sw[0]), .hex0(bcd3), .hex1(bcd2), .hex2(bcd1), .hex3(bcd0), .dp_in(ann), .sseg(seg), .an(an));

endmodule
