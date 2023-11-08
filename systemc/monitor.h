#include <fstream>
#include "systemc.h"

const int DATA_IN_WIDTH_m=16;
const int m_dim=8;

SC_MODULE (monitor) {
	sc_in<sc_uint<DATA_IN_WIDTH_m> >m_FDi[m_dim];
	sc_in<sc_uint<(2*DATA_IN_WIDTH_m)> > m_RD[m_dim], m_GD[m_dim];
	int RD_sense, FDi_sense, GD_sense;
	
	ofstream C_File;
	
	void c_file_writer ();
	void RD_input_assess();
	void FDi_input_assess();
	void GD_input_assess();
	
	SC_CTOR (monitor) {
		SC_METHOD (c_file_writer);
			for (int i=0; i<m_dim; i++) {
				sensitive << m_GD[i];
			}
			
		SC_METHOD (RD_input_assess);
			for (int i=0; i<m_dim; i++) {
				sensitive << m_RD[i];
			}
			
		SC_METHOD (FDi_input_assess);
			for (int i=0; i<m_dim; i++) {
				sensitive << m_FDi[i];
			}
			
		SC_METHOD (GD_input_assess);
			for (int i=0; i<m_dim; i++) {
				sensitive << m_GD[i];
			}
			
		C_File.open("C.txt");
	}
	// Close the file in the destructor: - monitor () {
	~ monitor(){
	C_File.close();
	 }
	 
};
