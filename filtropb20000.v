`timescale 1ns / 1ps
`include "constantes.h"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:58:34 10/03/2015 
// Design Name: 
// Module Name:    filtronuevopb200 
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
module filtropb20000(
	input wire clk,reset,en1,en2,en3,en4,en5,en6,en7,
	input wire [2:0] selmuxS,selmuxZ,
	input wire [1:0] selmuxC,
	input wire [`N-1:0] uk,
	output wire [`N-1:0] yk
    );

wire [`N-1:0] fk,fk1,fk2,acum,dato1,dato2,dato3,resarit,a1,a2,a3;

// Banco de MUX
muxpb20000 mux5 (
    .controlS(selmuxS), 
    .controlC(selmuxC), 
    .controlZ(selmuxZ), 
    .fk(fk), 
    .fk1(fk1), 
    .fk2(fk2), 
    .yk(acum), 
    .Uk(uk), 
	 .acum1(a1), 
    .acum2(a2), 
    .acum3(a3), 
    .muxS(dato1), 
    .muxC(dato2), 
    .muxZ(dato3)
    );

// Y(k)
registro YKpb20k (
    .clk(clk), 
    .reset(reset), 
    .enable(en1), 
    .D(resarit), 
    .Q(acum)
    );

// F(k)
registro FKpb20k (
    .clk(clk), 
    .reset(reset), 
    .enable(en2), 
    .D(resarit), 
    .Q(fk)
    );

// F(k-1)
registro FK1pb20k (
    .clk(clk), 
    .reset(reset), 
    .enable(en3), 
    .D(fk), 
    .Q(fk1)
    );

// F(k-2)
registro FK2pb20k (
    .clk(clk), 
    .reset(reset), 
    .enable(en4), 
    .D(fk1), 
    .Q(fk2)
    );

// Acumulador 1
registro acum1pb20k (
    .clk(clk), 
    .reset(reset), 
    .enable(en5), 
    .D(resarit), 
    .Q(a1)
    );

// Acumulador 2
registro acum2pb20k (
    .clk(clk), 
    .reset(reset), 
    .enable(en6), 
    .D(resarit), 
    .Q(a2)
    );

// Acumulador 3
registro acum3pb20k (
    .clk(clk), 
    .reset(reset), 
    .enable(en7), 
    .D(resarit), 
    .Q(a3)
    );

// Instantiate the module
unidadaritmetica aritpb20k (
    .dato1(dato1), 
    .dato2(dato2), 
    .dato3(dato3), 
    .clk(clk), 
    .reset(reset), 
    .resultado(resarit)
    );

assign yk = acum;

endmodule
