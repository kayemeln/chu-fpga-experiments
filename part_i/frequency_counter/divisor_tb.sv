`timescale 1ns / 10ps
module divisor_tb();

	logic clk, reset, start;
	logic [23:0] dvdr;
	logic done_tick, ready;
	logic [29:0] q;

	divisor uut(.*);

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
		dvdr = 24'd925_000;
		#50;
		start = 1'b1;
		#10
		start = 1'b0;
		wait (done_tick == 1'b1);
		#100 $finish;
	end

endmodule
