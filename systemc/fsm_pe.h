// File: fsm_pe.h
#include "systemc.h"

//Constants
const int DATA_WIDTH=16;
    
SC_MODULE(fsm_pe) {
    
    //Ports
    sc_in<sc_uint<DATA_WIDTH>> FDi;
    sc_in<sc_uint<(2*DATA_WIDTH)>> RD;
    
    sc_in<bool> clk, rst, result_ld;
    
    sc_out<sc_uint<(2*DATA_WIDTH)>> GD;
    sc_out<sc_uint<DATA_WIDTH>> FDo;
    sc_out<sc_uint<(2*DATA_WIDTH)>> result;

    
    //FSM state declaration
    enum states {reset=0,
                  calc_0=1,
                  calc_1=2,
                  ld_result=3,
                  drain_0=4,
                  drain_1=5
                };
    
    //Signals
    sc_signal<states> p_state,n_state;
    sc_signal<sc_uint<(2*DATA_WIDTH)>> multi;
    
    //FSM states as parameters
    sc_uint<3> state_status;

    //Functions
    void prc_state_machine();
    void prc_output_comb();
    sc_uint<DATA_WIDTH> mac_calc(sc_uint<DATA_WIDTH> f_LR, sc_uint<DATA_WIDTH> f_FDi, sc_uint<DATA_WIDTH> f_RD, bool f_bd_PE);
    
    SC_CTOR (fsm_pe) {
        SC_METHOD (prc_state_machine);
        sensitive << p_state << result_ld;
          //mac_calc local function to perform multiply and accumulate        
/*        SC_METHOD (mac_calc);*/
/*        sensitive << f_LR << f_FDi << f_RD << f_bd_PE;*/
        
        SC_METHOD(prc_output_comb);
        sensitive << clk.pos();
        sensitive << rst.pos();
                
    }
};    


    

