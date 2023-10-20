/**************** Segment_Seven_Display ****************
 *
 * Caitlin DeShazo-Couchot and Ashley Guillard
 * Lab Group 4
 * October 18, 2023
 * EE 271: Displays the codes on the Segment Seven
 *
 */
 
// Codes the segment 7 active low displays corresonding to switches, in RTL.
// Inputs: SW[9:7] used to refer to the 6 different UPC inputs.
// Outputs: HEX used to refer to each individual light in the segment 7 display.
// Note: Does not utilize or default HEX0 because HEX0 used in corresponding_Digit.sv
module Segment_Seven_Display (
	input logic [9:7] SW,
	output logic [6:0] HEX1, HEX2, HEX3, HEX4, HEX5
	);
	
	 always_comb begin
        case (SW[9:7])
            3'b000: begin
					HEX5 = 7'b0010010;     
					HEX4 = 7'b0001001;
					HEX3 = 7'b1000000;
					HEX2 = 7'b0000110;
					HEX1 = 7'b0010010;// 000 Shoes = SHOES\
					end
            3'b001: begin 
					HEX5 = 7'b1110001;     
					HEX4 = 7'b0000110;
					HEX3 = 7'b1000001;
					HEX2 = 7'b0000110;
					HEX1 = 7'b1000111;// 001 Costume Jewelry = JEWEL
					end
            3'b011: begin 
					HEX5 = 7'b0000011;        
					HEX4 = 7'b1111010;
					HEX3 = 7'b0001010;
					HEX2 = 7'b0000110; // 011 Bike = bikE
					HEX1 = 7'b1111111; 
					end
            3'b100: begin
					HEX5 = 7'b0010010;     
					HEX4 = 7'b1000001;
					HEX3 = 7'b1111001;
					HEX2 = 7'b0000111; // 100 Business Suit = SUIt
					HEX1 = 7'b1111111;
					end
            3'b101: begin 
					HEX5 = 7'b1000110;     
					HEX4 = 7'b1000000;
					HEX3 = 7'b0001000;
					HEX2 = 7'b0000111; // 101 Winter Coat = COAt
					HEX1 = 7'b1111111;
					end
            3'b110: begin 
					HEX5 = 7'b0010010;     
					HEX4 = 7'b1000000;
					HEX3 = 7'b1000110;
					HEX2 = 7'b0001010;
					HEX1 = 7'b0010010; // 111 Socks = SOCKS
					end
            default: {HEX5, HEX4, HEX3, HEX2, HEX1} = 7'b1111111; // NO DISPLAY IF NO MATCHING ITEMS
        endcase
    end
endmodule

// Test bench to display the Item codes
module Segment_Seven_Display_testbench();
	
	logic [6:0] HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:7] SW;
	
	Segment_Seven_Display dut (SW, HEX1, HEX2, HEX3, HEX4, HEX5);
	
	initial begin
		//Tests all 6 items for HEX display
		SW[9] = 0; SW[8] = 0; SW[7] = 0; #10;
		SW[9] = 0; SW[8] = 0; SW[7] = 1; #10;
		SW[9] = 0; SW[8] = 1; SW[7] = 1; #10;
		SW[9] = 1; SW[8] = 0; SW[7] = 0; #10;
		SW[9] = 1; SW[8] = 0; SW[7] = 1; #10;
		SW[9] = 1; SW[8] = 1; SW[7] = 0; #10;

		$stop;
	end //initial
endmodule
	
												