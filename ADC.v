`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:15:36 09/22/2015 
// Design Name: 
// Module Name:    ADC 
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
module ADC(
    input wire sdata,
	 input wire clk,
	 input wire reset,
	 output reg cs,
	 output reg sclk,
	 output reg dato_listo,
	 output reg [15:0] dato
	 );

localparam [1:0] 
	espera = 2'b00,
	captura = 2'b01,
	datolisto = 2'b10;

reg [1:0] estado, estadosig; 
reg [15:0] reg_desp;
reg aux_s_clk,aux_cs,enable;
reg [4:0] contador;
reg [6:0] cuenta; 
reg [11:0] cuento; 

//Reloj 44,1kHz 
always @(posedge clk,posedge reset) 
begin
	if (reset) 
	begin
		aux_cs <= 0;
		cuento <= 0;
	end 
	else 
	begin		
		if (cuento == 12'd2267)
		begin                    
			cuento <= 12'h0;     
			aux_cs <= ~aux_cs;  
		end 
		else 
			cuento <= cuento + 1'b1; 
	end
end

//Reloj de 882kHz 
always @(posedge clk,posedge reset) 
begin
	if (reset) 
	begin
		aux_s_clk <= 0;
		cuenta <= 0;
	end 
	else 
	begin		
		if (cuenta == 7'd113)
		begin                    
			cuenta <= 7'h0;   
			aux_s_clk <= ~aux_s_clk;  
		end 
		else 
			cuenta <= cuenta + 1'b1; 
	end
end

//contador
always @(negedge aux_s_clk)
begin
if(enable)
begin
   if(contador < 5'd21)
		contador = contador+1'b1;
	else
		contador = 5'b00000;
end
else
	contador = 5'b00000;
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
	cs = aux_cs;
	sclk = aux_s_clk;
	estadosig = estado;
	dato_listo = 1'b0;
	enable = 1'b0;
	reg_desp <= 16'h0000;
	dato = reg_desp;
	case(estado)
		espera:
		
			if(aux_cs)
			begin
				estadosig = espera;
				dato_listo = 1'b0;  
			end
			else
			begin
				estadosig = captura;
				dato_listo = 1'b0;
			end
			
		captura:
		
			begin
			reg_desp <= {reg_desp[14:0],sdata};
			enable = 1'b1;
			if(contador == 5'd16)
			begin
				estadosig = datolisto;
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
			dato_listo = 1'b1;
			if(contador == 20)
			begin
				estadosig = espera;
				dato_listo = 1'b1;
			end
			else
			begin
				estadosig = datolisto;
				dato_listo = 1'b0;
			end
			end
			
		default:
			estadosig = espera;

	endcase
end

endmodule
