`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:05:31 10/14/2015 
// Design Name: 
// Module Name:    Reloj441khz 
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
module Reloj441khz(
    input wire clk,
	 input wire reset,
	 output reg cs
	 );
	 

reg [10:0] cuento; //lo cambie a 11 bits

//Reloj 44,1kHz 
always @(posedge clk,posedge reset) 
begin
	if (reset) 
	begin
		cs <= 0;
		cuento <= 0;
	end 
	else 
	begin		
		if (cuento == 11'd1133) //cambie 2267 por 1133 y le puse 11 bits
		begin                    
			cuento <= 11'h000;      //le puse 11 bits
			cs <= ~cs;  
		end 
		else 
			cuento <= cuento + 1'b1; 
	end
end

endmodule
