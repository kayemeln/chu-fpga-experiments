module bcd_adjust
(
	input logic clk, reset,
	input logic start,
	input logic [3:0] bcd6, bcd5, bcd4, bcd3, bcd2, bcd1, bcd0,
	output logic done_tick, ready,
	output logic [3:0] bcd3_new, bcd2_new, bcd1_new, bcd0_new,
	output logic [3:0] point_pos
);

	typedef enum {idle, op, done} state_type;
	
	state_type state_reg, state_next;
	logic [3:0] bcd6_reg, bcd5_reg, bcd4_reg, bcd3_reg, bcd2_reg, bcd1_reg, bcd0_reg;
	logic [3:0] bcd6_next, bcd5_next, bcd4_next, bcd3_next, bcd2_next, bcd1_next, bcd0_next;
	logic [1:0] n_reg, n_next;

	always_ff @(posedge clk, posedge reset)
		if (reset)
		begin
			state_reg <= idle;
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
		n_next = n_reg;
		case (state_reg)
			idle: begin
				ready = 1'b1;
				if (start) begin
				    state_next = op;   
					bcd6_next = bcd6;
					bcd5_next = bcd5;
					bcd4_next = bcd4;
					bcd3_next = bcd3;
					bcd2_next = bcd2;
					bcd1_next = bcd1;
					bcd0_next = bcd0;
					n_next = 2'b11;
				end
			end
			op: begin
				if (bcd6_reg != 0 || n_reg == 0) begin
					state_next = done;
				end
				else begin
					n_next = n_reg - 1;
					bcd6_next = bcd5_reg;
					bcd5_next = bcd4_reg;
					bcd4_next = bcd3_reg;
					bcd3_next = bcd2_reg;
					bcd2_next = bcd1_reg;
					bcd1_next = bcd0_reg;
					bcd0_next = 4'b0000;
				end
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
		case (n_reg)
			2'b11: point_pos = 4'b1110;
			2'b10: point_pos = 4'b1101;
			2'b01: point_pos = 4'b1011;
			2'b00: point_pos = 4'b0111;
		endcase
	end

	assign bcd3_new = bcd6_reg;
	assign bcd2_new = bcd5_reg;
	assign bcd1_new = bcd4_reg;
	assign bcd0_new = bcd3_reg;

endmodule
