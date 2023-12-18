`timescale 1ns/1ns

module tb_systolic_array_4x4;

parameter DATA_WIDTH=16,
		period=10,
		start_ld=15,
		sys_rst=15,
		num_of_clk=30;

	
	
	reg [DATA_WIDTH-1:0] tb_FDi0, tb_FDi4, tb_FDi8, tb_FDi12;
	reg [(2*DATA_WIDTH)-1:0] tb_RD0, tb_RD1, tb_RD2, tb_RD3;
	
	wire [DATA_WIDTH-1:0] tb_FDo0, tb_FDo4, tb_FDo8, tb_FDo12;
	wire [(2*DATA_WIDTH)-1:0] tb_GD0, tb_GD1, tb_GD2, tb_GD3;
	
	reg tb_clk, tb_rst, tb_result_ld;
	
	integer inFromFile_A, inFromFile_B, A_file, B_file;
	
	systolic_array_4x4 sa_4x4_inst(
		.clk(tb_clk),
		.rst(tb_rst),
		.result_ld(tb_result_ld),
		.RD0(tb_RD0),
		.RD1(tb_RD1),
		.RD2(tb_RD2),
		.RD3(tb_RD3),
		.FDi0(tb_FDi0),
		.FDi4(tb_FDi4),
		.FDi8(tb_FDi8),
		.FDi12(tb_FDi12),
		.FDo0(tb_FDo0),
		.FDo4(tb_FDo4),
		.FDo8(tb_FDo8),
		.FDo12(tb_FDo12),
		.sa_GD0(tb_GD0),
		.sa_GD1(tb_GD1),
		.sa_GD2(tb_GD2),
		.sa_GD3(tb_GD3)
	);
	
// Reading B File
initial begin
	
#start_ld;
              
  	B_file=$fopen("B_TB.txt","r");
      
		while (! $feof(B_file)) 
			begin         
				inFromFile_B= $fscanf(B_file,"%d %d %d %d\n", tb_RD0, tb_RD1, tb_RD2, tb_RD3);
				#(2*period);                         
			end
                  
	$fclose(B_file);
      
end // End of Reading B

// Reading A File
initial begin
	
#start_ld;

	A_file=$fopen("A_TB.txt","r");
      
	while (! $feof(A_file)) 
		begin         
			inFromFile_A=$fscanf(A_file,"%d %d %d %d\n",tb_FDi0, tb_FDi4, tb_FDi8, tb_FDi12);
			#(2*period);
		end
                  
	$fclose(A_file);
      
end // End of input file

initial begin // rst 
	tb_rst <= 1;
	tb_clk <= 0;
	#(sys_rst);
	tb_rst <= 0;

end

initial begin // clock
	
	repeat(num_of_clk)
		#period tb_clk <= ~tb_clk;
end

initial begin // result_ld

	tb_result_ld=0;
	#(223);
	tb_result_ld=1;
	#(2*period);
	tb_result_ld=0;

end
	
initial begin
	$dumpfile("VCD_FILE.vcd");
	$dumpvars;
end
			      
endmodule
		      
