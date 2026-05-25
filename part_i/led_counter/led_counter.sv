module led_counter
(
	input logic clk, reset,
	output logic [15:0] y
);
	// Internal signal declaration
	logic [15:0] r_reg, r_next;	
	logic [13:0] en_counter;
	logic en;

	// Body
	always_ff @(posedge clk, posedge reset)
	begin
		if (reset)
			en_counter <= 14'd0;
		else
			en_counter <= en_counter + 1;
	end

	always_ff @(posedge clk, posedge reset)
	begin
		if (reset)
			r_reg <= 16'd0;
		else if(en)
			r_reg <= r_next;
	end
	
	// Next-state logic
	assign r_next = r_reg + 1;

	assign en = (en_counter == 14'b11111111111111) ? 1'b1 : 1'b0;
	assign y = r_reg;
	
endmodule
