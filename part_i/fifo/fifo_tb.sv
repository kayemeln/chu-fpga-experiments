`timescale 1ns / 10ps

module fifo_tb();

	localparam D = 8;
	localparam A = 3;

	logic clk, reset;
	logic rd, wr;
	logic [2*D-1:0] w_data;
	logic empty, full;
	logic [D-1:0] r_data;

	fifo #(.ADDR_WIDTH(A), .DATA_WIDTH(D)) uut(.*);

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
		rd = 1'b0;
		wr = 1'b0;
		w_data = 16'b0;
		#20;
		while (full == 1'b0) begin
			wr = 1'b0;
			w_data = $urandom_range(0, 65535);
			#10;
			wr = 1'b1;
			#10;
		end
		wr = 1'b0;

		rd = 1'b1;
		wait (empty == 1'b1);
		rd = 1'b0;
			
		for (int i = 0; i < 2; i = i + 1) begin
			wr = 1'b0;
			w_data = $urandom_range(0, 65535);
			#10;
			wr = 1'b1;
			#10;
		end
		
		wr = 1'b0;

		while (full == 1'b0) begin
			w_data = $urandom_range(0, 65535);
			#10;
			wr = 1'b1;
			rd = 1'b1;
			#10;
			wr = 1'b0;
			rd = 1'b0;
		end

		rd = 1'b1;
		wait (empty == 1'b1);
		rd = 1'b0;

		#100 $finish;
	end

endmodule
