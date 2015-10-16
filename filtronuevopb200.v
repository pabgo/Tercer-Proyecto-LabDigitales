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
	output wire [`N-1:0] yk,
	output wire reslisto
    );

wire enr1,enr2,enr3,enr4,enr5,enr6,enr7,resulisto;
wire [2:0] selmuxSpb,selmuxZpb;
wire [1:0] selmuxCpb;
wire [`N-1:0] fkpb,fk1pb,fk2pb,acumpb,dato1pb,dato2pb,dato3pb,resaritpb,a1pb,a2pb,a3pb;
	 
// Control pasa bajas
ControlUnidadArit contropb (
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
    .resultadolisto(reslisto), 
    .muxS(selmuxSpb), 
    .muxC(selmuxCpb), 
    .muxZ(selmuxZpb)
    );

// Banco de MUXpb
muxpb200 muxpb (
    .controlS(selmuxSpb), 
    .controlC(selmuxCpb), 
    .controlZ(selmuxZpb), 
    .fk(fkpb), 
    .fk1(fk1pb), 
    .fk2(fk2pb), 
    .yk(acumpb), 
    .Uk(uk), 
	 .acum1(a1pb), 
    .acum2(a2pb), 
    .acum3(a3pb), 
    .muxS(dato1pb), 
    .muxC(dato2pb), 
    .muxZ(dato3pb)
    );

// Y(k)
registro YKpb (
    .clk(clk), 
    .reset(reset), 
    .enable(enr1), 
    .D(resaritpb), 
    .Q(acumpb)
    );

// F(k)
registro FKpb (
    .clk(clk), 
    .reset(reset), 
    .enable(enr2), 
    .D(resaritpb), 
    .Q(fkpb)
    );

// F(k-1)
registro FK1pb (
    .clk(clk), 
    .reset(reset), 
    .enable(enr3), 
    .D(fkpb), 
    .Q(fk1pb)
    );

// F(k-2)
registro FK2pb (
    .clk(clk), 
    .reset(reset), 
    .enable(enr4), 
    .D(fk1pb), 
    .Q(fk2pb)
    );

// Acumulador 1
registro acum1pb (
    .clk(clk), 
    .reset(reset), 
    .enable(enr5), 
    .D(resaritpb), 
    .Q(a1pb)
    );

// Acumulador 2
registro acum2pb (
    .clk(clk), 
    .reset(reset), 
    .enable(enr6), 
    .D(resaritpb), 
    .Q(a2pb)
    );

// Acumulador 3
registro acum3pb (
    .clk(clk), 
    .reset(reset), 
    .enable(enr7), 
    .D(resaritpb), 
    .Q(a3pb)
    );

// Unidad Aritmetica
unidadaritmetica aritmeticapb (
    .dato1(dato1pb), 
    .dato2(dato2pb), 
    .dato3(dato3pb), 
    .resultado(resaritpb)
    );
	 
assign yk = acumpb;

endmodule
