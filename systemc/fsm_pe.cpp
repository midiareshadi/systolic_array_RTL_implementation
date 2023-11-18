// File: pe.cpp

#include "fsm_pe.h"

void fsm_pe::prc_state_machine(){
    
	switch (p_state){
        
	case reset: // state 0
	
		result = 0;
		FDo = 0;
		GD = 0;
		
		// next state 		       
		n_state=calc_0;
	break;
            
	case calc_0: // state 1
	        
		result = result.read() + multi.read();
		FDo = FDi;
		GD = RD;
		
		// next state
		if (result_ld)
			n_state=ld_result;
		else
			n_state=calc_1;	
		
	break;
            
	case calc_1: // state 2
	
		result = result.read() + multi.read();
		FDo = FDi;
		GD = RD;
		
		// next state
		if (result_ld)
			n_state=ld_result;
		else
			n_state=calc_0;
	break;

	case ld_result: // state 3
		GD = result;
		
		// next state
		n_state=drain_0;
	break;
	
        
	case drain_0: // state 4
		GD = RD;
			
		// next state
		n_state=drain_1;
	break;
	
	case drain_1: // state 5
		GD = RD;

		// next state
		n_state=drain_0;
	break;
            
    default:
		n_state=reset; 
	break;

    } //end of case
    
    state_status=(sc_uint<3>)p_state;
    
    //Multiply
    multi = RD.read() * FDi.read();
    
} //end of function

// FSM output computation
void fsm_pe::prc_output_comb(){
	
	if(rst) 
		p_state=reset;
	else
		p_state= n_state;
} //end of function

// mac_calc local function
sc_uint<DATA_WIDTH> fsm_pe::mac_calc(sc_uint<DATA_WIDTH> f_LR, sc_uint<DATA_WIDTH> f_FDi, sc_uint<DATA_WIDTH> f_RD, bool f_bd_PE)
    {
    	sc_uint<DATA_WIDTH> f_mult, f_mac;
    	
   	f_mult = f_FDi * f_LR;
			if (f_bd_PE)
				f_mac=f_mult;
			else
				f_mac= f_RD + f_mult;
	return f_mac;
    } // end of function
