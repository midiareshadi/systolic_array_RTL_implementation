`timescale 1ns/1ns

module systolic_array_2x2_tb;

	//Constant
   	parameter DATA_WIDTH=16,
   			  dim=2;

    // Inputs
    reg [DATA_WIDTH-1:0] tb_RD_0, tb_RD_1,tb_FDi_0, tb_FDi_1, tb_FDi_0_temp, tb_FDi_1_temp;
    reg tb_clk, tb_rst, tb_load, tb_bd_PE_0, tb_bd_PE_1;
    wire [DATA_WIDTH-1:0] tb_GD_0, tb_GD_1, tb_FDo_0, tb_FDo_1;
  

    //InFile
    integer A_file,inFromFile_A, B_file, inFromFile_B;      

    // Instantiation
    systolic_array_2x2 sa_inst_2x2 (
        .sa_RD_0(tb_RD_0),
        .sa_RD_1(tb_RD_1),
        .sa_FDi_0(tb_FDi_0),
        .sa_FDi_1(tb_FDi_1),
        .sa_clk(tb_clk),
        .sa_rst(tb_rst),
        .sa_bd_PE_0(tb_bd_PE_0),
        .sa_bd_PE_1(tb_bd_PE_1),
        .sa_load(tb_load),
        .sa_GD_0(tb_GD_0),
        .sa_GD_1(tb_GD_1),
        .sa_FDo_0(tb_FDo_0),
        .sa_FDo_1(tb_FDo_1)
    );
    
    // bd_PE initialization
    initial begin
	    tb_bd_PE_0=1;
	    tb_bd_PE_1=0;
    end
    
    // clock initial
	initial begin
		tb_clk=0;
	end
    
	// clock generation
	always #10 tb_clk = ~ tb_clk;

	initial begin
		// initializing rst and load 
		tb_rst=0;
		tb_load=0;
		
		// tb_rst
		#5;
		tb_rst=1;
		#10;
		tb_rst=0;
		
		// tb_load
    	#10;
		tb_load=1;
		#(dim*20); 
		tb_load=0;


	end
    

    
	// Reading B File
	initial begin
	
		#30;
	      // Input file      
		B_file=$fopen("B_TB.txt","r");
      
	while (! $feof(B_file)) 
		begin         
			inFromFile_B=$fscanf(B_file,"%d %d\n",tb_RD_0, tb_RD_1);
		#20;                         
	end
                  
	$fclose(B_file);
      
	end // End of Reading B

	// Reading A File
	initial begin
	
		#85;
		A_file=$fopen("A_TB.txt","r");
      
	while (! $feof(A_file)) 
		begin         
			inFromFile_A=$fscanf(A_file,"%d %d\n",tb_FDi_0_temp,tb_FDi_1_temp);
			tb_FDi_0 = tb_FDi_0_temp;
			//#20;
			tb_FDi_1 = tb_FDi_1_temp;
			#40;                         
	end
                  
	$fclose(A_file);
      
	end // End of input file
       
       //Generating VCD
       initial begin     
          $dumpfile("VCD_FILE.vcd");
          $dumpvars;
        end //End of generating VCD
        
     //final delay   
     initial begin
          #340;      
          $finish;
     end
     
endmodule


