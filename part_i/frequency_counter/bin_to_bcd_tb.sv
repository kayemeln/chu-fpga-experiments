module bin_to_bcd_tb();

	logic clk, reset, start;
	logic [22:0] bin;
	logic ready, done_tick;
	logic [3:0] bcd6, bcd5, bcd4, bcd3, bcd2, bcd1, bcd0;

	bin_to_bcd uut(.*);

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

	initial begin
		start = 1'b0;
		bin = 23'b0;
		#50;
		bin = 23'd1081;
		start = 1'b1;
		#10;
		start = 1'b0;
		wait (done_tick == 1'b1);
		#20;
		$finish;
	end

endmodule
