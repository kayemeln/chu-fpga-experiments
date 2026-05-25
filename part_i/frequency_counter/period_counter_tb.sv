`timescale 1ns / 10ps

module period_counter_tb();

	logic clk, reset, start, si;
	logic ready, done_tick;
	logic [9:0] prd;

	period_counter uut(.*);

	initial begin
		clk = 1'b0;
		forever begin
			#5 clk = ~clk;
		end
	end

	initial begin
		reset = 1'b1;
		#10;
		reset = 1'b0;
	end

	logic done_latched;

	always_ff @(posedge clk, posedge reset)
		if(reset) done_latched <= 1'b0;
		else if(done_tick) done_latched <= 1'b1;

	initial begin
		si = 1'b0;
		@(negedge reset);
		while (~done_latched)
			#25010 si = ~si;
		$display("done_tick observed, prd = %0d", prd);
		#1000 $finish;
	end

	initial begin
		start = 1'b0;
		si = 1'b0;
		#50;
		start = 1'b1;
	end

endmodule
