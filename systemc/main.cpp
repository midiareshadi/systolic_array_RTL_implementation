// File : main.cpp

// Includes
#include "systolic_array_nxn.h"
#include "systemc.h"
#include "driver.h"
#include <iostream>
#include <fstream>
#include "monitor.h"

using namespace std;

// Constants
const int DATA_IN_WIDTH=16;

// SC_main
int sc_main(int argc , char *argv[])
{

	//Signals
	sc_signal<bool> t_rst, t_result_ld;
	sc_signal<sc_uint<DATA_IN_WIDTH>> t_FDi[dim], t_FDo[dim];
	sc_signal<sc_uint<(2*DATA_IN_WIDTH)>> t_RD[dim], t_GD[dim];

	
	// Clock (”label”,period,duty_ratio,offset,start_value);	
	sc_clock t_clk ("clock", 20 , SC_NS, 0.5 , 10, SC_NS , true);
	
    
	// PE instance 
	systolic_array SA_inst("SA_instance");
		SA_inst.sa_clk(t_clk);
		SA_inst.sa_rst(t_rst);
		SA_inst.sa_result_ld(t_result_ld);
		
		for (int i =0; i< dim; i++) {
			SA_inst.sa_RD[i](t_RD[i]);
			SA_inst.sa_FDi[i](t_FDi[i]);
			SA_inst.sa_GD[i](t_GD[i]);
			SA_inst.sa_FDo[i](t_FDo[i]);
		}
    
	// Driver
	driver d1("Driver");
		d1.d_rst(t_rst);
		d1.d_result_ld(t_result_ld);
		for (int i =0; i< dim; i++) {
			d1.d_FDi[i](t_FDi[i]);
			d1.d_RD[i](t_RD[i]);
		}
		
	// Monitor 
	monitor m1 ("monitor");
	for (int i =0; i< dim; i++) {
		m1.m_GD[i](t_GD[i]);
		m1.m_RD[i](t_RD[i]);
		m1.m_FDi[i](t_FDi[i]);	
	}
	
	// VCD file
	sc_trace_file *tf=sc_create_vcd_trace_file("VCD_trace_file");
		sc_trace(tf, t_clk, "clk");
		sc_trace(tf, t_rst, "rst");
		sc_trace(tf, t_result_ld, "result_ld");

	// Systolic array parameters
		for (int i =0; i< dim; i++) {

			string RD_gtk = "RD[" + std::to_string(i) + "]";
			sc_trace(tf, t_RD[i], RD_gtk.c_str());

			string FDi_gtk = "FDi[" + std::to_string(i) + "]";
			sc_trace(tf, t_FDi[i], FDi_gtk.c_str());

			string GD_gtk = "GD[" + std::to_string(i) + "]";
			sc_trace(tf, t_GD[i], GD_gtk.c_str());

			string FDo_gtk = "FDo[" + std::to_string(i) + "]";
			sc_trace(tf, t_FDo[i], FDo_gtk.c_str());
		}
		
		// Other systolic array parameters
		sc_trace(tf, SA_inst.V[8], "SA_inst.V[8]");

		
		// PE parameters
		for (int i =0; i< dim*dim; i++) {
			//string PE_RD_gtk = "pe_inst[" + std::to_string(i) + "].RD" + std::to_string(i) +"";
			//sc_trace(tf, SA_inst.pe_inst[i].RD, PE_RD_gtk.c_str());
			

			string PE_GD_gtk = "pe_inst[" + std::to_string(i) + "].GD" + std::to_string(i) +"";
			sc_trace(tf, SA_inst.pe_inst[i].RD, PE_GD_gtk.c_str());		

			string PE_state_gtk = "pe_inst[" + std::to_string(i) + "].state_status" + std::to_string(i) +"";	
			sc_trace(tf, SA_inst.pe_inst[i].state_status, PE_state_gtk.c_str());
		}

		
	//Start
	sc_start(((4*dim)-1)*20, SC_NS);
	
	// Close VCD
	sc_close_vcd_trace_file(tf);
	
	//----------------Cout------------------
	cout<<"--------------------Accelergy values ---------------------"<<endl;
	//for (int i=0; i<(dim*dim); i++) {
	//cout << "pe_inst["<<i<<"].LR_Read= "<<SA_inst.pe_inst[i].LR_Read<<endl;
	//cout << "pe_inst["<<i<<"].LR_Write= "<<SA_inst.pe_inst[i].LR_Write<<endl;
	//cout << "pe_inst["<<i<<"].mac_Opr= "<<SA_inst.pe_inst[i].mac_Opr<<endl;
	//cout << "................"<<endl;
	//}
	cout << "RD_sense= "<<m1.RD_sense<<endl;
	cout << "GD_sense= "<<m1.GD_sense<<endl;
	cout << "FDi_sense= "<<m1.FDi_sense<<endl;
	// ----------------------------------------------------------------------
	
	
	return (0);
}
