/* 
	Caitlin DeShazo-Couchot and Ashley Guillard
	EE 271 Au23: Professor Hussein
	November 9, 2023
	Lab 4: Center LED (LEDR 5)
*/

// Handles the LED5 (Center LED) during the game of Tug-of-War. Also starting or reset LED.
// Inputs: CLOCK, Reset, Left Button, Right Button, Left Light, and Right Light.
// Outputs: The state of the LED this is referring to, either On or Off.
module centerLight (CLOCK, Reset, L, R, NL, NR, lightOn);
	  
	// INPUT LOGIC
   input logic CLOCK, Reset;
	 
	// GAME LOGIC
	// L is true when left key is pressed, R is true when the right key is pressed.
	// NL is true when the light on the left is on, and NR is true when the light on the right is on.
	input logic L, R, NL, NR;
	 
	// OUTPUT LOGIC: When lightOn is true, the normal light should be on.
   output logic lightOn;


	// State Variables
   enum logic [1:0] { OFF, ON } ps, ns;
	 
	// Next State Logic
	always_comb begin
		case (ps)
			OFF: 
				if ((NL & R & ~L) | (NR & L & ~R))
					ns = ON;
				else 
					ns = OFF;
			ON:
				if ((R & ~L) | (L &~R))
					ns = OFF;
				else
					ns = ON;
		endcase
	end
	
	// Output Logic
	always_comb begin
		case (ps)
			OFF:
				lightOn = 1'b0;
			ON:
				lightOn = 1'b1;
		endcase
	end
	
	// DFFs
	always_ff @(posedge CLOCK) begin
		if (Reset)
			ps <= ON;
		else
			ps <= ns;
	end

endmodule
//Tests all possible combinations for the normalLight
module centerLight_testbench();
	
	// Test inputs and outputs
   logic CLOCK, Reset, L, R, NL, NR;
   logic lightOn;

   // Instantiate the hazard_lights module
   centerLight dut (.CLOCK, .Reset, .L, .R, .NL, .NR, .lightOn);

	 //CLOCK setup
	parameter CLOCK_period = 10;
		
	initial begin
		CLOCK <= 0;
		forever #(CLOCK_period) CLOCK <= ~CLOCK;
					
	end //initial

   // Test cases for Tug of War game
   initial begin
		Reset <= 1;												@(posedge CLOCK); //Reset
		Reset <= 0;		L = 0; R = 0; NL = 0; NR = 0; @(posedge CLOCK);
														 NR = 1; @(posedge CLOCK);
											  NL = 1; NR = 0; @(posedge CLOCK);
														 NR = 1; @(posedge CLOCK);
									 R = 1; NL = 0; NR = 0; @(posedge CLOCK);
														 NR = 1; @(posedge CLOCK);
											  NL = 1; NR = 0; @(posedge CLOCK);
														 NR = 1; @(posedge CLOCK);
							L = 1; R = 0; NL = 0; NR = 0; @(posedge CLOCK);
														 NR = 1; @(posedge CLOCK);
											  NL = 1; NR = 0; @(posedge CLOCK);
														 NR = 1; @(posedge CLOCK);
									 R = 1; NL = 0; NR = 0; @(posedge CLOCK);
														 NR = 1; @(posedge CLOCK);
											  NL = 1; NR = 0; @(posedge CLOCK);
														 NR = 1; @(posedge CLOCK);
		$stop;
   end //initial
endmodule
