module gr_th_top
(
	input logic [3:0] sw,
	output logic [0:0] led
);

	gr_th unit(.a(sw[3:2]), .b(sw[1:0]), .gr(led[0]));

endmodule