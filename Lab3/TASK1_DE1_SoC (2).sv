//Ashley Guillard and Caitie DeShazo-Couchot
//10/27/2023
//EE 271
//Lab 3, Task 1

//DE1_SoC takes 1-bit CLOCK_50, 4-bit KEY, and 10-bit SW as inputs and returns 6-bit HEX0, HEX1, HEX2
//HEX3, HEX4, HEX5, and 10-bit LEDR as outputs. The HEX displays are turned off. 

module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
	
	input logic CLOCK_50; // 50MHz clock
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY; // Active low property
	input logic [9:0] SW;

	//Turn of all HEX displays
	assign HEX0 = 7'b1111111;
	assign HEX1 = 7'b1111111;
	assign HEX2 = 7'b1111111;
	assign HEX3 = 7'b1111111;
	assign HEX4 = 7'b1111111;
	assign HEX5 = 7'b1111111;
	
	// Generate clk off of CLOCK_50, whichClock picks rate.

	logic [31:0] clk;

	parameter whichClock = 25;

	clock_divider cdiv (CLOCK_50, clk);

	logic reset;  // configure reset

	assign reset = ~KEY[0]; // Reset when KEY[0] is pressed
	
	assign LEDR[5] = clk[whichClock];
	
	// instantiates Hazard light and assigned corresponding ports
	fsm f1 (.clk(clk[whichClock]), .reset(reset), .w(SW[0]), .out(LEDR[0]));

endmodule

module DE1_SoC_testbench();

		logic CLOCK_50; // 50MHz clock
		logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
		logic [9:0] LEDR;
		logic [3:0] KEY; // Active low property
		logic [9:0] SW;

		
		DE1_SoC dut (.CLOCK_50, .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR, .SW);
		
		//clock setup
		parameter clock_period = 100;
		
		initial begin
			CLOCK_50 <= 0;
			forever #(clock_period /2) CLOCK_50 <= ~CLOCK_50;
					
		end //initial
		
		initial begin //Should find 1101 three times
		
			KEY[0] <= 0;            @(posedge CLOCK_50);
			KEY[0] <= 1; SW[0]<=0;  @(posedge CLOCK_50);
							SW[0]<=1;   @(posedge CLOCK_50);
			                        @(posedge CLOCK_50);	
			                        @(posedge CLOCK_50);	
			            SW[0]<=1;   @(posedge CLOCK_50);	
							SW[0]<=0;   @(posedge CLOCK_50);	
							SW[0]<=1;   @(posedge CLOCK_50);	
									      @(posedge CLOCK_50);	
			                        @(posedge CLOCK_50);	
			                        @(posedge CLOCK_50);	
							SW[0]<=0;   @(posedge CLOCK_50);	
							SW[0]<=1;   @(posedge CLOCK_50);	
									      @(posedge CLOCK_50);	
							SW[0]<=1;   @(posedge CLOCK_50);
							SW[0]<=1;   @(posedge CLOCK_50);	
							SW[0]<=0;   @(posedge CLOCK_50);	
							SW[0]<=1;   @(posedge CLOCK_50);	
									      @(posedge CLOCK_50);
									      @(posedge CLOCK_50);
			$stop; //end simulation							
							
		end //initial
		
endmodule		