`timescale 1ns / 100ps
// (c) 2015, by Coert Vonk
// http://www.coertvonk.com/technology/logic/fpga-spi-slave-in-verilog-13067

// for SPI MODE 3
module spi_slave_byte( input sysClk,
                       input usrReset,
					        input SCLK,           // SPI clock
						     input MOSI,           // SPI master out, slave in
						     output MISO,          // SPI slave in, master out
						     input SS,             // SPI slave select
							  output rxValid,       // BYTE received is valid
						     output reg [7:0] rx,  // BYTE received
						     input [7:0] tx );     // BYTE to transmit

   // synchronize SCLK to FPGA domain clock using a two-stage shift-register
	// (bit [0] takes the hit of timing errors)
	reg [2:0] SCLKr;  always @(posedge sysClk) SCLKr <= { SCLKr[1:0], SCLK };
	reg [2:0] SSr;  always @(posedge sysClk) SSr <= { SSr[1:0], SS };
	reg [1:0] MOSIr;  always @(posedge sysClk) MOSIr <= { MOSIr[0], MOSI };
	wire SCLK_rising  = ( SCLKr[2:1] == 2'b01 );
	wire SCLK_falling = ( SCLKr[2:1] == 2'b10 );
	wire SS_rising  = ( SSr[2:1] == 2'b01 );
	wire SS_falling = ( SSr[2:1] == 2'b10 );
	wire SS_active  = ~SSr[1];  // synchronous version of ~SS input
	wire MOSI_s = MOSIr[1];     // synchronous version of MOSI input

	reg [2:0] state;  // state corresponds to bit count
   reg MISOr = 1'bx;
   reg [7:0] data;
   reg rxAvail = 1'b0;

   // next state logic

   wire [7:0] rx_next = {data[6:0], MOSI_s};
	
	// current state logic

	always @(posedge sysClk or posedge usrReset)
		if( usrReset )
			state <= 3'd0;
		else
			if ( SS_active )
				begin
					if ( SS_falling )  // begin of message
						state <= 3'd0;
					if ( SCLK_rising )  // bit available
						state <= state + 3'd1;
				end
			
	// output logic

	always @(posedge sysClk or posedge usrReset)
		if( usrReset )
			begin
				rx <= 8'hxx;
				rxAvail <= 1'b0;
			end
		else
			if ( SS_active )
				begin

					if ( SS_falling )  // begin of message
						rxAvail <= 1'b0;

					if ( SCLK_rising )  // input on rising PCI clock edge
						if ( state == 3'd7 ) 
							begin
								rx <= rx_next;
								rxAvail <= 1'b1;
							end
						else
							begin
								data <= rx_next;
								rxAvail <= 1'b0;
							end

					if ( SCLK_falling)  // output on falling PCI clock edge
						if ( state == 3'b000 )
							begin 
								data <= tx;
								MISOr <= tx[7];
							end
						else
							MISOr <= data[7];
				end

   assign MISO = SS_active ? MISOr : 1'bz;  // send MSB first
   // make rxAvail change on the falling edge, and make it 1 cycle wide
	reg rxAvailFall;
	reg rxAvailFall_dly;
	always @(negedge sysClk) rxAvailFall <= rxAvail;
	always @(negedge sysClk) rxAvailFall_dly <= rxAvailFall;
	assign rxValid = rxAvailFall & ~rxAvailFall_dly;

endmodule