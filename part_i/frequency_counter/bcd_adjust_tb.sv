`timescale 1ns / 10ps
module bcd_adjust_tb();

	logic clk, reset, start;
	logic done_tick, ready;
	logic [3:0] bcd6, bcd5, bcd4, bcd3, bcd2, bcd1, bcd0;
	logic [3:0] bcd3_new, bcd2_new, bcd1_new, bcd0_new;
	logic [3:0] point_pos;

	bcd_adjust uut(.*);

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
		// 1.081
		bcd6 = 4'd0;
		bcd5 = 4'd0;
		bcd4 = 4'd0;
		bcd3 = 4'd1;
		bcd2 = 4'd0;
		bcd1 = 4'd8;
		bcd0 = 4'd1;
		#50;
		start = 1'b1;
		#10;
		start = 1'b0;
		wait (done_tick == 1'b1);
		#100;
		// 928.2
		bcd6 = 4'd0;
		bcd5 = 4'd9;
		bcd4 = 4'd2;
		bcd3 = 4'd8;
		bcd2 = 4'd1;
		bcd1 = 4'd0;
		bcd0 = 4'd0;
		#50;
		start = 1'b1;
		#10;
		start = 1'b0;
		wait (done_tick == 1'b1);
		// 8754
		bcd6 = 4'd8;
		bcd5 = 4'd7;
		bcd4 = 4'd5;
		bcd3 = 4'd4;
		bcd2 = 4'd1;
		bcd1 = 4'd0;
		bcd0 = 4'd0;
		#50;
		start = 1'b1;
		#10;
		start = 1'b0;
		wait (done_tick == 1'b1);
		// 0.652
		bcd6 = 4'd0;
		bcd5 = 4'd0;
		bcd4 = 4'd0;
		bcd3 = 4'd0;
		bcd2 = 4'd6;
		bcd1 = 4'd5;
		bcd0 = 4'd2;
		#50;
		start = 1'b1;
		#10;
		start = 1'b0;
		wait (done_tick == 1'b1);
		#100 $finish;


	end

endmodule
