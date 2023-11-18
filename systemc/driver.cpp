// File : driver.cpp

#include "driver.h"

sc_time data_delay(20, SC_NS);
sc_time init_Data_delay(3 , SC_NS);

string line;

//A file read	
void driver::prc_driver_data_in_A(){  

	wait (init_Data_delay);
	// FDi assignment
	while (getline(A_File, line)) {
		        if (line.empty() || line[0] == '#')
		            continue;
			istringstream iss(line);
			for (int i=0; i<d_dim; i++){
				iss >> p_FDi[i];
			}
			
			for (int i=0; i<d_dim; i++){
				d_FDi[i].write(p_FDi[i]);
			}
			wait (data_delay);
        	}
        	
	A_File.close();

}// End of function

// B File read 
void driver::prc_driver_data_in_B(){ 

	wait (init_Data_delay);
	
	// RD assignment
	while (getline(B_File, line)) {
		        if (line.empty() || line[0] == '#')
		            continue;
			istringstream iss(line);
			for (int i=0; i<d_dim; i++){
				iss >> p_RD[i];
				d_RD[i].write(p_RD[i]);
			}
			wait (data_delay);		
        	}

	B_File.close();

}// End of function

void driver::prc_driver_load_in(){

	d_result_ld.write(0);
	d_rst.write(1);
	
		//Reset
        wait(3 , SC_NS);
        d_rst.write(0);
        
        // result_ld
        wait ((((3*d_dim)-1)*20) , SC_NS);
        d_result_ld.write(1);
        wait(20 , SC_NS);
        d_result_ld.write(0);

}// End of function 
