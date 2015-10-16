`timescale 1ns / 1ps
`include "constantes.h"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:22:27 10/14/2015 
// Design Name: 
// Module Name:    Seleccionador 
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
module Seleccionador(
	input wire [`N-1:0] yk1,yk2,yk3,
	input wire sw1,sw2,sw3,
	output wire [`N-1:0] result
    );

wire [`N-1:0] data1,data2,data3;
wire [31:0]auxi;
assign auxi = 32'h00000000;

assign data1 = (sw1 == 1'b0) ? auxi[`N-1:0] :
					 yk1;
assign data2 = (sw2 == 1'b0) ? auxi[`N-1:0] :
					 yk2;
assign data3 = (sw3 == 1'b0) ? auxi[`N-1:0] :
					 yk3;
					 
assign result = data1+data2+data3;					 
					
endmodule
