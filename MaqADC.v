`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:17:40 10/14/2015 
// Design Name: 
// Module Name:    MaqADC 
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
module MaqADC(
	 input wire sdata,
	 input wire clk,
	 input wire reset,
	 input wire cs,
	 input wire sclk,
	 output reg dato_listo,auxenable,
	 output reg [4:0] auxconta,
	 output reg [11:0] dato,auxreg
	 );

localparam [2:0] 
	espera = 3'b000,
	captura = 3'b001,
	datolisto = 3'b010,
	copiado = 3'b011,
	copiado1 = 3'b100,
	copiado2 = 3'b101;

reg [2:0] estado, estadosig; 
reg [11:0] reg_desp;
reg enable;
reg [4:0] contador;



//contador
always @(negedge sclk)
begin
	if(enable)
	begin
		if(contador < 5'b10011)
		begin
			contador = contador+1'b1;
			if(contador < 5'b10010)
				reg_desp[11:0] <= {reg_desp[10:0],sdata};
			else
				reg_desp[11:0] <= reg_desp[11:0];
		end
		else
		begin
		contador = 5'b00000;
		reg_desp[11:0] <= 12'b000000000000;
		end
	end
	else
	begin
		contador = 5'b00000;
		reg_desp[11:0] <= reg_desp[11:0];
	end
end

	 
//Parte Secuencial
always@(posedge clk, posedge reset)
begin
	if(reset)
		estado <= espera;
	else
		estado <= estadosig;
end

//Parte Combinacional
always@*
begin
	estadosig = estado;
	dato_listo = 1'b0;
	enable = 1'b0;
	dato = 12'h000;
	auxreg = reg_desp;
	auxenable = enable;
	auxconta = contador;
	case(estado)
		espera:
			begin
			if(cs)
			begin
				enable = 1'b0;
				estadosig = espera;
				dato_listo = 1'b0;
				auxreg = reg_desp;
				auxenable = enable;
				auxconta = contador;
			end
			else
			begin
				enable = 1'b0;
				estadosig = captura;
				dato_listo = 1'b0;
				auxreg = reg_desp;
				auxenable = enable;
				auxconta = contador;
			end
			end
			
		captura:
		
			begin
			
			enable = 1'b1;
			auxreg = reg_desp;
			auxenable = enable;
			auxconta = contador;
			if(contador == 5'b10010)
			begin
				estadosig = datolisto;
				dato_listo = 1'b1;
				dato = reg_desp;
				enable = 0;
			end
			else
			begin
				estadosig = captura;
				dato_listo = 1'b0;
			end
			end
				
		datolisto:
			
			begin
			dato = reg_desp;
			auxreg = reg_desp;
			auxenable = enable;
			auxconta = contador;
			enable = 1'b0;
			estadosig = copiado;
			dato_listo = 1'b1;
			end
			
		copiado:
			begin
			estadosig = copiado1;
			dato_listo = 1'b1;
			dato = reg_desp;
			auxreg = reg_desp;
			auxenable = enable;
			auxconta = contador;
			end
			
		copiado1:
			begin
			estadosig = copiado2;
			dato_listo = 1'b1;
			dato = reg_desp;
			auxreg = reg_desp;
			auxenable = enable;
			auxconta = contador;
			end
		
		copiado2:
			begin
			estadosig = espera;
			dato_listo = 1'b1;
			dato = reg_desp;
			auxreg = reg_desp;
			auxenable = enable;
			auxconta = contador;
			end
			
			
		default:
			estadosig = espera;

	endcase
end

endmodule
