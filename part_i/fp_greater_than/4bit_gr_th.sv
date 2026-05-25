module gr_th_4bit
(
	input logic [3:0] a, b,
	output logic gr
);

	logic p0, p1, p2;

	gr_th unit1(.a(a[3:2]), .b(b[3:2]), .gr(p0));
	eq unit2(.a(a[3:2]), .b(b[3:2]), .eq(p1));
	gr_th unit3(.a(a[1:0]), .b(b[1:0]), .gr(p2));

	assign gr = p0 | (p1 & p2);

endmodule
