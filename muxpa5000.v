`timescale 1ns / 1ps
`include "constantes.h"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:32:14 09/27/2015 
// Design Name: 
// Module Name:    mux 
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
module muxpa5000(
	input wire [2:0] controlS,controlZ,
	input wire [1:0] controlC,
	input wire [`N-1:0] fk,fk1,fk2,yk,Uk,acum1,acum2,acum3, 
	output wire [`N-1:0] muxS,muxC,muxZ         
    );
	 
parameter s = `N-(`F+2);
localparam [`N-1:0]
		  auno={{s{1'b0}},17'b01000010001111010},
		  ados={{s{1'b1}},17'b11101000011101100},
		  bcero={{s{1'b0}},17'b00100110011100011},
		  buno={{s{1'b1}},17'b10110011001000110},
		  bdos={{s{1'b0}},17'b00100110011100011},
		  cero={{s{1'b0}},17'b00000000000000000};
		    
assign muxS = 		 (controlS == 3'b000) ?   cero : 
                   (controlS == 3'b001) ?   auno : 
						 (controlS == 3'b010) ?   ados : 
						 (controlS == 3'b011) ?   bcero : 
						 (controlS == 3'b100) ?   buno: 
						 (controlS == 3'b101) ?   bdos :						 
                      cero ;
assign muxC = 		 (controlC == 2'b00) ?   cero : 
                   (controlC == 2'b01) ?   fk1 : 
						 (controlC == 2'b10) ?   fk2  : 
						 (controlC == 2'b11) ?   fk : 						 
                      cero ;
assign muxZ = 		 (controlZ == 3'b000) ?   cero : 
                   (controlZ == 3'b001) ?   Uk : 
						 (controlZ == 3'b010) ?   yk : 
						 (controlZ == 3'b011) ?   acum1: 
						 (controlZ == 3'b100) ?   acum2: 
						 (controlZ == 3'b101) ?   acum3:
                      cero ;
							 
endmodule
