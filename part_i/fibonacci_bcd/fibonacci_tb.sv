`timescale 1ns / 10ps

module fibonacci_tb();
	logic clk, reset, start;
	logic [6:0] i;
	logic ready, done_tick, overflow;
	logic [19:0] f;

	fibonacci uut(.*);

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
		i = 7'b0;
		#50;
		for (logic [7:0] j = 8'b0; j < 8'b10000000; j = j + 1) begin
			i = j;
			start = 1'b1;
			#10;
			start = 1'b0;
			wait (done_tick == 1'b1);
			#20;
		end
		$finish;
	end

endmodule
