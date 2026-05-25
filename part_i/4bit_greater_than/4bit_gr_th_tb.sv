`timescale 1 ns/10 ps

module gr_th_4bit_tb;

	logic [3:0] test_in0, test_in1;
	logic gr;

	gr_th_4bit uut(.a(test_in1), .b(test_in0), .gr(gr));

	initial
	begin
		for (int i = 0; i < 16; i++) begin
			for (int j = 0; j < 16; j++) begin
				test_in0 = i;
				test_in1 = j;
				# 10;
			end
		end
		$display("Simulation complete");
		$finish;
	end
	

endmodule
