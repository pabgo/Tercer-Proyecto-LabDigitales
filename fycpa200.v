`timescale 1ns / 1ps
`include "constantes.h"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:51:36 10/02/2015 
// Design Name: 
// Module Name:    fycpa200 
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
module fycpa200(
	input wire clk,datolisto,reset,
	input wire [`N-1:0] UK,
	output wire [`N-1:0] yk,
	output wire resultadolisto
    );

wire en1,en2,en3,en4;
wire [2:0] muxS;
wire [1:0] muxC,muxZ;

//Control
ControlUnidadArit control (
    .clk(clk), 
    .reset(reset), 
    .datolisto(datolisto), 
    .en1(en1), 
    .en2(en2), 
    .en3(en3), 
    .en4(en4), 
    .resultadolisto(resultadolisto), 
    .muxS(muxS), 
    .muxC(muxC), 
    .muxZ(muxZ)
    );

// Filtro
filtropa200 filtro (
    .UK(UK), 
    .clk(clk), 
    .reset(reset), 
    .en1(en1), 
    .en2(en2), 
    .en3(en3), 
    .en4(en4), 
    .muxS(muxS), 
    .muxC(muxC), 
    .muxZ(muxZ), 
    .YK(yk)
    );


endmodule
