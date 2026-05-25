`timescale 1 ns/10 ps

module gr_th_tb;
	// signal declarations
	logic [1:0] test_in0, test_in1;
	logic test_out;

	gr_th uut(.a(test_in1), .b(test_in0), .gr(test_out));

	initial
	begin
		test_in0 = 2'b00;
		test_in1 = 2'b00;
		# 200;
		test_in0 = 2'b01;
		test_in1 = 2'b00;
		# 200;
		test_in0 = 2'b10;
		test_in1 = 2'b00;
		# 200;
		test_in0 = 2'b11;
		test_in1 = 2'b00;
		# 200;
		test_in0 = 2'b00;
		test_in1 = 2'b01;
		# 200;
		test_in0 = 2'b01;
		test_in1 = 2'b01;
		# 200;
		test_in0 = 2'b10;
		test_in1 = 2'b01;
		# 200;
		test_in0 = 2'b11;
		test_in1 = 2'b01;
		# 200;
		test_in0 = 2'b00;
		test_in1 = 2'b10;
		# 200;
		test_in0 = 2'b01;
		test_in1 = 2'b10;
		# 200;
		test_in0 = 2'b10;
		test_in1 = 2'b10;
		# 200;
		test_in0 = 2'b11;
		test_in1 = 2'b10;
		# 200;
		test_in0 = 2'b00;
		test_in1 = 2'b11;
		# 200;
		test_in0 = 2'b01;
		test_in1 = 2'b11;
		# 200;
		test_in0 = 2'b10;
		test_in1 = 2'b11;
		# 200;
		test_in0 = 2'b11;
		test_in1 = 2'b11;
		# 200;
		// stop simulation
		$stop;
	end
endmodule
