`timescale 1ns/1ns
module systolic_array_4x4(
		      FDi0, FDi4, FDi8, FDi12,
		      RD0, RD1, RD2, RD3,
		      clk, rst, result_ld,
		      FDo0, FDo4, FDo8, FDo12,
		      sa_GD0, sa_GD1, sa_GD2, sa_GD3);
	parameter DATA_WIDTH=16;
	
	input [DATA_WIDTH-1:0] FDi0, FDi4, FDi8, FDi12;
	input [(2*DATA_WIDTH)-1:0] RD0, RD1, RD2, RD3;
	input clk, rst, result_ld;
	
	output [(2*DATA_WIDTH)-1:0] sa_GD0, sa_GD1, sa_GD2, sa_GD3;
	output [DATA_WIDTH-1:0] FDo0, FDo4, FDo8, FDo12;
	
	
	wire [(2*DATA_WIDTH)-1:0] result[0:15];
	
		
	wire [(2*DATA_WIDTH)-1:0] GD[0:15];
	wire [DATA_WIDTH-1:0] FDo[0:15];
	

	//from north and west
	fsm_pe P0 (RD0, FDi0, clk, rst, GD[0], FDo0, result[0], result_ld);
	//from north
	fsm_pe P1 (RD1, FDo0, clk, rst, GD[1], FDo[1], result[1], result_ld);
	fsm_pe P2 (RD2, FDo[1], clk, rst, GD[2], FDo[2], result[2], result_ld);
	fsm_pe P3 (RD3, FDo[2], clk, rst, GD[3], FDo[3], result[3], result_ld);
	
	//from west
	fsm_pe P4 (GD[0], FDi4, clk, rst, GD[4], FDo4, result[4], result_ld);
	fsm_pe P8 (GD[4], FDi8, clk, rst, GD[8], FDo8, result[8], result_ld);
	fsm_pe P12 (GD[8], FDi12, clk, rst, sa_GD0, FDo12, result[12], result_ld);
	
	//no direct inputs
	//second row
	fsm_pe P5 (GD[1], FDo4, clk, rst, GD[5], FDo[5], result[5], result_ld);
	fsm_pe P6 (GD[2], FDo[5], clk, rst, GD[6], FDo[6], result[6], result_ld);
	fsm_pe P7 (GD[3], FDo[6], clk, rst, GD[7], FDo[7], result[7], result_ld);
	//third row
	fsm_pe P9 (GD[5], FDo8, clk, rst, GD[9], FDo[9], result[9], result_ld);
	fsm_pe P10 (GD[6], FDo[9], clk, rst, GD[10], FDo[10], result[10], result_ld);
	fsm_pe P11 (GD[7], FDo[10], clk, rst, GD[11], FDo[11], result[11], result_ld);
	//fourth row
	fsm_pe P13 (GD[9], FDo12, clk, rst, sa_GD1, FDo[13], result[13], result_ld);
	fsm_pe P14 (GD[10], FDo[13], clk, rst, sa_GD2, FDo[14], result[14], result_ld);
	fsm_pe P15 (GD[11], FDo[14], clk, rst, sa_GD3, FDo[15], result[15], result_ld);
	
		      
endmodule
		      
