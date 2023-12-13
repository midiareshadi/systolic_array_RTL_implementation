// File: systolic_array_2x2.v 
`timescale 1ns/1ns

module systolic_array_2x2 (sa_RD_0,sa_RD_1, sa_FDi_0,sa_FDi_1,sa_clk,sa_rst,sa_load, sa_bd_PE_0, sa_bd_PE_1, sa_GD_0,sa_GD_1, sa_FDo_0,sa_FDo_1);
	//Constant
	parameter DATA_WIDTH=16;    
	
	//Ports 
	input [DATA_WIDTH-1:0] sa_RD_0,sa_RD_1, sa_FDi_0, sa_FDi_1;
	input sa_clk, sa_rst, sa_load, sa_bd_PE_0, sa_bd_PE_1;
	output [DATA_WIDTH-1:0] sa_GD_0, sa_GD_1, sa_FDo_0, sa_FDo_1;
	
	//Wires
	wire [DATA_WIDTH-1:0] FDi_FDo_0, FDi_FDo_1, GD_RD_0, GD_RD_1;

// Using genvar to isntantiate. It works in iverlog but not isim
/* 
	genvar i;
	generate
		for (i=0; i<2 ; i=i+1) begin
			pe pe_inst (
				GD_RD_w[i],
				FDi_w[i],
				clk_w,
				rst_w,
				load_w,
				GD_RD_w[i+1],
				FDo_w[i]
			);
		end
	endgenerate
*/
//-----------------------------------  
pe pe_inst_0 (
	.RD(sa_RD_0),
	.FDi(sa_FDi_0),
	.bd_PE(sa_bd_PE_0),
	.clk(sa_clk),
	.rst(sa_rst),
	.load(sa_load),
	.GD(GD_RD_0),
	.FDo(FDi_FDo_0)
);
defparam pe_inst_0.DATA_WIDTH=DATA_WIDTH;
//----------------------------------- 
pe pe_inst_1 (
	.RD(GD_RD_0),
	.FDi(sa_FDi_1),
	.bd_PE(sa_bd_PE_1),
	.clk(sa_clk),
	.rst(sa_rst),
	.load(sa_load),
	.GD(sa_GD_0),
	.FDo(FDi_FDo_1)
);
defparam pe_inst_1.DATA_WIDTH=DATA_WIDTH;
//----------------------------------- 
pe pe_inst_2 (
	.RD(sa_RD_1),
	.bd_PE(sa_bd_PE_0),
	.FDi(FDi_FDo_0),
	.clk(sa_clk),
	.rst(sa_rst),
	.load(sa_load),
	.GD(GD_RD_1),
	.FDo(sa_FDo_0)
);
defparam pe_inst_2.DATA_WIDTH=DATA_WIDTH;
//----------------------------------- 
pe pe_inst_3 (
	.RD(GD_RD_1),
	.bd_PE(sa_bd_PE_1),
	.FDi(FDi_FDo_1),
	.clk(sa_clk),
	.rst(sa_rst),
	.load(sa_load),
	.GD(sa_GD_1),
	.FDo(sa_FDo_1)
);
defparam pe_inst_3.DATA_WIDTH=DATA_WIDTH;
//----------------------------------- 

endmodule
