echo "### Building ..........................................."

# Removing previous build
rm -f exeFile

# Removing previous generated vcd file
rm -f *.vcd

export SYSTEMC_HOME=/home/systemc-2.3.3
export LD_LIBRARY_PATH=/home/systemc-2.3.3/lib-linuxaarch64

# Set the path to the SystemC header files
#SYSTEMC_INCLUDE=-I /home/mx/Downloads/temp/systemc-2.3.3/include

# Set the path to the SystemC library
#SYSTEMC_LIB=-L /home/mx/Downloads/temp/systemc-2.3.3/lib-linux64

# Set the name of the SystemC library
SYSTEMC_LINK=-lsystemc

# g++ command
# g++ \
# $SYSTEMC_INCLUDE \
# $SYSTEMC_LIB \
# -o exeFile *.cpp \
# $SYSTEMC_LINK -lm

echo "......................Start building:...................."

g++ \
-I /home/systemc-2.3.3/include \
-L /home/systemc-2.3.3/lib-linuxaarch64 \
-o exeFile *.cpp \
-lsystemc -lm

echo "..................Running exe file......................."
# Running exe file
./exeFile

# Description
# ---------------
# $SYSTEMC_INCLUDE => Adding the include path for the SystemC header files to the compiler options

# $SYSTEMC_LIB =>  Adding the SystemC library path to the compiler options

# SYSTEMC_LINK =>linking the program with the SystemC library

# mac os: systemc-2.3.3/include
# /home/systemc-2.3.3/lib-linuxaarch64 \


