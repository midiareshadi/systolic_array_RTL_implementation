#include "monitor.h"

void monitor::c_file_writer(){

	for (int i=0; i<m_dim; i++) {
	C_File << m_GD[i] << ' ';
	if (i==3)
	C_File << endl;
	}
}
	
void monitor::RD_input_assess() {

	static int rdcount=0;

	rdcount ++;
	
	RD_sense= 2*(rdcount-1);
}

void monitor::GD_input_assess() {

	static int gdcount=0;

	gdcount ++;
	
	GD_sense=2*(gdcount-1);
} 

void monitor::FDi_input_assess() {

	static int fdicount=0;

	fdicount ++;
	
	FDi_sense=2*(fdicount-1);
} 
