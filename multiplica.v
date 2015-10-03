`timescale 1ns / 1ps
`include "constantes.h"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:28:04 09/17/2015 
// Design Name: 
// Module Name:    multiplicador 
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
module multiplicador
	(
		input wire signed [`N-1:0]num1,
		input wire signed [`N-1:0]num2,
		output wire signed [2*`N-1:0] result
    );
	 
	assign result = num1*num2;

endmodule
