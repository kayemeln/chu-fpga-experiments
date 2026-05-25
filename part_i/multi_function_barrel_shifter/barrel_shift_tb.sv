`timescale 1ns / 10ps

module b_shft_tb;

	// Test vectors
	logic [7:0] test_input;
	logic lr;
	logic [2:0] amnt;
	logic [7:0] result;

	b_shft uut(.x(test_input), .amnt(amnt), .lr(lr), .y(result));

	initial begin
		test_input = 8'b10001000;
		lr = 1'b1;
		amnt = 3'd0;
		#20;
		amnt = 3'd1;
		#20;
		amnt = 3'd2;
		#20;
		amnt = 3'd4;
		#20;
		lr = 1'b0;
		amnt = 3'd4;
		#20;
		amnt = 3'd2;
		#20;
		amnt = 3'd1;
		#20;
		amnt = 3'd7;
		#20;
		$finish;
	end

endmodule
