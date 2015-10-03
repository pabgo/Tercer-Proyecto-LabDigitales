`timescale 1ns / 1ps
`include "constantes.h"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:35:54 10/01/2015 
// Design Name: 
// Module Name:    filtropb200 
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
module filtropb5000(
	input wire [`N-1:0] UK,
	input wire clk,reset,en1,en2,en3,en4,
	input wire [2:0] muxS,
	input wire [1:0] muxC, muxZ,
	output wire [`N-1:0] YK
    );

wire [`N-1:0] dato1,dato2,dato3,resul,aux_fk,aux_fk1,aux_fk2;
wire [`N-1:0]  aux_yk;

// Banco de MUX
muxpb5000 banco_mux (
    .controlS(muxS), 
    .controlC(muxC), 
    .controlZ(muxZ), 
    .fk(aux_fk), 
    .fk1(aux_fk1), 
    .fk2(aux_fk2), 
    .yk(aux_yk), 
    .Uk(UK), 
    .muxS(dato1), 
    .muxC(dato2), 
    .muxZ(dato3)
    );

// Registro Y(K)
registro salida (
    .clk(clk), 
    .reset(reset), 
    .enable(en1), 
    .D(resul), 
    .Q(aux_yk)
    );
	 
// Registro F(K)
registro FK (
    .clk(clk), 
    .reset(reset), 
    .enable(en2), 
    .D(resul), 
    .Q(aux_fk)
    );
	 
// Registro F(K-1)
registro FK_1 (
    .clk(clk), 
    .reset(reset), 
    .enable(en3), 
    .D(aux_fk), 
    .Q(aux_fk1)
    );
	 
// Registro F(K-2)
registro FK_2 (
    .clk(clk), 
    .reset(reset), 
    .enable(en4), 
    .D(aux_fk1), 
    .Q(aux_fk2)
    );
	 
// Unidad Aritmetica
unidadaritmetica aritmetica (
    .dato1(dato1), 
    .dato2(dato2), 
    .dato3(dato3), 
    .resultado(resul)
    );
	 

assign YK = aux_yk;

endmodule
