`timescale 1ns / 100ps
// (c) 2015, by Coert Vonk
// http://www.coertvonk.com/technology/logic/fpga-spi-slave-in-verilog-13067

// for SPI MODE 3
module spi_slave( input sysClk,      // FPGA system clock (must be several times faster as SCLK, e.g. 66MHz)
                  input usrReset,    // FPGA user reset button
					   input SCLK,        // SPI clock (e.g. 4 MHz)
						input MOSI,        // SPI master out, slave in
						output MISO,       // SPI slave in, master out
						input SS,          // SPI slave select
						output reg LED1 ); // output bit
						
   wire rxValid;
	wire [7:0] rx, tx;

	 // bits <> bytes
   spi_slave_byte byte_if( .sysClk  (sysClk),
									.usrReset(usrReset),
	                        .SCLK    (SCLK),
									.MOSI    (MOSI),
									.MISO    (MISO),
									.SS      (SS),
									.rxValid (rxValid),
									.rx      (rx),
									.tx      (8'h55) );

	// byte received controls an LED
	always @(posedge sysClk)
	   if (rxValid )
		   LED1 <= ( rx == 8'hAA );

endmodule
