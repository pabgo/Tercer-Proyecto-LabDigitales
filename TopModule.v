`timescale 1ns / 1ps
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
input wire SDATA,
output wire PWM_Salida,
output wire SClk,CS,
output wire SD,
output wire Divisor50,
output wire [15:0]b_reg,
output wire [11:0]Basura
///output wire [10:0]Dato_Truncado

    );

//wire [15:0] b_reg;
wire [27:0]ADC_Data;

wire [10:0]Dato_Truncado;
//wire [11:0]Basura;

Divisores_Frecuencias instance_name (
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
	 
Truncador_PWM Instance3 (
    .Dato_In(ADC_Data), 
    .CS(CS), 
    .Dato_Out(Dato_Truncado), 
    .Basura(Basura)
    );
	 
	 PWM Instance4 (
    .clk_in(MasterClk), 
    .Dato(Dato_Truncado), 
    .PWM_out(PWM_Salida)
    );
assign SD = 1'b1;
endmodule
