`timescale 1ns / 1ps
`include "constantes.h"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:47:13 09/27/2015 
// Design Name: 
// Module Name:    registro 
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
module registroaux(
	input wire clk,reset,
	input wire [`N-1:0] D,
	output reg [`N-1:0] Q
 );

always@(posedge clk,posedge reset)
if(reset)
	Q <= 0;
else
	Q <= D;



endmodule
