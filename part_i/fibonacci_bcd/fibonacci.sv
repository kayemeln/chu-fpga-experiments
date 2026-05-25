module fibonacci
(
	input logic clk, reset,
	input logic start,
	input logic [6:0] i,
	output logic ready, done_tick, overflow,
	output logic [19:0] f
);
	localparam OVFL = 9999;

	typedef enum {idle, op, done} state_type;

	state_type state_reg, state_next;
	logic [19:0] t1_reg, t1_next, t0_reg, t0_next;
	logic [7:0] n_reg, n_next;

	always_ff @(posedge clk, posedge reset)
		if (reset) begin
			state_reg <= idle;
			t1_reg <= 0;
			t0_reg <= 0;
			n_reg <= 0;
		end
		else begin
			state_reg <= state_next;
			t1_reg <= t1_next;
			t0_reg <= t0_next;
			n_reg <= n_next;
		end
	
	always_comb
	begin
		state_next = state_reg;
		t1_next = t1_reg;
		t0_next = t0_reg;
		n_next = n_reg;
		done_tick = 1'b0;
		ready = 1'b0;
		case(state_reg)
			idle: begin
				ready = 1'b1;
				if (start) begin
					state_next = op;
					t0_next = 20'b0;
					t1_next = 20'b1;
					n_next = i;
				end
			end
			op: begin
				if (n_reg == 0) begin
					t1_next = 20'b0;
					state_next = done;
				end	
				else if (n_reg == 1) begin
					state_next = done;
				end
				else begin
					t1_next = t1_reg + t0_reg;
					t0_next = t1_reg;
					n_next = n_reg - 1;
				end
			end
			done: begin
				done_tick = 1'b1;
				state_next = idle;
			end
			default: state_next = idle;
		endcase
	end

	assign f = t1_reg;
	assign overflow = (t1_reg > OVFL) ? 1'b1 : 1'b0;

endmodule
