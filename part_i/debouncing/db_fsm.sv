module db_fsm
(
	input logic clk, reset,
	input logic sw,
	output logic db
);
	localparam N = 20;
	localparam DVDR = 1_000_000;

	// Internal signal declaration
	// m_tick iterator
	logic [N-1:0] m_tick_reg;
	logic m_tick;

	// Moore FSM
	typedef enum 	{s0, wait1_1, wait1_2, wait1_3,
			 s1, wait0_1, wait0_2, wait0_3} state_type;
	state_type state_reg, state_next;

	always_ff @(posedge clk)
		if(reset)
			m_tick_reg <= 20'b0;
		else
			m_tick_reg <= m_tick_reg + 1;

	assign m_tick = (m_tick_reg == DVDR) ? 1'b1 : 1'b0;

	// first segment (state register)
	always_ff @(posedge clk, posedge reset)
		if (reset)
			state_reg <= s0;
		else
			state_reg <= state_next;

	// second segment (combinational logic, next-state and Moore output)
	always_comb
	begin
		state_next = state_reg;
		db = 1'b0;
		case (state_reg)
			s0:
			begin
				if(sw)
					state_next = wait1_1;
			end
			wait1_1: 
			begin
				if(~sw)
					state_next = s0;
				else if(m_tick)
					state_next = wait1_2;
			end
			wait1_2:
			begin
				if(~sw)
					state_next = s0;
				else if(m_tick)
					state_next = wait1_3;
			end
			wait1_3:
			begin
				if(~sw)
					state_next = s0;
				else if(m_tick)
					state_next = s1;
			end
			s1:
			begin
				db = 1'b1;
				if(sw)
					state_next = wait0_1;
			end
			wait0_1:
			begin
				db = 1'b1;
				if(sw)
					state_next = s1;
				else if(m_tick)
					state_next = wait0_2;
			end
			wait0_2:
			begin
				db = 1'b1;
				if(sw)
					state_next = s1;
				else if(m_tick)
					state_next = wait0_3;
			end
			wait0_3:
			begin
				db = 1'b1;
				if(sw)
					state_next = s1;
				else if(m_tick)
					state_next = s0;
			end
			default: state_next = s0;
		endcase
	end


endmodule
