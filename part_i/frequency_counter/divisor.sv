module divisor
(
	input logic clk, reset,
	input logic start,
	input logic [23:0] dvdr,
	output logic done_tick, ready,
	output logic [29:0] q
);
	localparam DVND = 1_000_000_000;

	typedef enum {idle, op, last, done} state_type;

	state_type state_reg, state_next;
	logic q_bit;
	logic [29:0] d_reg, d_next;
	logic [29:0] rl_reg, rl_next, rh_reg, rh_next, rh_temp;
	logic [4:0] n_reg, n_next;

	always_ff @(posedge clk, posedge reset)
		if (reset) begin
			state_reg <= idle;
			d_reg <= 30'b0;
			rl_reg <= 30'b0;
			rh_reg <= 30'b0;
			n_reg <= 3'b0;
		end
		else begin
			state_reg <= state_next;
			d_reg <= d_next;
			rl_reg <= rl_next;
			rh_reg <= rh_next;
			n_reg <= n_next;
		end

	always_comb
	begin
		state_next = state_reg;
		ready = 1'b0;
		done_tick = 1'b0;
		d_next = d_reg;
		rl_next = rl_reg;
		rh_next = rh_reg;
		n_next = n_reg;
		case (state_reg)
			idle: begin
			ready = 1'b1;
				if (start) begin
					state_next = op;
					n_next = 5'b11111; // 30 + 1
					d_next = {{6{1'b0}}, dvdr};
					rl_next = DVND;
					rh_next = 30'b0;
				end
			end
			op: begin
				rl_next = {rl_reg[28:0], q_bit};
				rh_next = {rh_temp[28:0], rl_reg[29]};
				n_next = n_reg - 1;
				if (n_next == 1) 
					state_next = last;
			end
			last: begin
				rl_next = {rl_reg[28:0], q_bit};
				rh_next = rh_temp;
				state_next = done;
			end
			done: begin
				done_tick = 1'b1;
				state_next = idle;
			end
			default: state_next = idle;
		endcase

	end

	always_comb
	begin
		if (rh_reg < d_reg) begin
			rh_temp = rh_reg;
			q_bit = 1'b0;
		end
		else begin
			rh_temp = rh_reg - d_reg;
			q_bit = 1'b1;
		end
	end

	assign q = rl_reg;

endmodule
