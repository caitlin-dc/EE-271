/**************** Corresponding_Digit ****************
 *
 * Caitlin DeShazo-Couchot and Ashley Guillard
 * Lab Group 4
 * October 18, 2023
 * EE 271: Displays the marks for stolen or discounted based on Switches
 *
 */
 
// TASK 2: Connects seg7 to the SW[9:6] to display on HEX0
// Inputs: SW[9:6] to give a 4-bit input value
// Outputs: HEX0 to display the number from the encoding in seg7.sv
module Corresponding_Digit(
	input logic  [9:0] SW,
	output logic [6:0] HEX0
	);
	
	//Get values of UPCM from concatenating the SW[9:7] and SW[0] value
	logic [3:0] UPCM;
	always_comb begin
		 UPCM = {SW[9], SW[8], SW[7], SW[0]};
	end
	
	seg7 getHEX0(.bcd(UPCM), .leds(HEX0));
	
endmodule

// Test bench to display the HEX0 Corresponding Digit to BCD
module Corresponding_Digit_testbench();
	
	logic [9:0] SW;
	logic [6:0] HEX0;
	logic [3:0] UPCM;
	
	Corresponding_Digit dut (SW, HEX0);
	
	initial begin
	
		//Tests all 10 cases for seg7
		UPCM[3] = 0; UPCM[2] = 0; UPCM[1] = 0; UPCM[0] = 0;
		UPCM[3] = 0; UPCM[2] = 0; UPCM[1] = 0; UPCM[0] = 1;
		UPCM[3] = 0; UPCM[2] = 0; UPCM[1] = 1; UPCM[0] = 0;
		UPCM[3] = 0; UPCM[2] = 0; UPCM[1] = 1; UPCM[0] = 1;
		UPCM[3] = 0; UPCM[2] = 1; UPCM[1] = 0; UPCM[0] = 0;
		UPCM[3] = 0; UPCM[2] = 1; UPCM[1] = 0; UPCM[0] = 1;
		UPCM[3] = 0; UPCM[2] = 1; UPCM[1] = 1; UPCM[0] = 0;
		UPCM[3] = 0; UPCM[2] = 1; UPCM[1] = 1; UPCM[0] = 1;
		UPCM[3] = 1; UPCM[2] = 0; UPCM[1] = 0; UPCM[0] = 0;
		UPCM[3] = 1; UPCM[2] = 0; UPCM[1] = 0; UPCM[0] = 1;
		
		
		$stop;
	end //initial
endmodule