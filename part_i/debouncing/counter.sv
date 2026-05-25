module counter
(
	input logic clk, reset,
	input logic en,
	output [7:0] count
);
	logic [7:0] count_reg, count_next;

	always_ff @(posedge clk, posedge reset)
		if (reset)
			count_reg <= 8'b0;
		else
			count_reg <= count_next;

	assign count_next = (en) ? count_reg + 1 : count_reg;
	
	assign count = count_reg;

endmodule
