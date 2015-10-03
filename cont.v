`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:41:16 09/29/2015 
// Design Name: 
// Module Name:    cont 
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
module cont(
	input wire clk,
	input wire enable,
	output reg [4:0] out
    );
	 
reg [4:0] contador;	
   

   always @(negedge clk)
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

endmodule
