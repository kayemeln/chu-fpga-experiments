module fibonacci_bcd
(
	input logic clk, reset,
	input logic start,
	input logic [7:0] bcd,
	output logic [7:0] sseg,
	output logic [3:0] aan	
);

	typedef enum {idle, s_bcd, fib, bin} state_type;

	state_type state_reg, state_next;
	logic bcd_start, fib_start, bin_start;
	logic bcd_done, fib_done, bin_done;
	logic [6:0] i;
	logic of;
	logic [19:0] f;
	logic [19:0] f_trim;
	logic [3:0] bcd3, bcd2, bcd1, bcd0;

	bcd_to_bin bcd_unit(.clk(clk), .reset(reset), .bcd(bcd), .start(bcd_start), .ready(), .done_tick(bcd_done), .bin(i));
	fibonacci fib_unit(.clk(clk), .reset(reset), .start(fib_start), .i(i), .ready(), .done_tick(fib_done), .overflow(of), .f(f));
	bin_to_bcd bin_unit(.clk(clk), .reset(reset), .start(bin_start), .bin(f_trim), .done_tick(bin_done), .ready(), .bcd3(bcd3), .bcd2(bcd2), .bcd1(bcd1), .bcd0(bcd0));
	assign f_trim = (of) ? 20'd9999 : f;
	disp_hex_mux disp(.clk(clk), .reset(reset), .hex0(bcd3), .hex1(bcd2), .hex2(bcd1), .hex3(bcd0), .dp_in(4'b1111), .sseg(sseg), .an(aan));

	always_ff @(posedge clk, posedge reset)
		if (reset)
			state_reg <= idle;
		else 
			state_reg <= state_next;

	always_comb
	begin
		state_next = state_reg;
		bcd_start = 1'b0;
		fib_start = 1'b0;
		bin_start = 1'b0;

		case (state_reg)
			idle: begin
				if (start) begin
					bcd_start = 1'b1;
					state_next = s_bcd;
				end
			end
			s_bcd: begin
				if (bcd_done) begin
					fib_start = 1'b1;
					state_next = fib;
				end
			end
			fib: begin
				if (fib_done) begin
					bin_start = 1'b1;
					state_next = bin;
				end
			end
			bin: begin
				if (bin_done)
					state_next = idle;
			end
			default: state_next = idle;
		endcase
	end


endmodule
