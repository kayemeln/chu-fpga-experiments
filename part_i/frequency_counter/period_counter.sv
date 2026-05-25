module period_counter
(
	input logic clk, reset,
	input logic start, si,
	output logic ready, done_tick,
	output logic [23:0] prd
);
	localparam CLK_US_COUNT = 100;

	typedef enum {idle, waite, count, done} state_type;

	state_type state_reg, state_next;
	logic [23:0] p_reg, p_next;
	logic [6:0] t_reg, t_next; // Only needs to reach 7'd99
	logic delay_reg;
	logic edg;

	always_ff @(posedge clk, posedge reset)
		if (reset) begin
			state_reg <= idle;
			p_reg <= 24'b0;
			t_reg <= 7'b0;
			delay_reg <= 1'b0;
		end
		else begin
			state_reg <= state_next;
			p_reg <= p_next;
			t_reg <= t_next;
			delay_reg <= si;
		end

	assign edg = si & ~delay_reg;

	always_comb
	begin
		state_next = state_reg;
		p_next = p_reg;
		t_next = t_reg;
		ready = 1'b0;
		done_tick = 1'b0;
		case (state_reg)
			idle: begin
				ready = 1'b1;
				if (start)
					state_next = waite;
			end
			waite: begin
				if (edg) begin
					state_next = count;
					t_next = 7'b0;
					p_next = 10'b0;
				end
			end
			count: begin
				if (edg) begin
					state_next = done;
				end
				else begin
					if (t_reg == CLK_US_COUNT - 1) begin
						t_next = 7'b0;
						p_next = p_reg + 1;
					end
					else begin
						t_next = t_reg + 1;
					end
				end
			end
			done: begin
				done_tick = 1'b1;
				state_next = idle;
			end
			default: state_next = idle;
		endcase
	end

	assign prd = p_reg;

endmodule
