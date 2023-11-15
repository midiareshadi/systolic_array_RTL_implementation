#### RTL implementation of baseline systolic array
This repository provides an RTL implementation of a fundamental systolic array, a core computation unit for matrix multiplication. Systolic arrays are known for their ability to perform multiplication and addition operations at maximum concurrency, achieving low computation time and high efficiency.

I described a baseline systolic array in both Verilog and SystemC. The SystemC code is parametric, allowing the dimension of PE arrays to be specified as constants. In contrast, the Verilog code is written for a fixed base 2x2 dimension. While the iVerilog (Icarus) compiler supports parametric descriptions, this code fails to compile correctly when using the ISim (ISE) compiler. However, the Verilog code is synthesizable and has been verified using Vivado.
The directory structure is:
```
.
|-- Accelergy_Configuration
|   `-- systolic_array_2x2
|       |-- input
|       `-- output
|-- systemc
|   |-- input_matrices
|   `-- vcd_file
`-- verilog
    `-- systolic_array_2x2
        |-- input_matrices
        `-- vcd_file
```