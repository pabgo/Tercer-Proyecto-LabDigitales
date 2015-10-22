`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////
module PWM(
	input wire clk_in,						//clock for counter
	input wire [10:0] Dato, 				//control value that
										//defines pulse width
	output reg PWM_out );		//PWM signal out

	reg [10:0] counter = 0;
	
	always@ (posedge clk_in)
		begin
			if (counter < Dato)
				PWM_out <= 1;
			else
				PWM_out <= 0;
		counter <= counter+11'b1;
		end
endmodule
