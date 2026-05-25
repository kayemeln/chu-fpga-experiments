module stop_watch_cascade
(
	input logic clk,
	input logic clr, go,
	output logic [3:0] d2, d1, d0
);

	localparam DVDR = 10000000;
	// Internal signal declaration
	// 100ms tick wires/reg
	logic [23:0] ms100_reg, ms100_next;
	// BCD values
	logic [3:0] d2_reg, d1_reg, d0_reg;
	logic [3:0] d2_next, d1_next, d0_next;
	// Tick and enable signals
	logic ms100_tick, d2_tick, d1_tick, d0_tick;
	logic d2_en, d1_en, d0_en;

	always_ff @(posedge clk)
	begin
		ms100_reg <= ms100_next;
		d2_reg <= d2_next;
		d1_reg <= d1_next;
		d0_reg <= d0_next;
	end

	assign ms100_next = (clr || ms100_reg == DVDR) ? 24'b0 :
		(go) ? ms100_reg + 1 :
				ms100_reg;
	assign ms100_tick = (ms100_reg == DVDR) ? 1'b1 : 1'b0;
	assign d0_en = ms100_tick;

	assign d0_next = (clr || d0_en && d0_reg == 4'd9) ? 4'b0 :
		(d0_en) ? d0_reg + 1 :
				d0_reg;
	assign d0_tick = (d0_reg == 4'd9) ? 1'b1 : 1'b0;
	assign d1_en = ms100_tick & d0_tick;

	assign d1_next = (clr || d1_en && d1_reg == 4'd9) ? 4'b0 :
		(d1_en) ? d1_reg + 1 :
				d1_reg;
	assign d1_tick = (d1_reg == 4'd9) ? 1'b1 : 1'b0;
	assign d2_en = ms100_tick & d1_tick & d0_tick;

	assign d2_next = (clr || d2_en && d2_reg == 4'd9) ? 4'b0 :
		(d2_en) ? d2_reg + 1 :
				d2_reg;
	
	assign d2 = d2_reg;
	assign d1 = d1_reg;
	assign d0 = d0_reg;

endmodule
