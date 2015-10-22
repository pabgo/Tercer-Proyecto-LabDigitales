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

localparam [4:0] // Codificación de los estados o etiquetas
	espera = 5'b00000,
	oper1 = 5'b00001,
	wait11 = 5'b00010,
	wait12 = 5'b00011,
	wait13 = 5'b00100,
	wait14 = 5'b00101,
	oper2 = 5'b00110,
	wait21 = 5'b00111,
	wait22 = 5'b01000,
	wait23 = 5'b01001,
	wait24 = 5'b01010,
	oper3 = 5'b01011,
	wait31 = 5'b01100,
	wait32 = 5'b01101,
	wait33 = 5'b01110,
	wait34 = 5'b01111,
	oper4 = 5'b10000,
	wait41 = 5'b10001,
	wait42 = 5'b10010,
	wait43 = 5'b10011,
	wait44 = 5'b10100,
	oper5 = 5'b10101,
	wait51 = 5'b10110,
	wait52 = 5'b10111,
	wait53 = 5'b11000,
	wait54 = 5'b11001,
	oper6 = 5'b11010,
	result = 5'b11011;

reg [4:0] estadoactual, estadosig; // Reg, estado actual y siguiente

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
		estadosig = wait11;			
		end				
		
		wait11:
		estadosig = wait12;
		
		wait12:
		estadosig = wait13;
		
		wait13:
		estadosig = wait14;
		
		wait14:
		begin
		en5 = 1;
		estadosig = oper2;
		end
	
		oper2:
		begin
		muxS = 3'b010;
		muxC = 2'b10;
		muxZ = 3'b011;
		estadosig = wait21;
		end
			
		wait21:
		estadosig = wait22;

		wait22:
		estadosig = wait23;	

		wait23:
		estadosig = wait24;
		
		wait24:
		begin
		en2 = 1;
		estadosig = oper3;
		end
	
		oper3:
		begin
		muxS = 3'b011;
		muxC = 2'b11;
		muxZ = 3'b000;
		estadosig = wait31;
		end
	
		wait31:
		estadosig = wait32;

		wait32:
		estadosig = wait33;
		
		wait33:
		estadosig = wait34;
		
		wait34:
		begin
		en6 = 1;
		estadosig = oper4;
		end
		
		oper4:
		begin
		muxS = 3'b100;
		muxC = 2'b01;
		muxZ = 3'b100;
		estadosig = wait41;
		end	
		
		wait41:
		estadosig = wait42;
		
		wait42:
		estadosig = wait43;
			
		wait43:
		estadosig = wait44;
		
		wait44:
		begin
		en7 = 1;
		estadosig = oper5;
		end
			
		oper5:
		begin
		muxS = 3'b101;
		muxC = 2'b10;
		muxZ = 3'b101;
		estadosig = wait51;
		end	
		
		wait51:
		estadosig = wait52;
		
		wait52:
		estadosig = wait53;
			
		wait53:	
		estadosig = wait54;
		
		wait54:
		begin
		en1 = 1;		
		estadosig = oper6;
		end

		oper6:
			begin
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

