module frequency_counter
(
	input logic clk, reset,
	input logic start,
	input logic si,
	output logic done_tick,
	output logic [3:0] ann,
	output logic [3:0] bcd3, bcd2, bcd1, bcd0
);
	localparam CLK_S_TIME = 100_000_000;

	typedef enum {idle, sprd, div, bcd, adj, hold} state_type;

	// This will contain the master FSM
	state_type state_reg, state_next;
	logic prd_start, div_start, bcd_start, adj_start;
	logic prd_done, div_done, bcd_done, adj_done;
	logic [23:0] prd;
	logic [29:0] quo;
	logic [22:0] quo_trunc;
	logic [3:0] bcd6_temp, bcd5_temp, bcd4_temp, bcd3_temp, bcd2_temp, bcd1_temp, bcd0_temp;
	logic [26:0] t_reg, t_next;
	 
	period_counter prd_count(.clk(clk), .reset(reset), .start(prd_start), .si(si), .ready(), .done_tick(prd_done), .prd(prd));
	divisor div_unit(.clk(clk), .reset(reset), .start(div_start), .dvdr(prd), .done_tick(div_done), .ready(), .q(quo));
	bin_to_bcd bcd_unit(.clk(clk), .reset(reset), .start(bcd_start), .bin(quo_trunc), .ready(), .done_tick(bcd_done), .bcd6(bcd6_temp), .bcd5(bcd5_temp), .bcd4(bcd4_temp), .bcd3(bcd3_temp), .bcd2(bcd2_temp), .bcd1(bcd1_temp), .bcd0(bcd0_temp));
	bcd_adjust adjust_unit(.clk(clk), .reset(reset), .start(adj_start), .bcd6(bcd6_temp), .bcd5(bcd5_temp), .bcd4(bcd4_temp), .bcd3(bcd3_temp), .bcd2(bcd2_temp), .bcd1(bcd1_temp), .bcd0(bcd0_temp), .done_tick(adj_done), .ready(), .bcd3_new(bcd3), .bcd2_new(bcd2), .bcd1_new(bcd1), .bcd0_new(bcd0), .point_pos(ann));
	
	assign quo_trunc = quo[22:0];

	always_ff @(posedge clk, posedge reset)
		if (reset) begin
			state_reg <= idle;
			t_reg <= 0;
		end
		else begin
			state_reg <= state_next;
			t_reg <= t_next;
		end

	always_comb
	begin
		state_next = state_reg;
		done_tick = 1'b0;
		prd_start = 1'b0;
		div_start = 1'b0;
		bcd_start = 1'b0;
		adj_start = 1'b0;
		case(state_reg)
			idle: begin
				if (start) begin
					prd_start = 1'b1;
					state_next = sprd;
				end
			end
			sprd: begin
				if (prd_done) begin
					div_start = 1'b1;
					state_next = div;
				end
			end
			div: begin
				if (div_done) begin
					bcd_start = 1'b1;
					state_next = bcd;
				end
			end
			bcd: begin
				if (bcd_done) begin
					adj_start = 1'b1;
					state_next = adj;
				end
			end
			adj: begin
				if (adj_done) begin
					done_tick = 1'b1;
					state_next = hold;
					t_next = 0;
				end
			end
			hold: begin
				t_next = t_reg + 1;
				if (t_next >= CLK_S_TIME)
					state_next = idle;
			end
			default: state_next = idle;
		endcase
	end


endmodule
