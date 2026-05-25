module disp_mux_test
(
	input logic clk,
	input logic [15:0] sw,
	input logic btnU, btnL, btnC, btnR,
	output logic [7:0] seg,
	output logic [3:0] an
);
	logic [7:0] reg3, reg2, reg1, reg0;
	// Instantiate our display multiplexer
	disp_mux unit(.clk(clk), .reset(sw[15]), .in3(reg3), .in2(reg2), .in1(reg1), .in0(reg0), .sseg(seg), .an(an));

	always_ff @(posedge clk)
	begin
		if(btnU)
			reg3 <= sw[7:0];
		if(btnL)
			reg2 <= sw[7:0];
		if(btnC)
			reg1 <= sw[7:0];
		if(btnR)
			reg0 <= sw[7:0];
	end


endmodule
