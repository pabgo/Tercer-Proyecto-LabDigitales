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
module filtronuevopb200(
	input wire clk,datolisto,reset,
	input wire [`N-1:0] uk,
	output wire [`N-1:0] yk,salfk,salfk1,salfk2,salarit,salop1,salop2,salop3,salacum1,
	output wire resulisto,en1,en2,en3,en4,en5,en6,en7
    );

wire enr1,enr2,enr3,enr4,enr5,enr6,enr7;
wire [2:0] selmuxS,selmuxZ;
wire [1:0] selmuxC;
wire [`N-1:0] fk,fk1,fk2,acum,dato1,dato2,dato3,resarit,a1,a2,a3;
	 
// Control
ControlUnidadArit control (
    .clk(clk), 
    .reset(reset), 
    .datolisto(datolisto), 
    .en1(enr1), 
    .en2(enr2), 
    .en3(enr3), 
    .en4(enr4),
	 .en5(enr5), 
    .en6(enr6), 
    .en7(enr7),
    .resultadolisto(resulisto), 
    .muxS(selmuxS), 
    .muxC(selmuxC), 
    .muxZ(selmuxZ)
    );


// Banco de MUX
muxpb200 mux (
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
registro YK (
    .clk(clk), 
    .reset(reset), 
    .enable(enr1), 
    .D(resarit), 
    .Q(acum)
    );

// F(k)
registro FK (
    .clk(clk), 
    .reset(reset), 
    .enable(enr2), 
    .D(resarit), 
    .Q(fk)
    );

// F(k-1)
registro FK1 (
    .clk(clk), 
    .reset(reset), 
    .enable(enr3), 
    .D(fk), 
    .Q(fk1)
    );

// F(k-2)
registro FK2 (
    .clk(clk), 
    .reset(reset), 
    .enable(enr4), 
    .D(fk1), 
    .Q(fk2)
    );

// Acumulador 1
registro acum1 (
    .clk(clk), 
    .reset(reset), 
    .enable(enr5), 
    .D(resarit), 
    .Q(a1)
    );

// Acumulador 2
registro acum2 (
    .clk(clk), 
    .reset(reset), 
    .enable(enr6), 
    .D(resarit), 
    .Q(a2)
    );

// Acumulador 3
registro acum3 (
    .clk(clk), 
    .reset(reset), 
    .enable(enr7), 
    .D(resarit), 
    .Q(a3)
    );

// Unidad Aritmetica
unidadaritmetica aritmetica (
    .dato1(dato1), 
    .dato2(dato2), 
    .dato3(dato3), 
    .resultado(resarit)
    );

assign yk = acum;
assign salfk = fk;
assign salfk1 = fk1;
assign salfk2 = fk2;
assign en1 = enr1;
assign en2 = enr2;
assign en3 = enr3;
assign en4 = enr4;
assign en5 = enr5;
assign en6 = enr6;
assign en7 = enr7;
assign salarit = resarit;
assign salop1 = dato1;
assign salop2 = dato2;
assign salop3 = dato3;
assign salacum1 = a1;
//assign salacum2 = a2;

endmodule
