/* 
	Caitlin DeShazo-Couchot and Ashley Guillard
	EE 271 Au23: Professor Hussein
	November 9, 2023
	Lab 4: Divided Clocks
*/
// divided_Clocks[0] = 25MHz, [1] = 12.5Mhz, ... [23] = 3Hz, [24] = 1.5Hz, [25] = 0.75Hz
module Clock_divider (Clock, reset, divided_Clocks);
	input logic reset, Clock;
	output logic [31:0] divided_Clocks = 0;

	always_ff @(posedge Clock) begin
		divided_Clocks <= divided_Clocks + 1;
	end
endmodule