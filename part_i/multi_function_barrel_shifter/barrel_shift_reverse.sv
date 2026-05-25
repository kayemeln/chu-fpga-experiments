module b_shft_r
(
	input logic [7:0] x,
	input logic [2:0] amnt,
	input logic lr,
	output logic [7:0] y
);

	logic [7:0] pre_reverse;
	logic [7:0] post_reverse;
	logic [7:0] rot_r;

	// Pre-reverse
	generate
	for (genvar i = 0; i < 8; i = i + 1)
	begin
		assign pre_reverse[i] = x[8 - 1 - i];
	end
	endgenerate

	// Barrel shift right
	always_comb
	begin: shift_right
		if (lr)
		begin
			case(amnt)
				3'd0: rot_r = pre_reverse;
				3'd1: rot_r = {pre_reverse[0], pre_reverse[7:1]};
				3'd2: rot_r = {pre_reverse[1:0], pre_reverse[7:2]};
				3'd3: rot_r = {pre_reverse[2:0], pre_reverse[7:3]};
				3'd4: rot_r = {pre_reverse[3:0], pre_reverse[7:4]};
				3'd5: rot_r = {pre_reverse[4:0], pre_reverse[7:5]};
				3'd6: rot_r = {pre_reverse[5:0], pre_reverse[7:6]};
				default: rot_r = {pre_reverse[6:0], pre_reverse[7]};
			endcase
		end
		else
		begin
			case(amnt)
				3'd0: rot_r = x;
				3'd1: rot_r = {x[0], x[7:1]};
				3'd2: rot_r = {x[1:0], x[7:2]};
				3'd3: rot_r = {x[2:0], x[7:3]};
				3'd4: rot_r = {x[3:0], x[7:4]};
				3'd5: rot_r = {x[4:0], x[7:5]};
				3'd6: rot_r = {x[5:0], x[7:6]};
				default: rot_r = {x[6:0], x[7]};
			endcase
		end
	end

	generate
	for (genvar i = 0; i < 8; i = i + 1)
	begin
		assign post_reverse[i] = rot_r[8 - 1 - i];
	end
	endgenerate

	// multiplexer
	always_comb
	begin
		if(lr)
			y = post_reverse;
		else
			y = rot_r;
	end

endmodule
