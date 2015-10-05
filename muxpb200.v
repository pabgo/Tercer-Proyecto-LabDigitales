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
module muxpb200(
	input wire [2:0] controlS,controlZ,
	input wire [1:0] controlC,
	input wire [`N-1:0] fk,fk1,fk2,yk,Uk,acum1,acum2,acum3, 
	output wire [`N-1:0] muxS,muxC,muxZ         
    );
	 
parameter s = `N-(`F+2);
localparam [`N-1:0]
		  auno={{s{1'b0}},16'sd32112},
		  ados={{s{1'b1}},-16'sd15736},
		  bcero={{s{1'b0}},16'sd3},
		  buno={{s{1'b0}},16'sd6},
		  bdos={{s{1'b0}},16'sd3},
		  cero={{s{1'b0}},16'sd0};
		  
assign muxS = 		 (controlS==0) ?   cero : 
                   (controlS==1) ?   auno : 
						 (controlS==2) ?   ados : 
						 (controlS==3) ?   bcero : 
						 (controlS==4) ?   buno: 
						 (controlS==5) ?   bdos :						 
                      cero ;
assign muxC = 		 (controlC==0) ?   cero : 
                   (controlC==1) ?   fk1 : 
						 (controlC==2) ?   fk2  : 
						 (controlC==3) ?   fk : 						 
                      cero ;
assign muxZ = 		 (controlZ==0) ?   cero : 
                   (controlZ==1) ?   Uk : 
						 (controlZ==2) ?   yk : 
						 (controlZ==3) ?   acum1: 
						 (controlZ==4) ?   acum2: 
						 (controlZ==5) ?   acum3:
                      cero ;
							 
endmodule
