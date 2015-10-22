`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    
// Design Name: 
// Module Name:    Divisores_Frecuencia 
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
module Divisores_Frecuencias(
	input wire MasterClk,       //Señal de entrada, referente a comportamiento de reloj.
	input wire reset,     //Reset de señal.
	output reg SClk,Divisor50,CS    //Señales de salida del divisor, señales ya divididas.
    );

reg [3:0] Scuenta; //Contadores
reg [9:0] Ccuenta;
					   
 always @(posedge MasterClk, posedge reset) 
	begin
		if (reset)
			begin
				SClk <= 0;
				Scuenta <= 0;
			end 
		else 
			begin		
				if (Scuenta == 4'd15)
					begin                    
						Scuenta <= 5'd0;    
						SClk <= ~SClk;  //
					end 
				else 
					Scuenta <= Scuenta + 1'b1; 
			end
	end
 
 always @(posedge MasterClk,  posedge reset) 
 begin
		if (reset) 
			begin
				CS <= 0;
				Ccuenta <= 0;
			end 
		
		else 
			begin		
				if (Ccuenta == 10'd1023)    
					begin                    
						Ccuenta <= 10'd0;    
						CS <= ~CS;
					end 
				else 
					Ccuenta <= Ccuenta + 1'b1; 
			end
	end

always @(posedge MasterClk, posedge reset) 
	begin
		if (reset)
				Divisor50 <= 0;
		else 
			Divisor50 <= ~Divisor50;
	end
endmodule
