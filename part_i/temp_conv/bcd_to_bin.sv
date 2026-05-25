module bcd_to_bin
(
	input logic clk, reset,
	input logic [11:0] bcd,		// 3 BCD digit input
	input logic start,
	output logic ready, done_tick,
	output logic [8:0] bin
);


	typedef enum {idle, op, done} state_type;

	state_type state_reg, state_next;
	logic [3:0] bcd2_reg,  bcd1_reg, bcd0_reg;
	logic [3:0] bcd2_next, bcd1_next, bcd0_next;
	logic [3:0] bcd2_temp, bcd1_temp, bcd0_temp;
	logic [8:0] bin_reg, bin_next;
	logic [3:0] n_reg, n_next;

	always_ff @(posedge clk, posedge reset)
		if (reset)
		begin
			state_reg <= idle;
			bcd2_reg <= 0;
			bcd1_reg <= 0;
			bcd0_reg <= 0;
			bin_reg <= 0;
			n_reg <= 0;
		end
		else
		begin
			state_reg <= state_next;
			bcd2_reg <= bcd2_next;
			bcd1_reg <= bcd1_next;
			bcd0_reg <= bcd0_next;
			bin_reg <= bin_next;
			n_reg <= n_next;
		end

	always_comb
	begin
		// defaults...
		state_next = state_reg;
		bcd2_next = bcd2_reg;
		bcd1_next = bcd1_reg;
		bcd0_next = bcd0_reg;
		bin_next = bin_reg;
		n_next = n_reg;
		ready = 1'b0;
		done_tick = 1'b0;

		case (state_reg)
			idle: begin
				ready = 1'b1;
				if (start)
				begin
					state_next = op;
					bcd2_next = {1'b0, bcd[11:9]};
					bcd1_next = {bcd[8], bcd[7:5]};
					bcd0_next = {bcd[4], bcd[3:1]};
					bin_next = {bcd[0], 8'b0};
					n_next = 4'd9;
				end
			end
			op: begin
				bcd2_next = {{1'b0}, bcd2_temp[3:1]};
				bcd1_next = {bcd2_temp[0], bcd1_temp[3:1]};
				bcd0_next = {bcd1_temp[0], bcd0_temp[3:1]};

				bin_next = {bcd0_temp[0], bin_reg[8:1]};
				n_next = n_reg - 1;
				if (n_next == 1)
					state_next = done;
			end
			done: begin
				done_tick = 1'b1;
				state_next = idle;
			end
			default: state_next = idle;
		endcase
	end

	assign bcd2_temp = (bcd2_reg > 7) ? bcd2_reg - 3 : bcd2_reg;
	assign bcd1_temp = (bcd1_reg > 7) ? bcd1_reg - 3 : bcd1_reg;
	assign bcd0_temp = (bcd0_reg > 7) ? bcd0_reg - 3 : bcd0_reg;

	assign bin = bin_reg;

endmodule
