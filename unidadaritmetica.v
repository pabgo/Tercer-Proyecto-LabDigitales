`timescale 1ns / 1ps
`include "constantes.h"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:54:12 09/27/2015 
// Design Name: 
// Module Name:    unidadaritmetica 
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
module unidadaritmetica(
	input wire [`N-1:0] dato1,dato2,dato3,
	input wire clk, reset,
	output wire [`N-1:0] resultado
    );
wire [2*`N-1:0] resumulti,concatenado,resusuma,q4,q5,q6;
wire [`N-1:0] q1,q2,q3,saltrunca;

concatenar concatenador (
    .entrada(q3), 
    .salida(concatenado)
    );
	 
multiplicador multi (
    .num1(q1), 
    .num2(q2), 
    .result(resumulti)
    );

sumador suma (
    .num1(q4), 
    .num2(q5), 
    .result(resusuma)
    );

truncamiento trunca (
    .dato(q6), 
    .resultado(saltrunca)
    );

registroaux bloque1 (
    .clk(clk), 
    .reset(reset), 
    .D(dato1), 
    .Q(q1)
    );
	 
registroaux bloque2 (
    .clk(clk), 
    .reset(reset), 
    .D(dato2), 
    .Q(q2)
    );
	 
registroaux bloque3 (
    .clk(clk), 
    .reset(reset), 
    .D(dato3), 
    .Q(q3)
    );

registroespecial bloque4 (
    .clk(clk), 
    .reset(reset), 
    .D(concatenado), 
    .Q(q4)
    );

registroespecial bloque5 (
    .clk(clk), 
    .reset(reset), 
    .D(resumulti), 
    .Q(q5)
    );
	 
registroespecial bloque6 (
    .clk(clk), 
    .reset(reset), 
    .D(resusuma), 
    .Q(q6)
    );


registroaux bloque7 (
    .clk(clk), 
    .reset(reset), 
    .D(saltrunca), 
    .Q(resultado)
    );

endmodule
