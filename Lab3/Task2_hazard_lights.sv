/**************** Hazard_Lights ****************
 *
 * Caitlin DeShazo-Couchot and Ashley Guillard
 * Lab Group 4
 * November 2, 2023
 * EE 271: Lab 3 (Task 2) - Clock Divider to Manage Clock Speed
 *
 */
// Wind Indicator for the Hazard Lights of the SeaTac Airport
// The next state logic is determined by the switches and output logic by LEDR
// Inputs: Clock, reset(represented by the Key[0], and Switches 1 and 0
// Outputs: LEDR 2 through 0
module hazard_lights (
    input logic clk,
    input logic reset,
    input logic [1:0] SW,
    output logic [2:0] LEDR
);

    // State variables
    enum logic [1:0] { LEFT, MIDDLE, RIGHT, OUTSIDE } ps, ns;

    // Next State logic
    always_comb begin
            case (ps)
                LEFT: 
                    if (SW[1] == 1 && SW[0] == 0)
                        ns = MIDDLE;
                    else if (SW[1] == 0 && SW[0] == 1)
								ns = RIGHT;
						  else
								ns = MIDDLE;
                MIDDLE: 
                    if (SW[1] == 1 && SW[0] == 0)
                        ns = RIGHT;
                    else if (SW[1] == 0 && SW[0] == 1)
                        ns = LEFT;
                    else
                        ns = OUTSIDE;
                RIGHT: 
                    if (SW[1] == 0 && SW[0] == 1)
                        ns = MIDDLE;
                    else if (SW[1] == 1 && SW[0] == 0)
                        ns = LEFT;
                    else
                        ns = OUTSIDE;
					 OUTSIDE:
						if (SW[1] == 1 && SW[0] == 0)
                        ns = LEFT;
                  else if (SW[1] == 0 && SW[0] == 1)
                        ns = RIGHT;
                  else
                        ns = MIDDLE;
            endcase
        end

    // Output logic
    always_comb begin
        case (ps)
				LEFT:
					LEDR = 3'b100;
				MIDDLE:
					LEDR = 3'b010;
				RIGHT:
					LEDR = 3'b001;
				OUTSIDE:
					LEDR = 3'b101;
        endcase
    end

    // DFFs
    always_ff @(posedge clk) begin
        if (reset)
            ps <= OUTSIDE;
        else
            ps <= ns;
    end
endmodule

module hazard_lights_testbench();

    logic clk;
    logic reset;
    logic [1:0] SW;
    logic [2:0] LEDR;

    // Instantiate the hazard_lights module
    hazard_lights dut (.clk,.reset,.SW,.LEDR);

	 //clock setup
	parameter clock_period = 100;
		
	initial begin
		clk <= 0;
		forever #(clock_period) clk <= ~clk;
					
	end //initial
	 
    initial begin
		reset <= 1;					@(posedge clk); //Reset
		reset <= 0;	SW = 2'b00;	@(posedge clk); //CALM (OUTSIDE to MIDDLE)
										@(posedge clk);
										@(posedge clk);
										@(posedge clk);
						SW = 2'b10;	@(posedge clk); //LEFT (LEFT to MIDDLE to RIGHT)
										@(posedge clk);
										@(posedge clk);
										@(posedge clk);
						SW = 2'b01; @(posedge clk); //RIGHT (RIGHT to MIDDLE to LEFT)
										@(posedge clk);
										@(posedge clk);
										@(posedge clk);

		$stop;
	end //initial

endmodule
	 
	 
	 
	 
	 
	