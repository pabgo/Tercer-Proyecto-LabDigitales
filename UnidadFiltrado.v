`timescale 1ns / 1ps
`include "constantes.h"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:27:03 10/06/2015 
// Design Name: 
// Module Name:    UnidadFiltrado 
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
module UnidadFiltrado(
	input wire clk,reset,datolisto,
	input wire [`N-1:0] uk,
	output wire [`N-1:0] yk1,yk2,yk3,
	output wire resultlisto
    );

wire nextop,enb1,enb2,enb3,enb4,enb5,enb6,enb7,ena1,ena2,ena3,ena4,ena5,ena6,ena7;
wire [2:0] muxbS,muxbZ,muxaS,muxaZ;
wire [1:0] muxbC,muxaC;
wire [`N-1:0] aux1,aux2,aux3;

// Filtro Paso Altas 20Hz
filtropa20 FiltroPasaAlta20Hz (
    .clk(clk), 
    .reset(reset), 
    .en1(ena1), 
    .en2(ena2), 
    .en3(ena3), 
    .en4(ena4), 
    .en5(ena5), 
    .en6(ena6), 
    .en7(ena7), 
    .selmuxS(muxaS), 
    .selmuxZ(muxaZ), 
    .selmuxC(muxaC), 
    .uk(uk), 
    .yk(aux1)
    );

// Filtro Pasa Alta 200Hz
filtropa200 FiltroPasaAlta200Hz (
    .clk(clk), 
    .reset(reset), 
    .en1(ena1), 
    .en2(ena2), 
    .en3(ena3), 
    .en4(ena4), 
    .en5(ena5), 
    .en6(ena6), 
    .en7(ena7), 
    .selmuxS(muxaS), 
    .selmuxZ(muxaZ), 
    .selmuxC(muxaC), 
    .uk(uk), 
    .yk(aux2)
    );
	 
// Filtro Pasa Altas 5KHz
filtropa5000 FiltroPasaAlta5KHz (
    .clk(clk), 
    .reset(reset), 
    .en1(ena1), 
    .en2(ena2), 
    .en3(ena3), 
    .en4(ena4), 
    .en5(ena5), 
    .en6(ena6), 
    .en7(ena7), 
    .selmuxS(muxaS), 
    .selmuxZ(muxaZ), 
    .selmuxC(muxaC), 
    .uk(uk), 
    .yk(aux3)
    );
	 
// Filtro Pasa Bajas 200Hz
filtropb200 FiltroPasaBaja200Hz (
    .clk(clk), 
    .reset(reset), 
    .en1(enb1), 
    .en2(enb2), 
    .en3(enb3), 
    .en4(enb4), 
    .en5(enb5), 
    .en6(enb6), 
    .en7(enb7), 
    .selmuxS(muxbS), 
    .selmuxZ(muxbZ), 
    .selmuxC(muxbC), 
    .uk(aux1), 
    .yk(yk1)
    );

// Filtro Pasa Bajas 20KHz
filtropb20000 FiltroPasaBaja20KHz (
    .clk(clk), 
    .reset(reset), 
    .en1(enb1), 
    .en2(enb2), 
    .en3(enb3), 
    .en4(enb4), 
    .en5(enb5), 
    .en6(enb6), 
    .en7(enb7), 
    .selmuxS(muxbS), 
    .selmuxZ(muxbZ), 
    .selmuxC(muxbC), 
    .uk(aux3), 
    .yk(yk3)
    );
	 
// Filtro Pasa Bajas 5KHz
filtropb5000 FiltroPasaBaja5KHz (
    .clk(clk), 
    .reset(reset), 
    .en1(enb1), 
    .en2(enb2), 
    .en3(enb3), 
    .en4(enb4), 
    .en5(enb5), 
    .en6(enb6), 
    .en7(enb7), 
    .selmuxS(muxbS), 
    .selmuxZ(muxbZ), 
    .selmuxC(muxbC), 
    .uk(aux2), 
    .yk(yk2)
    );

// Control Filtros Paso Bajos
ControlUnidadArit ControlPB (
    .clk(clk), 
    .reset(reset), 
    .datolisto(nextop), 
    .en1(enb1), 
    .en2(enb2), 
    .en3(enb3), 
    .en4(enb4), 
    .en5(enb5), 
    .en6(enb6), 
    .en7(enb7), 
    .resultadolisto(resultlisto), 
    .muxS(muxbS), 
    .muxZ(muxbZ), 
    .muxC(muxbC)
    );

// Control Filtros Paso Altos
ControlUnidadArit ControlPA (
    .clk(clk), 
    .reset(reset), 
    .datolisto(datolisto), 
    .en1(ena1), 
    .en2(ena2), 
    .en3(ena3), 
    .en4(ena4), 
    .en5(ena5), 
    .en6(ena6), 
    .en7(ena7), 
    .resultadolisto(nextop), 
    .muxS(muxaS), 
    .muxZ(muxaZ), 
    .muxC(muxaC)
    );
	 
endmodule
