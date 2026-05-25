module debounce_test_top
(
	input logic clk,
	input logic [0:0] sw,
	input logic btnC,
	output logic [7:0] seg,
	output logic [3:0] an
);

	logic db;
	logic en, en_db;
	logic [3:0] hex3, hex2, hex1, hex0;
	logic [7:0] count, count_db;

	db_fsm debouncer(.clk(clk), .reset(sw[0]), .sw(btnC), .db(db));
	edge_detect edge_db(.clk(clk), .reset(sw[0]), .level(db), .tick(en_db));
	edge_detect edge_norm(.clk(clk), .reset(sw[0]), .level(btnC), .tick(en));
	counter count_unit_db(.clk(clk), .reset(sw[0]), .en(en_db), .count(count_db));
	counter count_unit(.clk(clk), .reset(sw[0]), .en(en), .count(count));

	assign hex0 = count[7:4];
	assign hex1 = count[3:0];
	assign hex2 = count_db[7:4];
	assign hex3 = count_db[3:0];
	disp_hex_mux sseg(.clk(clk), .reset(sw[0]), .hex3(hex3), .hex2(hex2), .hex1(hex1), .hex0(hex0), .dp_in(4'b1111), .sseg(seg), .an(an));
endmodule
