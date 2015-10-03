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
	output wire [`N-1:0] resultado
    );
wire [2*`N-1:0] resumulti,concatenado,resusuma;

concatenar concatenador (
    .entrada(dato3), 
    .salida(concatenado)
    );
	 
multiplicador multi (
    .num1(dato1), 
    .num2(dato2), 
    .result(resumulti)
    );

sumador suma (
    .num1(resumulti), 
    .num2(concatenado), 
    .result(resusuma)
    );

truncamiento trunca (
    .dato(resusuma), 
    .resultado(resultado)
    );

endmodule
