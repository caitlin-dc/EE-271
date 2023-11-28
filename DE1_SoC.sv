/* 
	Caitlin DeShazo-Couchot and Ashley Guillard
	EE 271 Au23: Professor Hussein
	November 9, 2023
	Lab 4: LED2, LED3, LED4, LED6, LED7, LED8
*/

//Top level module for the DE1_SoC Board
//I/O Needed for the DE1_DoC as well as CLOCK_50
module DE1_SoC (
    output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5,
    output logic [9:0] LEDR,
    input logic  [3:0] KEY,
    input logic  [9:0] SW,
    input logic  CLOCK_50
);
    
    // Default values, turns off the HEX displays
    assign HEX1 = 7'b1111111; 
    assign HEX2 = 7'b1111111; 
    assign HEX3 = 7'b1111111; 
    assign HEX4 = 7'b1111111;
    assign HEX5 = 7'b1111111;
    
    // Logic Variables
    logic L, R, L_Tug, R_Tug;

	 // Flip Flops for Tug-of-War to handle Metastability
    metaStability L_dff (.CLOCK(CLOCK_50), .Reset(SW[9]), .KEY(~KEY[0]), .out(R_Tug));
    metaStability R_dff (.CLOCK(CLOCK_50), .Reset(SW[9]), .KEY(~KEY[3]), .out(L_Tug));

    // User Inputs
    player player1 (.CLOCK(CLOCK_50), .Reset(SW[9]), .KEY(R_Tug), .out(R));
    player player2 (.CLOCK(CLOCK_50), .Reset(SW[9]), .KEY(L_Tug), .out(L));
    
    // Instantiate LED FSMs for LED1 to LED4
    normalLight led1(.CLOCK(CLOCK_50), .Reset(SW[9]), .L(L), .R(R), .NL(LEDR[2]), .NR(1'b0), 	.lightOn(LEDR[1]));
    normalLight led2(.CLOCK(CLOCK_50), .Reset(SW[9]), .L(L), .R(R), .NL(LEDR[3]), .NR(LEDR[1]), .lightOn(LEDR[2]));
    normalLight led3(.CLOCK(CLOCK_50), .Reset(SW[9]), .L(L), .R(R), .NL(LEDR[4]), .NR(LEDR[2]), .lightOn(LEDR[3]));
    normalLight led4(.CLOCK(CLOCK_50), .Reset(SW[9]), .L(L), .R(R), .NL(LEDR[5]), .NR(LEDR[3]), .lightOn(LEDR[4]));
	 
	 // Instatiate center LED FSM, LED5
    centerLight led5(.CLOCK(CLOCK_50), .Reset(SW[9]), .L(L), .R(R), .NL(LEDR[6]), .NR(LEDR[4]), .lightOn(LEDR[5]));
	 
	 // Instantiate LED FSMs for LED1 to LED4
    normalLight led6(.CLOCK(CLOCK_50), .Reset(SW[9]), .L(L), .R(R), .NL(LEDR[7]), .NR(LEDR[5]), .lightOn(LEDR[6]));
    normalLight led7(.CLOCK(CLOCK_50), .Reset(SW[9]), .L(L), .R(R), .NL(LEDR[8]), .NR(LEDR[6]), .lightOn(LEDR[7]));
    normalLight led8(.CLOCK(CLOCK_50), .Reset(SW[9]), .L(L), .R(R), .NL(LEDR[9]), .NR(LEDR[7]), .lightOn(LEDR[8]));
    normalLight led9(.CLOCK(CLOCK_50), .Reset(SW[9]), .L(L), .R(R), .NL(1'b1),    .NR(LEDR[8]), .lightOn(LEDR[9]));

    // Instantiate victory logic to control HEX0
    victory victory_game(.CLOCK(CLOCK_50), .Reset(SW[9]), .LEDR9(LEDR[9]), .LEDR1(LEDR[1]), .L(L), .R(R),  .HEX0(HEX0));

endmodule

// Test bench for the testbench module.
// Standard I/O for the DE1_SoC
module DE1_SoC_testbench();
     // Test inputs and outputs
    logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
    logic [9:0] LEDR;
    logic  [3:0] KEY;
    logic  [9:0] SW;
    logic CLOCK_50;

    // Instantiate the DUT (Device Under Test)
    DE1_SoC dut(HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, LEDR, KEY, SW, CLOCK_50);

    // Define Clock period for simulation
    parameter Clock_PERIOD = 100;

    // Clock generation for simulation
    initial begin
        CLOCK_50 <= 0;
        forever #Clock_PERIOD CLOCK_50 <= ~CLOCK_50;
    end
		  
		 initial begin
        // Reset the game
        SW[9] <= 1; @(posedge CLOCK_50)
        SW[9] <= 0; @(posedge CLOCK_50)

        // Game starts, LEDs should be initialized
        KEY[0] <= 1; KEY[3] <= 1; @(posedge CLOCK_50)

        // Game where Player1 wins right away
		  for (int i=0; i<6; i++) begin
			  KEY[0] <= 0; @(posedge CLOCK_50);
			  KEY[0] <= 1; @(posedge CLOCK_50);
		  end
		  
		  @(posedge CLOCK_50) //To view change in HEX0 in ModelSim
		  @(posedge CLOCK_50)
		  @(posedge CLOCK_50)
		  @(posedge CLOCK_50)
        
        // Game reset and play again
        SW[9] <= 1; @(posedge CLOCK_50)
        SW[9] <= 0; @(posedge CLOCK_50)
		  
		  // Game starts, LEDs should be initialized
        KEY[0] <= 1; KEY[3] <= 1; @(posedge CLOCK_50)

        // Game where Player2 wins right away
		  for (int i=0; i<6; i++) begin
			  KEY[3] <= 0; @(posedge CLOCK_50);
			  KEY[3] <= 1; @(posedge CLOCK_50);
		  end
		  
		  @(posedge CLOCK_50) //To view change in HEX0 in ModelSim
		  @(posedge CLOCK_50)
		  @(posedge CLOCK_50)
		  @(posedge CLOCK_50)
		  
		  // Game reset and play again
        SW[9] <= 1; @(posedge CLOCK_50)
        SW[9] <= 0; @(posedge CLOCK_50)
		  
		  // Game starts, LEDs should be initialized
        KEY[0] <= 1; KEY[3] <= 1; @(posedge CLOCK_50)

        // Game where Players go back and forth, Player2 wins
		  for (int i=0; i<5; i++) begin
			  KEY[3] <= 0; @(posedge CLOCK_50);
			  KEY[3] <= 1; @(posedge CLOCK_50);
			  KEY[0] <= 0; @(posedge CLOCK_50); // Tests long press
			  KEY[3] <= 0; @(posedge CLOCK_50);
			  KEY[3] <= 1; @(posedge CLOCK_50);
			  KEY[0] <= 1; @(posedge CLOCK_50);
		  end
			
		  @(posedge CLOCK_50) //To view change in HEX0 in ModelSim
		  @(posedge CLOCK_50)
		  @(posedge CLOCK_50)
		  @(posedge CLOCK_50)
        	 
		$stop;
    end
        
endmodule