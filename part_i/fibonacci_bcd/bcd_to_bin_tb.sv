`timescale 1ns / 10ps

module bcd_to_bin_tb();
	logic clk, reset;
	logic [7:0] bcd;
	logic [3:0] bcd1, bcd0;
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
		bcd = 8'b0000_0000;
		#50;
		for (int i = 0; i < 10; i = i + 1) begin
			for (int j = 0; j < 10; j = j + 1) begin
				bcd1 = i;
				bcd0 = j;
				start = 1'b1;
				@(negedge clk);
				start = 1'b0;
				wait(done_tick == 1'b1);
				#20;
			end
		end
		$finish;

	end

	assign bcd = {bcd1, bcd0};

endmodule
