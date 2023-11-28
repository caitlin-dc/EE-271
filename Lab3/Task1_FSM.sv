//Ashley Guillard and Caitie DeShazo-Couchot
//10/27/2023
//EE 271
//Lab 3, Task 1

//fsm takes 1-bit clk, reset, and w as inputs and returns out as an output.
//This module implements a string recognizer for the string 1101. 

module fsm (clk, reset, w, out);

	input  logic  clk, reset, w;
	output logic  out;

	enum {S0, S1, S2, S3} ps, ns; // Present state, next state

	//Next state logic.
	always_comb begin
		case (ps)
			S0: if (w) ns = S1;
			      else ns = S0;
			S1: if (w) ns = S2;
					else ns = S0;
			S2: if (w) ns = S2;
					else ns = S3;
			S3: if (w) ns = S1;
					else ns = S0;
		endcase
	end
			
	assign out = (ps == S3) & w;  //If in state3 and w=1, output=1
	
	//sequential logic (DFFs)
		always_ff @(posedge clk) begin
			if (reset)
				ps <= S0;
			else
				ps <= ns;
		end
				
	
endmodule

//fsm_testbench tests the string 0111101111011110111. There are three 1101 is this string.

module fsm_testbench();

		logic clk, reset, w, out;
		
		fsm dut (.clk, .reset, .w, .out);
		
		//clock setup
		parameter clock_period = 100;
		
		initial begin
			clk <= 0;
			forever #(clock_period /2) clk <= ~clk;
					
		end //initial
		
		initial begin //Finds 1101 three times
		
			reset <= 1;         @(posedge clk);
			reset <= 0; w<=0;   @(posedge clk);
							w<=1;	  @(posedge clk);
			                    @(posedge clk);	
			                    @(posedge clk);	
			            w<=1;   @(posedge clk);	
							w<=0;   @(posedge clk);	
							w<=1;   @(posedge clk);	
									  @(posedge clk);	
			                    @(posedge clk);	
			                    @(posedge clk);	
							w<=0;   @(posedge clk);	
							w<=1;	  @(posedge clk);	
									  @(posedge clk);	
							w<=1;	  @(posedge clk);
							w<=1;   @(posedge clk);	
							w<=0;   @(posedge clk);	
							w<=1;   @(posedge clk);	
									  @(posedge clk);
									  @(posedge clk);
			$stop; //end simulation							
							
		end //initial
		
endmodule		