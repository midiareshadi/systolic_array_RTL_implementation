#### RTL implementation of baseline systolic array
This repository provides an RTL implementation of a fundamental systolic array, a core computation unit for matrix multiplication.
Systolic arrays, characterized by their ability to perform multiplication and addition operations in a synchronized manner, achieve low computation time and high efficiency.
The systolic array is described in both Verilog and SystemC. The SystemC code is parametric, allowing the dimension of PE arrays to be specified as constants. In contrast, the Verilog code is written for a fixed base 2x2 dimension. While the IVerilog compiler supports parametric descriptions, this code fails to compile correctly when using the Isim compiler. However, the Verilog code is synthesizable and has been verified using Vivado.
The directory structure is:
```
.
|-- Accelergy_Configuration
|   `-- systolic_array_2x2
|-- systemc
|   |-- input_matrices
|   `-- vcd_file
`-- verilog
    `-- systolic_array_2x2
    ```