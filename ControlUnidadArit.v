`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Instituto Tecnologico de Costa Rica
// Engineer: Rolen Coto Calderón
//			    Josué Guillén Meza
// 			 Pablo Gómez RamíRez
// Create Date:    20:59:01 09/30/2015 
// Design Name: 
// Module Name:    ControlUnidadArit 
// Project Name: 	 Ecualizador de Audio
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
module ControlUnidadArit
(
	input wire clk,reset, //	Clock y reset
	input wire datolisto,// Banderas de entrada
	output reg en1,en2,en3,en4,en5,en6,en7,resultadolisto,// enables de 1:y(k), 2:f(k), 3:f(k-1), 4:f(k-2)
	output reg [2:0] muxS, muxZ,//Mux de constantes
	output reg [1:0] muxC //Muxs de valores de f y de valores de u(k),y(k) respectivamente
);
//*********************************************************

localparam [2:0] // Codificación de los estados o etiquetas
	espera = 3'b000,
	oper1 = 3'b001,
	oper2 = 3'b010,
	oper3 = 3'b011,
	oper4 = 3'b100,
	oper5 = 3'b101,
	result = 3'b110;

reg [2:0] estadoactual, estadosig; // Reg, estado actual y siguiente

//*********************************************************

//Parte Secuencial

always@(posedge clk, posedge reset)
begin
	if(reset)
		estadoactual <= espera;
	else
		estadoactual <= estadosig;
end

//*********************************************************

//Parte Combinacional
always@*
begin
	estadosig = estadoactual;
	en1 = 0;
	en2 = 0;
	en3 = 0;
	en4 = 0;
	en5 = 0;
	en6 = 0;
	en7 = 0;
	muxS = 3'b000;
	muxC = 2'b00;
	muxZ = 3'b000;
	resultadolisto = 0;

	case(estadoactual)
		espera:
			if(datolisto)
				estadosig = oper1; 
		
		oper1:
			begin
			muxS = 3'b001;
			muxC = 2'b01;
			muxZ = 3'b001;
			en5 = 1;
			estadosig = oper2;
			end

		oper2:
			begin
			muxS = 3'b010;
			muxC = 2'b10;
			muxZ = 3'b011;
			en2 = 1;
			estadosig = oper3;
			end
			
		oper3:
			begin
			muxS = 3'b011;
			muxC = 2'b11;
			muxZ = 3'b000;
			en6 = 1;
			estadosig = oper4;
			end
			
		oper4:
			begin
			muxS = 3'b100;
			muxC = 2'b01;
			muxZ = 3'b100;
			en7 = 1;
			estadosig = oper5;
			end
			
		oper5:
			begin
			muxS = 3'b101;
			muxC = 2'b10;
			muxZ = 3'b101;
			en1 = 1;

			en4 = 1;
			estadosig = result;
			end
			
		result:
			begin
			estadosig = espera;
			resultadolisto = 1;
			en3 = 1;
			end
			 
		default: 
			estadosig = espera;
			
	endcase
end

endmodule


