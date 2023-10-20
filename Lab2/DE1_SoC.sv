/**************** DE1_SoC ****************
 *
 * Caitlin DeShazo-Couchot and Ashley Guillard
 * Lab Group 4
 * October 18, 2023
 * EE 271: DE1_SoC for Lab 2
 *
 */
 
// Top-level module that defines the I/Os for the DE-1 SoC board
// Inputs: Takes in the keys 0 through 3 and switches 0 through 10 on the DE1-Board.
// Outputs: Displays on the HEX segment displays and the LEDs on the DE1-Board.
module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW); 
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;	
	input logic  [3:0] KEY; 
	input logic  [9:0] SW;
	
	/*Default values, turns off the HEX displays
	assign HEX0 = 7'b1111111; 
	assign HEX1 = 7'b1111111; 
	assign HEX2 = 7'b1111111; 
	assign HEX3 = 7'b1111111; 
	assign HEX4 = 7'b1111111;
	assign HEX5 = 7'b1111111;*/
	
	
	//COMMENT OUT WHICH TASKS YOU DON'T WANT TO RUN
	
	//LAB 2 TASK 1
	Stolen_And_Discounted_LEDs stolen_and_discounted_leds_inst(.LEDR(LEDR[1:0]), .SW(SW));
	
	//LAB 2 TASK 2
	Corresponding_Digit corresponding_digit_inst(.SW(SW[9:0]), .HEX0(HEX0));
	
	//LAB 3 TASK 3
	Segment_Seven_Display segment_seven_display_inst(.SW(SW[9:7]), .HEX1(HEX1), .HEX2(HEX2), 
																	 .HEX3(HEX3), .HEX4(HEX4), .HEX5(HEX5));
	
endmodule 


//Standard DE1_SoC Testbench to test all combinations
module DE1_SoC_testbench();

	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;
	logic [3:0] KEY;
	logic [9:0] SW;
	
	DE1_SoC dut(.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR, .SW);
	
	integer i;
	initial begin
		SW[9] = 1'b0;
		SW[8] = 1'b0;
		for (i=0; i <2**8; i++) begin
			SW[7:0] = i; #10;
		end
	end

endmodule
