/**************** Stolen_And_Discounted_LEDs ****************
 *
 * Caitlin DeShazo-Couchot and Ashley Guillard
 * Lab Group 4
 * October 18, 2023
 * EE 271: Displays the marks for stolen or discounted based on Switches
 *
 */

// TASK 1: Multi-Level Logic on the DE-1 FPGA
// Inputs: Sw9, Sw8, Sw7 for U, P, C, respectively, and Sw0 for the secret Mark.
// Outputs: LEDR[1] Represents if has been discounted, LEDR[0] represents stolen.
module Stolen_And_Discounted_LEDs(LEDR, SW);
	output logic [1:0] LEDR;
	input logic [9:0] SW;
	
	//DISCOUNT
	assign LEDR[1] = (~SW[9] &&  SW[8] &&  SW[7]) | //Bike
						  ( SW[9] && ~SW[8] &&  SW[7]) | //Coat
						  ( SW[9] &&  SW[8] && ~SW[7]);	//Socks
	
	//STOLEN (LEDR displays if item was expensive and no secret sold mark)
	assign LEDR[0] = (~SW[9] && ~SW[8] && ~SW[7] && ~SW[0]) | //Shoes
						  ( SW[9] && ~SW[8] && ~SW[7] && ~SW[0]) | //Suit
						  ( SW[9] && ~SW[8] &&  SW[7] && ~SW[0]);  //Coat
	
	//If neither cases, than this means either it was an expensive item without a secret mark
	//or it was a non-expensive item, with the mark, which is impossible. This covers all 4 cases.
	
endmodule

// Test bench to display the HEX0 Corresponding Digit to BCD
module Stolen_And_Discounted_LEDs_testbench();
	
	logic [1:0] LEDR;
	logic [9:0] SW;
	
	Stolen_And_Discounted_LEDs dut (LEDR, SW);
	
	initial begin
		//Tests all 6 items for HEX display
		SW[9] = 0; SW[8] = 0; SW[7] = 0; SW[0] = 0; #10; //Tests shoes, sold and stolen
													SW[0] = 1; #10;
													
		SW[9] = 0; SW[8] = 0; SW[7] = 1; SW[0] = 0; #10; //Tests jewelry
		
		SW[9] = 0; SW[8] = 1; SW[7] = 1; SW[0] = 0; #10; //Tests bike
		
		SW[9] = 1; SW[8] = 0; SW[7] = 0; SW[0] = 0; #10; //Tests suit, sold and stolen
													SW[0] = 1; #10;
													
		SW[9] = 1; SW[8] = 0; SW[7] = 1; SW[0] = 0; #10;
													SW[0] = 1; #10; //Tests coat, sold and stolen
													
		SW[9] = 1; SW[8] = 1; SW[7] = 0; SW[0] = 0; #10; //Tests socks
	
	$stop;
	end
endmodule