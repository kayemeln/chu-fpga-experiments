`timescale 1ns/ 10ps

module debounce_test_top_tb();

	logic clk, sw, btnC;
	logic [7:0] seg;
	logic [3:0] an;

	debounce_test_top uut(.*);

	always
	begin
		clk = 1'b0;
		#5;
		clk = 1'b1;
		#5;
	end

	initial
	begin
		sw = 1'b1;
		#10;
		sw = 1'b0;
	end

	initial
	begin
		btnC = 1'b0;
		#20;
		btnC = 1'b1;
		#2;
		btnC = 1'b0;
		#2;
		btnC = 1'b1;
		#3;
		btnC = 1'b1;
		#2;
		btnC = 1'b0;
		#2;
		btnC = 1'b1;
		#15;
		btnC = 1'b0;
		#2;
		btnC = 1'b1;
		#40;
		btnC = 1'b0;
		#50;
		btnC = 1'b1;
		#1000;
		btnC = 1'b0;
		#20
		$finish;
	end

endmodule


