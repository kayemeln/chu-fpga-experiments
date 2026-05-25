module temp_conv
(
	input logic clk,
	input logic format,
	input logic [7:0] temp,
	output logic [7:0] temp_conv
);
	logic [8:0] addr_adj;

	rom inst(.clk(clk), .addr(addr_adj), .data(temp_conv));

	always_comb
	begin
		if (format) begin // 1'b1 = celsius to farenheit
			if(temp > 100)
				addr_adj = 9'd100;
			else begin
				addr_adj = {{1'b0}, temp};
			end
		end
		else begin
			if(temp < 32)
				addr_adj = 9'd101;
			else if(temp > 211)
				addr_adj = 9'd281;
			else
				addr_adj = temp + 69;
		end
	end

endmodule
