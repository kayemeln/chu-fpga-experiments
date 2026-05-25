module temp_conv_tb();

	
	logic clk;
	logic format;
	logic [7:0] temp;
	logic [7:0] temp_conv;

	temp_conv uut(.*);
	
	initial begin
		clk = 1'b0;
		forever begin
			#5 clk = ~clk;
		end
	end

	initial begin
		format = 1'b1;
		temp = 8'b0;
		#50;
		for (int c = 0; c < 101; c = c + 1) begin
			temp = c;
			#20;
		end
		#50;
		for (int c = 101; c < 120; c = c + 1) begin
			temp = c;
			#20;
		end

		format = 1'b0;
		#100;
		// Farrenheit to Celsius
		for (int f = 32; f < 213; f = f + 1) begin
			temp = f;
			#20;
		end
		#50;
		for (int f = 213; f < 233; f = f + 1) begin
			temp = f;
			#20;
		end
		
		#100 $finish;
	end

endmodule
