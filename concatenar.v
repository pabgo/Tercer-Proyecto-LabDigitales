`timescale 1ns / 1ps
`include "constantes.h"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:31:04 09/17/2015 
// Design Name: 
// Module Name:    concatenar 
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
module concatenar
(
	input wire signed [`N-1:0] entrada,
	output wire signed [2*`N-1:0] salida
    );
	 
wire [31:0] aux;
wire [31:0] aux1;

assign aux = 32'h00000000;
assign aux1 = 32'hffffffff;	 
assign salida = (entrada[`N-1]==0) ? {2'b00,aux[`M-1:0],entrada[`M+`F-1:0],aux[`F-1:0]}:
					  {2'b11,aux1[`M-1:0],entrada[`M+`F-1:0],aux[`F-1:0]};

endmodule
