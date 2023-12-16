module in_buffer_4x4_DW (in, read, clk, full, empty, out0, out1, out2, out3);
	
	parameter DATA_WIDTH=16,
			n=4,
			m=7;
	
	input [DATA_WIDTH-1:0] in;
	input clk, read;
	
	output reg[DATA_WIDTH-1:0] out0, out1, out2, out3;
	output reg full, empty;
	
	integer i=0, j=0, k=0;

	reg [DATA_WIDTH-1:0] mem[0:(m-1)][0:(n-1)];
	
	
	always @ (posedge clk) begin
	
		if ((~read) && (i<m) && (j<n)) begin
			
			mem [i][j]<=in;
			
			//$display ("-----if 1-----");
			//$display ("mem [%d][%d]=%d", i, j, in);  
			j=j+1;
		end
		
		else if ((~read) && (i<(m-1)) && (j>(n-1))) begin
			j=0;
			i=i+1;
			mem [i][j]<=in;
			//$display ("mem [%d][%d]=%d", i, j, in); 
			//$display ("----------");
			j=1;
		end
		
		else if ((~read) && (i>(m-1))) begin
		
			full<=1;
			$display ("Buffer is full");  
				
		end
	
		else if ((read) && (k<(m))) begin
		
			out0 <= mem[k][0];
			out1 <= mem[k][1];
			out2 <= mem[k][2];
			out3 <= mem[k][3];
			
			k=k+1;
		end
		
		else if ((read) && (k>(m-1))) begin
		
			$display ("Buffer is empty"); 
			empty<=1;
			
		end
				
	end // always
		
endmodule
