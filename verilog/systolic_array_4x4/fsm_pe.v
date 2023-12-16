module fsm_pe (RD, FDi, clk, rst, GD, FDo, result, result_ld);
	parameter DATA_WIDTH=16,
			reset=0,
			calc_0=1,
			calc_1=2,
			ld_result=3,
			drain_0=4,
			drain_1=5;
	
	input [(2*DATA_WIDTH)-1:0] RD;
	input [DATA_WIDTH-1:0] FDi;
	input clk, rst, result_ld;
	
	output reg [DATA_WIDTH-1:0] FDo;
	output reg [(2*DATA_WIDTH)-1:0] GD;
	output reg [(2*DATA_WIDTH)-1:0] result;
	
	wire [(2*DATA_WIDTH)-1:0] multi;
	
	reg[2:0]  p_state, n_state;	
	
	
	always @ (p_state,result_ld)
	
    		begin
            
     		   case (p_state)
        
			reset: // state 0
			begin
				result <= 0;
				FDo <= 0;
				GD <= 0;
				
				// next state
				n_state=calc_0;
			end
			
			calc_0: // state 1
			begin
				result <= result + multi;
				FDo <= FDi;
				GD <= RD;
				
				// next state
				if (result_ld)
					n_state=ld_result;
				else
					n_state=calc_1;			
			end
	
			calc_1: // state 2
			begin
				result <= result + multi;
				FDo <= FDi;
				GD <= RD;
				
				// next state
				if (result_ld)
					n_state=ld_result;
				else
					n_state=calc_0;			
			end
	
			ld_result: // state 3
			begin
				GD <= result;
				
				// next state
				n_state=drain_0;
			end
			
			drain_0: // state 4
			begin
				GD <= RD;
				
				// next state
				n_state=drain_1;
			end
			
			drain_1: // state 5
			begin
				GD <= RD;
				
				// next state
				n_state=drain_0;
			end

			default: n_state= reset;

		   endcase
		
	end // end of always
	
	// MAC operation
		assign multi = RD*FDi;
		
	
  	always @ (posedge clk)
  	
    		begin // always    
       			if (rst)
        			   p_state=reset; 
			else
     				   p_state=n_state;
   		 end // always
endmodule
