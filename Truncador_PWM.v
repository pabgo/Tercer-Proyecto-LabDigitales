`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:35:56 10/13/2015 
// Design Name: 
// Module Name:    Truncador_PWM 
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
module Truncador_PWM(
input wire [27:0]Dato_In,
input wire CS,
output reg [10:0]Dato_Out = 0,
output reg [11:0] Basura = 0
    );


always@(posedge CS)
begin
if(Dato_In[26:15]!= 12'b000000000000 && Dato_In[27]==0 )
	Dato_Out = 11'b11111111111;
else if(Dato_In[26:15]!= 12'b111111111111 && Dato_In[27]==1)
	Dato_Out = 11'b00000000000;
else
	Dato_Out = {~{Dato_In[14]},Dato_In[13:4]};
end
endmodule
