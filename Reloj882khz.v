`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:05:52 10/14/2015 
// Design Name: 
// Module Name:    Reloj882khz 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Reloj882khz(
    input wire clk,
	 input wire reset,
	 output reg sclk
	 );


reg [5:0] cuenta; //lo cambie a 6 bits

//Reloj de 882kHz 
always @(posedge clk,posedge reset) 
begin
	if (reset) 
	begin
		sclk <= 0;
		cuenta <= 0;
	end 
	else 
	begin		
		if (cuenta == 6'd55) //cambie 113 por 55 y le puse 6 bits = 893 khz
		begin                    
			cuenta <= 6'h0;   //le puse 6 bits
			sclk <= ~sclk;  
		end 
		else 
			cuenta <= cuenta + 1'b1; 
	end
end

endmodule
