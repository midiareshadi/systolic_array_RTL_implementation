// File : driver.h

#include <systemc.h>
#include <iostream>
#include <fstream>
#include <sstream>
#include <string>

using namespace std;

//Constants
const int DATA_IN_WIDTH_D=16;
const int d_dim=8;

SC_MODULE(driver) {

	// Output ports
	sc_out<sc_uint<DATA_IN_WIDTH_D>> d_FDi[d_dim];
	sc_out<sc_uint<(2*DATA_IN_WIDTH_D)>> d_RD[d_dim];
	sc_out<bool> d_rst, d_result_ld;
        
	// Parameters
	sc_uint<DATA_IN_WIDTH_D> p_FDi[d_dim];
	sc_uint<(2*DATA_IN_WIDTH_D)> p_RD[d_dim];
	
	string file_line;
	
	// ifstream declaration
	ifstream A_File, B_File;
	
	
	// Driver function
	void prc_driver_data_in_A();
	void prc_driver_data_in_B();
	void prc_driver_load_in();

	SC_CTOR(driver) {
	SC_THREAD(prc_driver_data_in_A);
	SC_THREAD(prc_driver_data_in_B);
	SC_THREAD(prc_driver_load_in);
          
	// File opening check
          A_File.open("A_TB.txt");
          B_File.open("B_TB.txt");
          if (!(A_File || B_File)) {
              cout <<"ERROR: Unable to open vector file"<<endl;
              sc_stop(); // Stop simulation.
          }
	
          
  } //End of constructor
	
	// Close the file in the destructor:
	~driver() {
	A_File.close();
	B_File.close();
	} // End od driver destructure
};
