`timescale 1ns / 1ps

module spi_slave_tb  // MODE_3

	// Inputs
	reg clk;
	reg SCK;
	reg MOSI;
	reg SS;

	// Outputs
	wire MISO;
	wire LED1;

   localparam T = 250;  // clock period (1/f)

   reg [7:0] misoData;
	reg [7:0] mosiData;
   reg [3:0] jj;
	reg [7:0] ii;

	SPI_slave uut (  // instantiate the Unit Under Test (UUT)
		.CLOCK_Y2 ( clk  ), 
		.SCK      ( SCK  ), 
		.MOSI     ( MOSI ), 
		.MISO     ( MISO ), 
		.SS       ( SS   ), 
		.LED1     ( LED1 )
	);

	initial begin
		clk = 1'b0;  // initialize Inputs
		SCK = 1'b1;
		MOSI = 1'bz;
		SS = 1'b1;

		#100;  // wait 100 ns for global reset to finish

		#300 SS = 1'b0;  // activate slave-select

	   for (ii = 0; ii < 5; ii = ii + 1 ) begin
         mosiData = ii;
			
		   $display("jj=%d", ii);
			for (jj = 0; jj < 8; jj = jj + 1 ) begin
			
				// data is driven on the falling edge
				#(T/2) SCK = 1'b0; MOSI = mosiData[7 - jj];  
				
				// data is sampled on the rising edge
				#(T/2) SCK = 1'b1; misoData = { misoData[6:0], MISO };
				$display (" received %b", misoData );
			end
			misoData = 8'bxxxxxxxx;
			if ( misoData != ii ) $display("S>M send %b, but received %b", ii, misoData);
      end;

		#10 SS = 1'b1;   // de-activate slave-select
		MOSI = 1'bz;
		
		#100 $finish;
   end

   always 
	   forever 
		   #8 clk = ~clk;  // generate 62.5 MHz system clock 
        
endmodule

