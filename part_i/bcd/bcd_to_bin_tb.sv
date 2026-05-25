`timescale 1ns / 10ps

module bcd_to_bin_tb();
	logic clk, reset;
	logic [7:0] bcd;
	logic start;
	logic ready, done_tick;
	logic [6:0] bin;

	bcd_to_bin uut(.*);

	always
	begin
		clk = 1'b1;
		#5;
		clk = 1'b0;
		#5;
	end

	initial
	begin
		reset = 1'b1;
		#10;
		reset = 1'b0;
	end

	initial begin
		start = 1'b0;
		bcd = 8'b0001_0111; //17
		#50;
		start = 1'b1;
		@(negedge clk);
		start = 1'b0;
		wait(done_tick == 1'b1);
		bcd = 8'b1001_0011; //93
		#50;
		start = 1'b1;
		@(negedge clk);
		start = 1'b0;
		wait(done_tick == 1'b1);
		bcd = 8'b0110_0011; //63
		#50;
		start = 1'b1;
		@(negedge clk);
		start = 1'b0;
		wait(done_tick == 1'b1);
		bcd = 8'b0111_1001; //79
		#50;
		start = 1'b1;
		@(negedge clk);
		start = 1'b0;
		wait(done_tick == 1'b1);
		#50;
		$finish;

	end

endmodule
