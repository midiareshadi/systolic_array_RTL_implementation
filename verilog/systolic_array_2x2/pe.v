`timescale 1ns/1ns

module pe(RD,FDi,clk,rst,load,bd_PE,GD,FDo);
    
    //Ports 
    input [DATA_WIDTH-1:0] RD,FDi;
    input clk,rst,load,bd_PE;
    output reg [DATA_WIDTH-1:0] GD,FDo;
    
    //Constant
	parameter 
			DATA_WIDTH=16,
			PE_rst=0,
			load_LR=1,
			load_out=2,
			feed_get=3,
			feed_out=4;
              
    
    //Regs
    reg [DATA_WIDTH-1:0] LR, mult, mac, RD_reg [0:1], FDi_reg_0, FDi_reg_1;
    			
    reg[2:0]  p_state, n_state;

    //for index
    //reg[3:0] i=0;
           
   always @ (p_state,load)
    
    begin
            
        case (p_state)
        
		PE_rst: // state 0

			// next state
			begin
				if (load)
					n_state=load_LR;
				else
					n_state=feed_get;
			end
        
		load_LR: // state 1
			begin		

				// input port
				RD_reg[0]=RD;
				// LR load
				LR=RD;
				// output ports 
				GD=RD_reg[1];
				
				// next state
				n_state=load_out;
			end
        
	        load_out: // state 2
	        
        		begin	
				// input ports
        			RD_reg[1]=RD;
        			LR=RD;
        			FDi_reg_0=FDi; // FDi reg 0
        			
        		// output port
        			GD=RD_reg[0];
        			
        		// next state
        			if (load)
        				n_state=load_LR;
					else
					n_state=feed_get;
				end
			
		feed_get: // state 3
			begin
				// input ports
					RD_reg[0]=RD;
					FDi_reg_1=FDi; // FDi reg 1 
					
				// Ouput ports
					GD=mac;
					FDo=FDi_reg_0;
				
				// next state
				if (load)
					n_state=load_LR;
				else
					begin
						mult = FDi_reg_0 * LR;
						if (bd_PE)
							mac= mult;
						else
						mac = RD_reg[1] + mult;
						
						n_state = feed_out;
					end
			end
			
		feed_out: // state 4
			begin
				// input ports
				RD_reg[1]=RD;
				FDi_reg_0 = FDi; // FDi reg 0
				
				// ouput ports
				GD=mac;
				FDo=FDi_reg_1;
				
				// next state
				if (load)
					n_state=load_LR;
				else
					begin
						mult = FDi_reg_1 * LR;
						if (bd_PE)
							mac= mult;
						else
							mac=RD_reg[0] + mult;
							
						n_state = feed_get;
					end
			end

        
        default: n_state= PE_rst;
         
        endcase
    end
         
  always @ (posedge clk)
    begin     
       if (rst)
         begin
           p_state=PE_rst; 
         end
         
       else
           p_state=n_state;
    end
   
endmodule
