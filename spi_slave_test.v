`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:19:57 10/04/2015
// Design Name:   spi_slave
// Module Name:   C:/Users/Coert/Desktop/test/spi_slave/spi_slave_test.v
// Project Name:  spi_slave
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: spi_slave
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module spi_slave_test;

	// Outputs
	wire ;

	// Instantiate the Unit Under Test (UUT)
	spi_slave uut (
		.()
	);

	initial begin
		// Initialize Inputs

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

`timescale 1ns/10ps

module tbslave;
    reg rstb = 1'b0;
    reg ten = 1'b0;
    reg [7:0] tdata = 8'b00000000;
    reg mlb = 1'b0;
    reg ss = 1'b0;
    reg sck = 1'b0;
    reg sdin = 1'b0;
    wire sdout;
    wire done;
    wire [7:0] rdata;


    SPI_slave UUT (
        .rstb(rstb),
        .ten(ten),
        .tdata(tdata),
        .mlb(mlb),
        .ss(ss),
        .sck(sck),
        .sdin(sdin),
        .sdout(sdout),
        .done(done),
        .rdata(rdata));

    initial begin
        // -------------  Current Time:  100ns
        #100;
        ss = 1'b1;
        sck = 1'b1;
        sdin = 1'b1;
        // -------------------------------------
        // -------------  Current Time:  120ns
        #20;
        rstb = 1'b1;
        // -------------------------------------
        // -------------  Current Time:  140ns
        #20;
        ten = 1'b1;
        mlb = 1'b1;
        tdata = 8'b01111100;
        // -------------------------------------
        // -------------  Current Time:  160ns
        #20;
        ss = 1'b0;
        // -------------------------------------
        // -------------  Current Time:  180ns
        #20;
        sck = 1'b0;
        sdin = 1'b0;
        // -------------------------------------
        // -------------  Current Time:  200ns
        #20;
        sck = 1'b1;
        // -------------------------------------
        // -------------  Current Time:  220ns
        #20;
        sck = 1'b0;
        sdin = 1'b1;
        // -------------------------------------
        // -------------  Current Time:  240ns
        #20;
        sck = 1'b1;
        // -------------------------------------
        // -------------  Current Time:  260ns
        #20;
        sck = 1'b0;
        sdin = 1'b0;
        // -------------------------------------
        // -------------  Current Time:  280ns
        #20;
        sck = 1'b1;
        // -------------------------------------
        // -------------  Current Time:  300ns
        #20;
        sck = 1'b0;
        sdin = 1'b1;
        // -------------------------------------
        // -------------  Current Time:  320ns
        #20;
        sck = 1'b1;
        // -------------------------------------
        // -------------  Current Time:  340ns
        #20;
        sck = 1'b0;
        sdin = 1'b0;
        // -------------------------------------
        // -------------  Current Time:  360ns
        #20;
        sck = 1'b1;
        // -------------------------------------
        // -------------  Current Time:  380ns
        #20;
        sck = 1'b0;
        sdin = 1'b1;
        // -------------------------------------
        // -------------  Current Time:  400ns
        #20;
        sck = 1'b1;
        // -------------------------------------
        // -------------  Current Time:  420ns
        #20;
        sck = 1'b0;
        sdin = 1'b0;
        // -------------------------------------
        // -------------  Current Time:  440ns
        #20;
        sck = 1'b1;
        // -------------------------------------
        // -------------  Current Time:  460ns
        #20;
        sck = 1'b0;
        sdin = 1'b1;
        // -------------------------------------
        // -------------  Current Time:  480ns
        #20;
        sck = 1'b1;
        // -------------------------------------
        // -------------  Current Time:  500ns
        #20;
        ss = 1'b1;
        // -------------------------------------
        // -------------  Current Time:  520ns
        #20;
        ten = 1'b0;

		
		#200  ten = 1'b1;        mlb = 1'b0;         tdata = 8'b01110000;
        #20        ss = 1'b0;
        #20       sck = 1'b0;
        sdin = 1'b0;
        #20        sck = 1'b1;
        #20        sck = 1'b0;
        sdin = 1'b1;
        #20        sck = 1'b1;

        #20        sck = 1'b0;
        sdin = 1'b0;
        #20        sck = 1'b1;
        #20        sck = 1'b0;
        sdin = 1'b1;
        #20        sck = 1'b1;
        #20        sck = 1'b0;
        sdin = 1'b0;
        #20        sck = 1'b1;
        #20        sck = 1'b0;
        sdin = 1'b1;
        #20        sck = 1'b1;
        #20        sck = 1'b0;
        sdin = 1'b0;
        #20        sck = 1'b1;
        #20        sck = 1'b0;
        sdin = 1'b1;
        #20        sck = 1'b1;
        #20         ss = 1'b1;
        #20         ten = 1'b0;
		#100;

	end

endmodule



	end
      
endmodule

