`timescale 1ns / 1ps
`include "constantes.h"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:34:20 10/13/2015 
// Design Name: 
// Module Name:    TopModule 
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
module TopModule(
	input wire MasterClk, reset,
	input wire SDATA,sw1,sw2,sw3,
	output wire PWM_Salida,
	output wire SClk,CS,
	output wire SD,
	output wire Divisor50,resultlisto,
	output wire [15:0]b_reg
    );

wire [27:0]ADC_Data,yk1,yk2,yk3,salselec;
wire [10:0]Dato_Truncado;

Divisores_Frecuencias instance1 (
    .MasterClk(MasterClk), 
    .reset(reset), 
    .SClk(SClk), 
    .Divisor50(Divisor50), 
    .CS(CS)
    );
	 
Recepcion_ADC Instance2 (
    .SDATA(SDATA), 
    .reset(reset), 
    .CS(CS), 
    .SCLK(SClk), 
    .rx_done_tick(rx_done_tick), 
    .b_reg(b_reg), 
    .data_Out(ADC_Data)
    );

UnidadFiltrado instance3 (
    .clk(MasterClk), 
    .reset(reset), 
    .datolisto(rx_done_tick), 
    .uk(ADC_Data), 
    .yk1(yk1), 
    .yk2(yk2), 
    .yk3(yk3), 
    .resultlisto(resultlisto)
    );


Seleccionador instance4 (
    .yk1(yk1), 
    .yk2(yk2), 
    .yk3(yk3), 
    .sw1(sw1), 
    .sw2(sw2), 
    .sw3(sw3),  
    .result(salselec)
    );
	 
Truncador_PWM Instance5 (
    .Dato_In(salselec), 
    .CS(CS), 
    .Dato_Out(Dato_Truncado)
    );
	 
	 PWM Instance6 (
    .clk_in(MasterClk), 
    .Dato(Dato_Truncado), 
    .PWM_out(PWM_Salida)
    );
assign SD = 1'b1;
endmodule
