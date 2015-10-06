`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:01:19 10/05/2015
// Design Name:   filtronuevopb200
// Module Name:   D:/TEC/Lab Digitales/Proyecto 3/filtro/prueba4.v
// Project Name:  filtro
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: filtronuevopb200
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module prueba4;

	// Inputs
	reg clk;
	reg datolisto;
	reg reset;
	reg [26:0] uk;

	// Outputs
	wire [26:0] yk;
	wire [26:0] salfk;
	wire [26:0] salfk1;
	wire [26:0] salfk2;
	wire [26:0] salarit;
	wire resulisto;
	wire en1;
	wire en2;
	wire en3;
	wire en4;
	wire en5;
	wire en6;
	wire en7;

	// Instantiate the Unit Under Test (UUT)
	filtronuevopb200 uut (
		.clk(clk), 
		.datolisto(datolisto), 
		.reset(reset), 
		.uk(uk), 
		.yk(yk), 
		.salfk(salfk), 
		.salfk1(salfk1), 
		.salfk2(salfk2), 
		.salarit(salarit), 
		.resulisto(resulisto), 
		.en1(en1), 
		.en2(en2), 
		.en3(en3), 
		.en4(en4), 
		.en5(en5), 
		.en6(en6), 
		.en7(en7)
	);

	reg [26:0] datos_uk [0:999];
	integer i;
	integer salida;

	initial begin
		// Initialize Inputs
		clk = 0;
		datolisto = 0;
		reset = 1;
		uk = 0;
		$readmemb("uk.txt", datos_uk);
		salida = $fopen("salida.txt","w");
		repeat(10)@(posedge clk);
		reset = 0;
		
	end
	
	initial begin
	@(negedge reset);
	repeat(10) @(posedge clk);
		for(i = 0; i<1000; i=i+1)
		begin
			@(posedge clk);
			uk = datos_uk[i];
			datolisto = 1'b1;
			@(posedge clk)  
			$fwrite(salida,"%b\n",yk);
			datolisto = 1'b0;
			repeat(15)@(posedge clk);
		end
		$stop;
	end

	initial forever begin
		#5 clk = ~clk;
	end
      
endmodule

