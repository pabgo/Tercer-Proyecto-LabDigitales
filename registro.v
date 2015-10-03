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
module registro(
	input wire clk,reset,enable,
	input wire [`N-1:0] D,
	output wire [`N-1:0] Q
 );
 
reg [`N-1:0] Q_actual,Q_next;

always@(posedge clk , posedge reset)
if(reset)
	Q_actual <=`N'b0;
else
	Q_actual<= Q_next;


always @*
if(enable)
	Q_next = D;
else
	Q_next = Q_actual;


assign Q = Q_next;

endmodule
