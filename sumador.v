`timescale 1ns / 1ps
`include "constantes.h"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:50:11 09/17/2015 
// Design Name: 
// Module Name:    sumador 
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
module sumador
	(
	input wire signed [2*`N-1:0]num1,
	input wire signed [2*`N-1:0]num2,
	output wire signed [2*`N-1:0]result
    );
	 
wire signed [2*`N-1:0]aux;
wire [51:0]aux1,aux2;

assign aux1 = 52'h0000000000000;
assign aux2 = 52'hfffffffffffff;
assign aux = num1 + num2;
assign result = (num1[2*`N-1]==0 && num2[2*`N-1]==0 && aux[2*`N-1]==1) ? {2'b00,aux2[2*`N-3:0]}:
					 (num1[2*`N-1]==1 && num2[2*`N-1]==1 && aux[2*`N-1]==0) ? {2'b11,aux1[2*`N-3:0]}:
					  aux;

endmodule
