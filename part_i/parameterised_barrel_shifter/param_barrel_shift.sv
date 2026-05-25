module param_b_shft
#(
	parameter N = 4 // bit-width = 16
)
(
	input logic [2**N-1:0] x,
	input logic [N-1:0] amnt,
	output logic [2**N-1:0] y
);

	// Internal signal declaration
	logic [2**N-1:0] s [N:0];
	assign s[0] = x;
	assign y = s[N];
	generate
		genvar i;
		for (i = 0; i <= N; i = i + 1) begin : barrel_stages
			localparam idx = 2**i;
			assign s[i + 1] = amnt[i] ? {s[i][idx-1:0], s[i][2**N-1:idx]} : s[i];
		end
	endgenerate

endmodule
