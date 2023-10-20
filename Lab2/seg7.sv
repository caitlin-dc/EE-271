/**************** seg7 ****************
 *
 * Caitlin DeShazo-Couchot and Ashley Guillard
 * Lab Group 4
 * October 18, 2023
 * EE 271: Seg7 provided
 *
 */
 
// TASK 2: Displays a digit on the segment 7 display according to bcd input
// Inputs: bcd to decrypt the value of a 4 bit input
// Outputs: 7 bit output leds to display the number value according to seg7
module seg7 (bcd, leds);
	input logic [3:0] bcd;
	output logic [6:0] leds;
	
	always_comb begin case
		(bcd)
		// Light: 6543210
		4'b0000: leds = 7'b0111111; // 0
		4'b0001: leds = 7'b0000110; // 1
		4'b0010: leds = 7'b1011011; // 2
		4'b0011: leds = 7'b1001111; // 3
		4'b0100: leds = 7'b1100110; // 4
		4'b0101: leds = 7'b1101101; // 5
		4'b0110: leds = 7'b1111101; // 6
		4'b0111: leds = 7'b0000111; // 7
		4'b1000: leds = 7'b1111111; // 8
		4'b1001: leds = 7'b1101111; // 9
		default: leds = 7'bX; endcase
	end
endmodule

module seg7_testbench();
	
	logic [9:0] bcd;
	logic [6:0] leds;
	
	seg7 dut (bcd, leds);
	
	initial begin
	
		//Tests all 10 cases for seg7
		bcd = 4'b0000; //0
		bcd = 4'b0001; //1
		bcd = 4'b0010; //2
		bcd = 4'b0011; //3
		bcd = 4'b0100; //4
		bcd = 4'b0101; //5
		bcd = 4'b0110; //6
		bcd = 4'b0111; //7
		bcd = 4'b1000; //8
		bcd = 4'b1001; //9
		
		$stop;
	end //initial
endmodule