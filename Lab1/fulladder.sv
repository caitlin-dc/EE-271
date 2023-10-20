/**************** FullAdder.sv ****************
 *
 * Caitlin DeShazo-Couchot and Ashley Guillard
 * Lab Group 4
 * October 11, 2023
 * EE 271: FullAdder 2-Bit Module
 *
 */

//Inputs: A, B, and a Carry-In 
//Outputs:Sum and a Carry-Out
//Adds two single bit values together for a two bit output.
module fulladder (A, B, cin, sum, cout);

	input logic A,B, cin;
	output logic sum, cout;
	
	assign sum = A ^ B ^ cin;
	assign cout = A & B | cin & (A^B);
	
endmodule

//Testbench for the 2-Bit Full Adder
module fulladder_testbench();

	logic A, B, cin, sum, cout;
	
	fulladder dut (A, B, cin, sum, cout);
	
	integer i;
	initial begin
		for (i=0; i<2**3; i++) begin
			{A, B, cin} = i; #10;
		end //for loop
		
	end //initial
	
endmodule 