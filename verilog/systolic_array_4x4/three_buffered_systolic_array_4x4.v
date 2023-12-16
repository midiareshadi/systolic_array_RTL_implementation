
module systolic_array_chip_4x4(inA, inB, clk, buf_read, rst, result_ld, GD0, GD1, GD2, GD3);
	
	parameter DATA_WIDTH=16;
	
	input [DATA_WIDTH-1:0] inA;
	input [(2*DATA_WIDTH)-1:0] inB;
	input clk, rst, result_ld,buf_read;
	output [(2*DATA_WIDTH)-1:0] GD0, GD1, GD2, GD3;
	
	wire [DATA_WIDTH-1:0] FDi_sig[0:3];
	wire [(2*DATA_WIDTH)-1:0] RD_sig[0:3];
	//wire [(2*DATA_WIDTH)-1:0] GD_sig[0:3];
	
	wire buf_A_full, buf_A_empty, buf_B_full, buf_B_empty,buf_C_full;
	

	in_buffer_4x4_DW A_bf_inst(
		.in(inA),
		.read(buf_read),
		.clk(clk),
		.full(buf_A_full),
		.empty(buf_A_empty),
		.out0(FDi_sig[0]),
		.out1(FDi_sig[1]),
		.out2(FDi_sig[2]),
		.out3(FDi_sig[3])
	);
	
	in_buffer_4x4_2DW B_bf_inst(
		.in(inB),
		.read(buf_read),
		.clk(clk),
		.full(buf_B_full),
		.empty(buf_B_empty),
		.out0(RD_sig[0]),
		.out1(RD_sig[1]),
		.out2(RD_sig[2]),
		.out3(RD_sig[3])
	);
	
//	outp_buffer outp_buf_inst(
//		.clk(clk),
//		.full(buf_C_full),
//		.in0(GD_sig[0]),
//		.in1(GD_sig[1]),
//		.in2(GD_sig[2]),
//		.in3(GD_sig[3])
//	);
	
	systolic_array_4x4 sys_inst(
		.FDi0(FDi_sig[0]),
		.FDi4(FDi_sig[1]),
		.FDi8(FDi_sig[2]),
		.FDi12(FDi_sig[3]),
		.RD0(RD_sig[0]),
		.RD1(RD_sig[1]),
		.RD2(RD_sig[2]),
		.RD3(RD_sig[3]),
		.clk(clk),
		.rst(rst),
		.result_ld(result_ld),
		.sa_GD0(GD0),
		.sa_GD1(GD1),
		.sa_GD2(GD2),
		.sa_GD3(GD3)
	);

		      
endmodule
		      
