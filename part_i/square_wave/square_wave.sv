module square_wave
(
	input logic clk, reset,
	input logic [3:0] m, n,
	output logic wave
);

	localparam DVDR = 10;
	// Internal signal declaration
	logic [3:0] dvdr_reg, dvdr_next;
	logic dvdr_tick;
	logic [3:0] on_count_reg, on_count_next;
	logic [3:0] off_count_reg, off_count_next;
	logic on_reg, on_next;
	logic on_tick, off_tick;

	always_ff @(posedge clk, posedge reset)
	begin
		if (reset)
		begin
			dvdr_reg <= 0;
			on_count_reg <= 0;
			off_count_reg <= 0;
			on_reg <= 1'b0;
		end
		else
		begin
			dvdr_reg <= dvdr_next;
			on_count_reg <= on_count_next;
			off_count_reg <= off_count_next;
			on_reg <= on_next;
		end
	end

	// Next-state logic
	assign dvdr_next = (dvdr_reg == DVDR) ? 4'b0 : dvdr_reg + 1;
	assign dvdr_tick = (dvdr_reg == DVDR) ? 1'b1 : 1'b0;

	assign on_count_next = (dvdr_tick && (on_count_reg >= m || !on_reg)) ? 4'b0 :
					(dvdr_tick && on_reg) ? on_count_reg + 1 : on_count_reg;
	assign off_count_next = (dvdr_tick && off_count_reg >= n || on_reg) ? 4'b0 :
					(dvdr_tick && !on_reg) ? off_count_reg + 1 : off_count_reg;

	assign on_tick = (on_count_reg >= m) ? 1'b1 : 1'b0;
	assign off_tick = (off_count_reg >= n) ? 1'b1 : 1'b0;

	always_comb
	begin
		if(on_tick)
			on_next = 1'b0;
		else if(off_tick)
			on_next = 1'b1;
		else
			on_next = on_reg;
	end

	assign wave = (on_reg) ? 1'b1 : 1'b0;


endmodule
