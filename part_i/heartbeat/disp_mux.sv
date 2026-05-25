module disp_mux
(
	input logic clk, reset,
	input logic [7:0] in3, in2, in1, in0,
	output logic [3:0] an,
	output logic [7:0] sseg
);

	// For N-bit counter
	localparam N = 18;
	// Internal signal declaration
	logic [N-1:0] r_reg;
	logic [N-1:0] r_next;

	always_ff @(posedge clk, posedge reset)
	begin
		if (reset)
			r_reg <= 0;
		else
			r_reg = r_next;
	end

	// Next-state logic
	assign r_next = r_reg + 1;

	always_comb
	begin
		case(r_reg[N-1:N-2])
			2'b00:
			begin
				an = 4'b1110;
				sseg = in0;
			end
			2'b01:
			begin
				an = 4'b1101;
				sseg = in1;
			end
			2'b10:
			begin
				an = 4'b1011;
				sseg = in2;
			end
			default:
			begin
				an = 4'b0111;
				sseg = in3;
			end
		endcase
	end

endmodule
