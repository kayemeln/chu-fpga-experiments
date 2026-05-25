module rom
(
	input clk,
	input logic [8:0] addr,
	output logic [7:0] data
);

	logic [7:0] rom [0:281];
	logic [7:0] data_reg;

	initial begin
		$readmemb("c_to_f.txt", rom, 0, 100);
		$readmemb("f_to_c.txt", rom, 101, 281);
	end

	always_ff @(posedge clk)
		data_reg <= rom[addr];

	assign data = data_reg;

endmodule
