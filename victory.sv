        /* 
	Caitlin DeShazo-Couchot and Ashley Guillard
	EE 271 Au23: Professor Hussein
	November 9, 2023
	Lab 4: Victory Logic
*/
// Handles the Victory Case for HEX0 where 1 is displayed for Player 1 and 2 for Player 2.
// Inputs: CLOCK, Reset, Left Button, Right Button, Left Light, and Right Light.
// Outputs: The state of the LED this is referring to, either On or Off.
module victory (CLOCK, Reset, L, R, LEDR9, LEDR1, HEX0);

	 // INPUT LOGIC
    input logic CLOCK, Reset, L, R, LEDR9, LEDR1;
	 
	 // OUTPUT LOGIC
    output logic [6:0] HEX0;
	 
	 enum { P1, P2, NONE } ps, ns;

	 // Combinational Logic
    always_comb begin
        case (ps)
				P1: ns = P1;
				P2: ns = P2;
				NONE: 
					if (L == 1 && R == 0 && LEDR1 == 1)
						ns == P1;
					else if (L == 0 && R == 1 && LEDR9 == 1)
						ns == P2;
					else
						ns == NONE;
			endcase
    end
	 
	 // Output Logic
	 always_comb begin
		case (ps)
			P1: HEX0 = 7'b0100100;
			P2: HEX0 = 7'b1111001;
			NONE: HEX0 = 7'b1111111;
		endcase
	end
	
	// Sequential Logic
	always_ff @(posedge CLOCK) begin
		if (Reset)
			ps <= NONE;
		else 
			ps <= ns;
	end

endmodule
