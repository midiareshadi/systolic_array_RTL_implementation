// File: systolic_array_nxn.h
#include "systemc.h"
#include "fsm_pe.h"

//Constants
const int DATA_WIDTH_SA = 16;
const int dim = 8;
    

SC_MODULE(systolic_array) {
    
	//Ports
	sc_in<sc_uint<DATA_WIDTH_SA>> sa_FDi[dim];
	sc_in<sc_uint<(2*DATA_WIDTH_SA)>> sa_RD[dim];
	
	sc_in<bool> sa_clk,sa_rst,sa_result_ld;
	
	sc_out<sc_uint<DATA_WIDTH_SA>> sa_FDo[dim];
	sc_out<sc_uint<(2*DATA_WIDTH_SA)>> sa_GD[dim];
	        
    
	//Signals
	sc_signal<sc_uint<DATA_WIDTH>> H[(2*(dim*dim))-1];
	sc_signal<sc_uint<(2*DATA_WIDTH_SA)>> V[(2*(dim*dim))-1];
	sc_signal<sc_uint<(2*DATA_WIDTH_SA)>> sa_result[(dim*dim)];

	//Instantiation array of module objects
	sc_vector<fsm_pe> pe_inst;

    
	// port assignment
	void port_assignment(){
		
	//input ports
		// sa_RD
		for (int i=0; i<dim ; i++) {
			V[i]=sa_RD[i];
		}

		// sa_FDi
		for (int i=0; i<dim ; i++) {
			H[i*dim]=sa_FDi[i];
		}

	//output ports
		// sa_GD
		for (int i=0; i<dim ; i++) {
			sa_GD[i]=V[(dim*(dim-1))+((dim*dim)-1)+i];
		}

		// sa_FDo
		for (int i=0; i<dim ; i++) {
			sa_FDo[i]=H[((dim-1)+((dim)*i)+((dim*dim)-1))];
	// other stuffs
	     
		}

		
	}	
    
    SC_CTOR (systolic_array):
	pe_inst("pe_instance",(dim*dim)){
	
	// clock & result_ld & rst & 
	for (int i=0; i<(dim*dim) ; i++) {
		pe_inst[i].clk(sa_clk);
		pe_inst[i].rst(sa_rst);
		pe_inst[i].result_ld(sa_result_ld);
		pe_inst[i].result(sa_result[i]);
	}

	// RD & FDi
	for (int i=0; i<(dim*dim) ; i++) {
		pe_inst[i].RD(V[i]);
		pe_inst[i].FDi(H[i]);
	}
	
	// FDo
	for (int i=0; i<(dim*dim) ; i++) {
		if ((i % dim) != (dim-1))
			pe_inst[i].FDo(H[i+1]);
		else
			pe_inst[i].FDo(H[i+((dim*dim)-1)]);
	}

	// GD
	for (int i=0; i<(dim*(dim-1)) ; i++) {
		pe_inst[i].GD(V[i+dim]);
	}

	// GD, Cont, ...
	for (int i=(dim*(dim-1)); i<(dim*dim) ; i++) {
		pe_inst[i].GD(V[i+((dim*dim)-1)]);
	}

		
	//SC_METHOD
		SC_METHOD (port_assignment);
		for (int i=0; i<dim ; i++) {
		sensitive   << sa_RD[i];
		sensitive   << sa_FDi[i];
		}
		
		for (int i=0; i<dim ; i++) {
		sensitive	<< V[(dim*(dim-1) + i +((dim*dim)-1))];	
		}
	}

};    
