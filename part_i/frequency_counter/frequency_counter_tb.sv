`timescale 1ns / 10ps
module frequency_counter_tb();

	logic clk, reset;
	logic start;
	logic si;
	logic done_tick;
	logic [3:0] ann;
	logic [3:0] bcd3, bcd2, bcd1, bcd0;

	frequency_counter uut(.*);

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
			#475285170 si = ~si;
		//$display("done_tick observed, freq = %0d%0d%0d%0d", bcd3, bcd2, bcd1, bcd0);
		#100
		$finish;
	end

	initial begin
		start = 1'b0;
		si = 1'b0;
		#50;
		start = 1'b1;
	end

endmodule
