/**************** DE1_SoC ****************
 *
 * Caitlin DeShazo-Couchot and Ashley Guillard
 * Lab Group 4
 * October 11, 2023
 * EE 271: DE1_SoC for Lab 1
 *
 */
 
//Standard I/O for the DE1_SoC Board
//Top Level Module for Lab 1
module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);

	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic [9:0] SW;
	
	logic [3:0] A, B, sum;
	logic cout, cin;
	
	  
	// Inputs: Switches 1 through 4 for A, Switches 5 through 8 for B
	//	Output: LED4 for Cout, and LEDs 0 through 4 for Sum
	fulladder_4b FA(.A(SW[4:1]), .B(SW[8:5]), .cin(SW[0]), .sum(LEDR[3:0]), .cout(LEDR[4]));
	
	//Display "Adding" on the Seg7 HEX5 through HEX0
	assign HEX5 = 7'b0001000; //A
	assign HEX4 = 7'b0100001; //d
	assign HEX3 = 7'b0100001; //d
	assign HEX2 = 7'b1111010; //i
	assign HEX1 = 7'b0101011; //n
	assign HEX0 = 7'b0010000; //g
	
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
