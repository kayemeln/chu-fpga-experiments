module bin_to_bcd_tb();

	logic clk, reset, start;
	logic [7:0] bin;
	logic ready, done_tick;
	logic [3:0] bcd3, bcd2, bcd1, bcd0;

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
		bin = 8'b0;
		#50;
		for (logic [7:0] i = 8'b0; i < 8'b11111111; i = i + 1) begin
			bin = i;
			start = 1'b1;
			#10;
			start = 1'b0;
			wait (done_tick == 1'b1);
			#20;
		end
		$finish;
	end

endmodule
