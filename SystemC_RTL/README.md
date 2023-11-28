## Compiling SystemC code
To compile the code, specify the `SYSTEMC_HOME` and `LD_LIBRARY_PATH` paths:
```
export SYSTEMC_HOME=/home/systemc-2.3.3
export LD_LIBRARY_PATH=/home/systemc-2.3.3/lib-linuxaarch64
```
In the above example, SystemC is installed in the `home` directory.

Then we need to set the name of the SystemC library:
```
SYSTEMC_LINK=-lsystemc
```
Finally, `g++` compiles the project:
```
g++ \
-I /home/systemc-2.3.3/include \
-L /home/systemc-2.3.3/lib-linuxaarch64 \
-o exeFile *.cpp \
-lsystemc -lm
```
The created exe file will be named `exeFile` and can be run by:
```
./exeFile
```
## Running code in EDA playground
The source code is also available on an EDA playground, which provides a platform to compile and execute the code directly in your web browser.
Project link on EDA Playground: https://edaplayground.com/x/NzJf