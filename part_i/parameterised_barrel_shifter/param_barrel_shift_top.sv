module param_b_shft_top
(
	input [15:0] sw,
	input btnU, btnL, btnC, btnR,
	output [15:0] LED
);
	//logic [3:0] btn_wire;
    logic [2:0] btn_wire;

	//assign btn_wire = {btnU, btnL, btnC, btnR};
	assign btn_wire = {btnL, btnC, btnR};
	// Instantiate module
	//param_b_shft #(.N(4)) unit(.x(sw[15:0]), .amnt(btn_wire), .y(LED));
	param_b_shft #(.N(3)) unit(.x(sw[7:0]), .amnt(btn_wire), .y(LED));

endmodule
