module b_shft
(
	input logic [7:0] x,
	input logic [2:0] amnt,
	input logic lr,
	output logic [7:0] y
);

	// Internal signal declaration
	logic [7:0] rot_l, rot_r;

	// Rotate left
	always_comb
	begin: rotate_left
		case(amnt)
			3'd0: rot_l = x;
			3'd1: rot_l = {x[6:0], x[7]};
			3'd2: rot_l = {x[5:0], x[7:6]};
			3'd3: rot_l = {x[4:0], x[7:5]};
			3'd4: rot_l = {x[3:0], x[7:4]};
			3'd5: rot_l = {x[2:0], x[7:3]};
			3'd6: rot_l = {x[1:0], x[7:2]};
			default: rot_l = {x[0], x[7:1]}; // i.e. amnt = 7
		endcase
	end
	
	// Rotate right
	always_comb
	begin: rotate_right
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

	// 2-to-1 multiplexer
	always_comb
	begin: left_right
		if(lr)
			y = rot_l;
		else
			y = rot_r;
	end

endmodule
