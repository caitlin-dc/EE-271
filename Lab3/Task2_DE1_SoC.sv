/* 
	Caitlin DeShazo-Couchot and Ashley Guillard
	EE 271 Au23: Professor Hussein
	November 2, 2023
	Lab 3
*/

//Top level module for the DE1_SoC Board
//I/O Needed for the DE1_DoC as well as clock_50
module DE1_SoC (
    output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5,
    output logic [9:0] LEDR,
    input logic [3:0] KEY,
    input logic [9:0] SW,
    input logic CLOCK_50
);

	// Default values, turns off the HEX displays
	assign HEX0 = 7'b1111111; 
	assign HEX1 = 7'b1111111; 
	assign HEX2 = 7'b1111111; 
	assign HEX3 = 7'b1111111; 
	assign HEX4 = 7'b1111111;
	assign HEX5 = 7'b1111111;
	
    // Generate clk off of CLOCK_50, whichClock picks rate.
    logic reset;
    logic [31:0] div_clk;

    parameter whichClock = 25; // 0.75 Hz clock
    clock_divider cdiv (.clock(CLOCK_50),
                        .reset(reset),
                        .divided_clocks(div_clk));

    // Clock selection; allows for easy switching between simulation and board clocks
    logic clkSelect;

    // Uncomment ONE of the following two lines depending on intention
    //assign clkSelect = CLOCK_50; // for simulation
    assign clkSelect = div_clk[whichClock]; // for board

    // Instantiate the hazard_lights module
    hazard_lights hazard_inst(
        .clk(clkSelect),
        .reset(~KEY[0]),
        .SW(SW[1:0]),
        .LEDR(LEDR[2:0]) // Connect LEDR[2:0] to the outputs of the hazard_lights module
    );

    // Show signals on LEDRs so we can see what is happening
    //assign LEDR[9:3] = 7'b0000000;
    //assign LEDR[2:0] = hazard_inst.LEDR; // Connect LEDR[2:0] to the outputs of the hazard_lights module
    assign LEDR[9] = clkSelect;
	 assign LEDR[8] = KEY[0];

endmodule


// Test bench for the testbench module.
// Standard I/O for the DE1_SoC
module DE1_SoC_testbench();
    logic CLOCK_50;
    logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
    logic [9:0] LEDR;
    logic [3:0] KEY;
    logic [9:0] SW;

    // Instantiate hazard_lights module
    hazard_lights dut_hazard(
        .clk(CLOCK_50),
        .reset(~KEY[0]),
        .SW(SW[1:0]),
        .LEDR(LEDR[2:0])
    );

    // Set up a simulated clock.
    parameter CLOCK_PERIOD = 100;
    initial begin
        CLOCK_50 <= 0;
        forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50; // Forever toggle the clock
    end

    // Test the design.
    initial begin
        repeat(1) @(posedge CLOCK_50);
        SW[9] <= 1; repeat(1) @(posedge CLOCK_50); // Always reset FSMs at start
        SW[9] <= 0; repeat(1) @(posedge CLOCK_50);
        SW[0] <= 0; repeat(4) @(posedge CLOCK_50); // Test case 1: input is 0
        SW[0] <= 1; repeat(1) @(posedge CLOCK_50); // Test case 2: input 1 for 1 cycle
        SW[0] <= 0; repeat(1) @(posedge CLOCK_50);
        SW[0] <= 1; repeat(4) @(posedge CLOCK_50); // Test case 3: input 1 for >2 cycles
        SW[0] <= 0; repeat(2) @(posedge CLOCK_50);
        $stop; // End the simulation.
    end
endmodule
