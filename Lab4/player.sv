/* 
	Caitlin DeShazo-Couchot and Ashley Guillard
	EE 271 Au23: Professor Hussein
	November 9, 2023
	Lab 4: Player 1 and 2
*/

// Handles the user input for key and moving the LED to the right or left in the game of tug-of-war.
// Inputs: CLOCK, Reset, and the Key assigned to player 1 or 2.
// Outputs: Handles whether or not the button was properly pressed.
module player (CLOCK, Reset, KEY, out);

	 // INPUT LOGIC
    input logic CLOCK, Reset, KEY;
	 
	 // OUTPUT LOGIC
    output logic out;

    // State Variables
	 enum logic [1:0] { ON, OFF } ps, ns;
    
    
    // Next State Logic
    always_comb
    begin
        case (ps)
            OFF:
                if (KEY)
                    ns = ON;
                else 
                    ns = OFF;
            ON: 
                if (KEY)
                    ns = ON;
                else
                    ns = OFF;
        endcase
    end
	 
	 // Output Logic
	 always_comb begin
		case(ps)
			OFF:
				out = 1'b0;
			ON:
				out = 1'b1;
		endcase
	end
	 
    // Sequential Logic
    always_ff @(posedge CLOCK, posedge Reset) begin
        if (Reset)
            ps <= OFF;
        else
            ps <= ns;
    end
	 
	 assign out = ((ns == OFF) & (ps == ON));
	 
endmodule
