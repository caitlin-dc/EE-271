/**************** fulladder_4b.sv ****************
 *
 * Caitlin DeShazo-Couchot and Ashley Guillard
 * Lab Group 4
 * October 11, 2023
 * EE 271: fulladder 4-Bit Module
 *
 */

//Inputs: A, B, and a Carry-In 
//Outputs:Sum and a Carry-Out
//Adds two double bit values together for a four bit output.
module fulladder_4b (A, B, cin, sum, cout);

	input logic  [3:0] A; //A has 4 bits
	input logic  [3:0] B; //B has 4 bits
	input logic cin;
	
	output logic [3:0] sum; 
	output logic cout;
	
	//Intermediate Carry Ins from the Carry Outs of the FA before them
	logic c0;
	logic c1;
	logic c2;
	
	fulladder FA0 (.A(A[0]), .B(B[0]), .cin(cin), .sum(sum[0]), .cout(c0));
	fulladder FA1 (.A(A[1]), .B(B[1]), .cin(c0),  .sum(sum[1]), .cout(c1));
	fulladder FA2 (.A(A[2]), .B(B[2]), .cin(c1),  .sum(sum[2]), .cout(c2));
	fulladder FA3 (.A(A[3]), .B(B[3]), .cin(c2),  .sum(sum[3]), .cout(cout));
	
endmodule 