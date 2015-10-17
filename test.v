`timescale 1ns / 1ps

module test;

	// Inputs
	reg CLOCK_Y2;
	reg SCK;
	reg MOSI;
	reg SS;

	// Outputs
	wire MISO;
	wire LED1;

	// Instantiate the Unit Under Test (UUT)
	SPI_slave uut (
		.CLOCK_Y2(CLOCK_Y2), 
		.SCK(SCK), 
		.MOSI(MOSI), 
		.MISO(MISO), 
		.SS(SS), 
		.LED1(LED1)
	);

	initial begin
		// Initialize Inputs
		CLOCK_Y2 = 0;
		SCK = 0;
		MOSI = 0;
		SS = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

