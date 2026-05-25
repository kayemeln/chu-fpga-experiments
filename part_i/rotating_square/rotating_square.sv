module rotating_square
(
	input logic clk, reset,
	output [7:0] sseg,
	output [3:0] an
);

	localparam DVDR = 10_000_000;
	// Internal signals
	logic [23:0] dvdr_reg, dvdr_next;
	logic dvdr_tick;
	logic [2:0] square_count_reg, square_count_next;
	logic [7:0] sseg_reg, sseg_next;
	logic [3:0] an_reg, an_next;

	always_ff @(posedge clk)
	begin
		dvdr_reg <= dvdr_next;
		sseg_reg <= sseg_next;
		an_reg <= an_next;
		square_count_reg <= square_count_next;
	end

	// Next-state logic
	assign dvdr_next = (reset || dvdr_reg == DVDR) ? 24'b0 : dvdr_reg + 1;
	assign dvdr_tick = (dvdr_reg == DVDR) ? 1'b1 : 1'b0;

	assign square_count_next = (reset) ? 4'b0 : 
		(dvdr_tick) ? square_count_reg + 1 : square_count_reg;

	always_comb
	begin
		if (square_count_reg[2])
			sseg_next = 8'b10011100;
		else
			sseg_next = 8'b10100011;

		case (square_count_reg)
			3'd0: an_next = 4'b0111;
			3'd1: an_next = 4'b1011;
			3'd2: an_next = 4'b1101;
			3'd3: an_next = 4'b1110;
			3'd4: an_next = 4'b1110;
			3'd5: an_next = 4'b1101;
			3'd6: an_next = 4'b1011;
			3'd7: an_next = 4'b0111;
		endcase

	end

	assign sseg = sseg_reg;
	assign an = an_reg;

endmodule
