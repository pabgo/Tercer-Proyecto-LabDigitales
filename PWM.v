`timescale 1ns / 1ps
`include "constantes.h"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:19:11 09/22/2015 
// Design Name: 
// Module Name:    PWM 
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
module PWM(
	input wire clk,
	input wire [`N-1:0] entrada,
	output reg salida
    );
reg [15:0] contador;	
wire [15:0] redondeo;

assign redondeo = entrada[`F+4:`F-11];
	 
always @(posedge clk)
begin
		if(contador < redondeo)
				salida <= 1'b1;
		else
				salida <= 1'b0;
		if(contador < 16'd65535)
			contador = contador+1'b1;
		else
			contador = 16'h0000;
end

endmodule
