module disp_hex_mux
(
	input logic clk, reset,
	input logic [3:0] hex3, hex2, hex1, hex0,
	input logic [3:0] dp_in,
	output logic [7:0] sseg,
	output logic [3:0] an
);

	localparam N = 18; // to create counter to slowdown time multiplexing
	// Internal signal declaration
	logic [N-1:0] q_reg, q_next;
	logic [3:0] hex_in;
	logic dp;

	always_ff @(posedge clk, posedge reset)
	begin
		if (reset)
			q_reg <= 0;
		else
			q_reg <= q_next;
	end

	// Next-state logic
	assign q_next = q_reg + 1'b1;

	always_comb
	begin
		case(q_reg[N-1:N-2])
			2'b00:
			begin
				hex_in = hex3;
				dp = dp_in[0];
				an = 4'b1110;
			end
			2'b01:
			begin
				hex_in = hex2;
				dp = dp_in[1];
				an = 4'b1101;
			end
			2'b10:
			begin
				hex_in = hex1;
				dp = dp_in[2];
				an = 4'b1011;
			end
			default:
			begin
				hex_in = hex0;
				dp = dp_in[3];
				an = 4'b0111;
			end
		endcase
	end

	// hex to sseg
	always_comb
	begin
		case(hex_in)
				4'h0:	sseg[6:0] = 7'b1000000;
				4'h1:	sseg[6:0] = 7'b1111001;
				4'h2:	sseg[6:0] = 7'b0100100;
				4'h3:	sseg[6:0] = 7'b0110000;
				4'h4:	sseg[6:0] = 7'b0011001;
				4'h5:	sseg[6:0] = 7'b0010010;
				4'h6:	sseg[6:0] = 7'b0000010;
				4'h7:	sseg[6:0] = 7'b1111000;
				4'h8:	sseg[6:0] = 7'b0000000;
				4'h9:	sseg[6:0] = 7'b0011000;
				4'ha:	sseg[6:0] = 7'b0001000;
				4'hb:	sseg[6:0] = 7'b0000011;
				4'hc:	sseg[6:0] = 7'b1000110;
				4'hd:	sseg[6:0] = 7'b0100001;
				4'he:	sseg[6:0] = 7'b0000110;
			default:	sseg[6:0] = 7'b0001110;
		endcase
	end

	assign sseg[7] = dp;

endmodule
