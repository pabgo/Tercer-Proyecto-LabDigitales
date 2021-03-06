`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:21:49 08/09/2015 
// Design Name: 
// Module Name:    Divisor_de_frecuencia 
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
module Divisor_de_frecuencia( //44.1 kHz
	input wire clk,       //Se�al de entrada, referente a comportamiento de reloj.
	input wire reset,     //Reset de se�al.
	output reg s_clk      //Se�al de salida del divisor, se�al ya dividida.
    );
	 
// El codigo de este m�dulo corresponde a dividir la frecuencia de entrada en 5 veces, ejemplo: 100Mhz => 20Mhz.
//
//  ** 
//     Si se desea dividir en otra cantidad, por ejemplo: en 354, primero se saca la base 2 de ese numero
//		 para poder obtener la cantidad del largo del bus datos referente a la salida del contador
//		 log2(354) = 8.4676 => por lo que se toma el numero entero posterior al resultado, osea 9
//     Por lo que las siguientes lineas de c�digo tendria se cambiar�an por lo siguiente:
//
//     linea  |  Cambio
//     -------+----------------------------
//		  43    |    reg [8:0] cuenta;
//	 	  55    |    if (cuenta == 9'd353)
//   	  58    |    cuenta <= 9'h0;
//
//  **

reg [11:0] cuenta; //Bus de datos de 3 bits referente al contador
					   //para una unidad decimal maxima de 8 (2^3 = 8) suficiente para la cuenta de 5.
 
always @(posedge clk,posedge reset) //Se procede a realizar el codigo posterior siempre que "clk" o "reset" est�n en alto.
	begin
		if (reset) //Si "reset" est� en alto, se pone la salida "s_clk" en 0 y se resetea la cuenta.
			begin
				s_clk <= 0;
				cuenta <= 0;
			end 
		else //Se est� en alto la se�al de "clk" pero no la de "reset" se procede a realizar lo siguiente.
			begin		
				if (cuenta == 12'd2267)//(5)-1 = 4, Si el contador llega a la cuenta 5:   
					//Por si las dudas => "3'd4"(notaci�n decimal) es igual a "3'b100"(notaci�n binaria). 
					begin                    
						cuenta <= 12'h0;  //Se resetea la cuenta poniendola en cero   
						s_clk <= ~s_clk;  //
					end 
				else 
					cuenta <= cuenta + 1'b1; //De no ser el valor a dividir, el contador seguir� contando (valga la redundancia)
			end
	end
 
endmodule

