module gr_th_4bit_top
(
	input logic [7:0] sw,
	output logic [0:0] led
);

	gr_th_4bit unit(.a(sw[7:4]), .b(sw[3:0]), .gr(led[0]));

endmodule
