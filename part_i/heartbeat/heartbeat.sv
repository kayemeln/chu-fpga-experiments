module heartbeat
(
	input logic clk, reset,
	output [7:0] sseg,
	output [3:0] an
);
	localparam DVDR = 20_800_000;
	// Internal signal declaration
	logic [24:0] dvdr_reg, dvdr_next;
	logic dvdr_tick;
	logic [1:0] pos_reg, pos_next;
	logic [7:0] sseg_reg, sseg_next;
	logic [3:0] an_reg, an_next;
	logic [7:0] in3, in2, in1, in0;

	disp_mux unit(.clk(clk), .reset(reset), .in3(in3), .in2(in2), .in1(in1), .in0(in0), .an(an_next), .sseg(sseg_next));

	always_ff @(posedge clk)
	begin
		if (reset)
		begin
			dvdr_reg <= 0;
			pos_reg <= 2'b00;
			sseg_reg <= 8'b11111111;
			an_reg <= 4'b1111;
		end
		else
		begin
			dvdr_reg <= dvdr_next;
			pos_reg <= pos_next;
			sseg_reg <= sseg_next;
			an_reg <= an_next;
		end
	end

	// Next-state logic
	assign dvdr_next = (reset || dvdr_reg == DVDR) ? 25'b0 : dvdr_reg + 1;
	assign dvdr_tick = (dvdr_reg == DVDR) ? 1'b1 : 1'b0;

	assign pos_next = (reset) ? 2'b0 : (dvdr_tick) ? pos_reg + 1 : pos_reg;

	always_comb
	begin
		case (pos_reg)
			2'b00:
			begin
				in0 = 8'b11111111;
				in1 = 8'b11111111;
				in2 = 8'b11111111;
				in3 = 8'b11111111;
			end
			2'b01:
			begin
				in0 = 8'b11111111;
				in1 = 8'b11001111;
				in2 = 8'b11111001;
				in3 = 8'b11111111;
			end
			2'b10:
			begin
				in0 = 8'b11111111;
				in1 = 8'b11111001;
				in2 = 8'b11001111;
				in3 = 8'b11111111;
			end
			default:
			begin
				in0 = 8'b11111001;
				in1 = 8'b11111111;
				in2 = 8'b11111111;
				in3 = 8'b11001111;
			end
		endcase
	end

	assign sseg = sseg_reg;
	assign an = an_reg;

endmodule
