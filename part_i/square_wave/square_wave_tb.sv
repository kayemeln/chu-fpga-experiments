`timescale 1ns/ 10ps
module square_wave_tb();

	logic clk, reset;
	logic [3:0] m, n;
	logic wave;

	square_wave uut(.clk(clk), .reset(reset), .m(m), .n(n), .wave(wave));

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
		#10
		reset = 1'b0;
	end

	initial
	begin
		m = 4'd1;
		n = 4'd1;
		#10000;
		m = 4'd2;
		n = 4'd2;
		#10000;
		m = 4'd1;
		n = 4'd2;
		#10000;
		m = 4'd8;
		n = 4'd2;
		#10000;
		$finish;
	end

endmodule
