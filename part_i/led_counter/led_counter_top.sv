module led_counter_top
(
	input logic clk, sw[0:0],
	output logic [15:0] led
);

	led_counter unit(.clk(clk), .reset(sw[0]), .y(led));

endmodule
