`timescale 1ns / 1ps
`include "constantes.h"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:19:47 09/17/2015 
// Design Name: 
// Module Name:    truncamiento 
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
module truncamiento
	(
	input wire signed [2*`N-1:0] dato,
	output wire signed [`N-1:0]resultado
    );

wire [31:0]aux1,aux0;

assign aux0 = 32'h00000000;
assign aux1 = 32'hffffffff;
assign resultado = (dato[2*`N-1]==0 && dato[2*`N-3:(2*`F)+`M]==0) ? {dato[2*`N-1],dato[(2*`F)+`M-1:`F]}:
					    (dato[2*`N-1]==0 && dato[2*`N-3:(2*`F)+`M]>0) ? {dato[2*`N-1],aux1[(`M+`F)-1:0]}:
						 (dato[2*`N-1]==1 && dato[2*`N-3:(2*`F)+`M]==aux1[`M-1:0]) ? {dato[2*`N-1],dato[(2*`F)+`M-1:`F]}:
					    {dato[2*`N-1],aux0[(`M+`F)-1:0]};

endmodule
