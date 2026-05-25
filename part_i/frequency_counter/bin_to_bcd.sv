module bin_to_bcd
(
	input logic clk, reset,
	input logic start,
	input logic [22:0] bin,
	output logic ready, done_tick,
	output logic [3:0] bcd6, bcd5, bcd4, bcd3, bcd2, bcd1, bcd0
);

	typedef enum {idle, op, done} state_type;

	// Internal signal declarations
	state_type state_reg, state_next;
	logic [22:0] p2s_reg, p2s_next;
	logic [4:0] n_reg, n_next;
	logic [3:0] bcd6_reg, bcd5_reg, bcd4_reg, bcd3_reg, bcd2_reg, bcd1_reg, bcd0_reg;
	logic [3:0] bcd6_next, bcd5_next, bcd4_next, bcd3_next, bcd2_next, bcd1_next, bcd0_next;
	logic [3:0] bcd6_temp, bcd5_temp, bcd4_temp, bcd3_temp, bcd2_temp, bcd1_temp, bcd0_temp;

	always_ff @(posedge clk, posedge reset)
		if (reset)
		begin
			state_reg <= idle;
			p2s_reg <= 0;
			n_reg <= 0;
			bcd6_reg <= 0;
			bcd5_reg <= 0;
			bcd4_reg <= 0;
			bcd3_reg <= 0;
			bcd2_reg <= 0;
			bcd1_reg <= 0;
			bcd0_reg <= 0;
		end
		else
		begin
			state_reg <= state_next;
			p2s_reg <= p2s_next;
			n_reg <= n_next;
			bcd6_reg <= bcd6_next;
			bcd5_reg <= bcd5_next;
			bcd4_reg <= bcd4_next;
			bcd3_reg <= bcd3_next;
			bcd2_reg <= bcd2_next;
			bcd1_reg <= bcd1_next;
			bcd0_reg <= bcd0_next;
		end


	always_comb
	begin
		state_next = state_reg;
		ready = 1'b0;
		done_tick = 1'b0;
		bcd6_next = bcd6_reg;
		bcd5_next = bcd5_reg;
		bcd4_next = bcd4_reg;
		bcd3_next = bcd3_reg;
		bcd2_next = bcd2_reg;
		bcd1_next = bcd1_reg;
		bcd0_next = bcd0_reg;
		p2s_next = p2s_reg;
		n_next = n_reg;
		case(state_reg)
			idle: begin
				ready = 1'b1;
				if(start)
				begin
					state_next = op;
					bcd6_next = 0;
					bcd5_next = 0;
					bcd4_next = 0;
					bcd3_next = 0;
					bcd2_next = 0;
					bcd1_next = 0;
					bcd0_next = 0;
					n_next = 5'd23;
					p2s_next = bin;
				end
			end
			op: begin
				p2s_next = p2s_reg << 1;

				bcd0_next = {bcd0_temp[2:0], p2s_reg[22]};
				bcd1_next = {bcd1_temp[2:0], bcd0_temp[3]};
				bcd2_next = {bcd2_temp[2:0], bcd1_temp[3]};
				bcd3_next = {bcd3_temp[2:0], bcd2_temp[3]};
				bcd4_next = {bcd4_temp[2:0], bcd3_temp[3]};
				bcd5_next = {bcd5_temp[2:0], bcd4_temp[3]};
				bcd6_next = {bcd6_temp[2:0], bcd5_temp[3]};
				n_next = n_reg - 1;
				if (n_next == 0)
					state_next = done;
			end
			done: begin
				done_tick = 1'b1;
				state_next = idle;
			end
			default: state_next = idle;
		endcase
	end
	
	assign bcd6_temp = (bcd6_reg > 4) ? bcd6_reg + 3 : bcd6_reg;
	assign bcd5_temp = (bcd5_reg > 4) ? bcd5_reg + 3 : bcd5_reg;
	assign bcd4_temp = (bcd4_reg > 4) ? bcd4_reg + 3 : bcd4_reg;
	assign bcd3_temp = (bcd3_reg > 4) ? bcd3_reg + 3 : bcd3_reg;
	assign bcd2_temp = (bcd2_reg > 4) ? bcd2_reg + 3 : bcd2_reg;
	assign bcd1_temp = (bcd1_reg > 4) ? bcd1_reg + 3 : bcd1_reg;
	assign bcd0_temp = (bcd0_reg > 4) ? bcd0_reg + 3 : bcd0_reg;

	assign bcd6 = bcd6_reg;
	assign bcd5 = bcd5_reg;
	assign bcd4 = bcd4_reg;
	assign bcd3 = bcd3_reg;
	assign bcd2 = bcd2_reg;
	assign bcd1 = bcd1_reg;
	assign bcd0 = bcd0_reg;

endmodule
