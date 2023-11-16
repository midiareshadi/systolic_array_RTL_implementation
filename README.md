## Systolic Array 
RTL implementation of baseline systolic array
This repository provides an RTL implementation of a fundamental systolic array, a core computation unit for matrix multiplication. Systolic arrays are known for their ability to perform multiplication and addition operations at maximum concurrency, achieving low computation time and high efficiency.

### RTL implementation
I described a baseline systolic array in both Verilog and SystemC. The SystemC code is parametric, allowing the dimensions of PE arrays to be specified as constants. In contrast, the Verilog code is written for a fixed base 2x2 dimension. While the iVerilog (Icarus) compiler supports parametric descriptions, this code fails to compile correctly when using the ISim (ISE) compiler. However, the Verilog code is synthesizable and has been verified using Vivado.
The directory tree is shown as:
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
### Using Accelergy
The Accelergy_Configuration folder includes the architecture definition and activity file (action count) of a 2x2 systolic array which are defined in YAML file format. We can use [Accelergy](https://accelergy.mit.edu/) to estimate the energy consumption. To run the Accelergy configuration, first, the Accelergy needs to be installed using `pip install .`. To run Accelergy configuration:
```
cd Accelergy_Configuration/systolic_array_2x2
accelergy -o output/ input/*.yaml input/components/*.yaml -v 1
```

### PE state diagram
``` mermaid
graph LR
A((reset)) --> B((calc_0))
B((calc_0)) --result_ld = 1--> C((ld_result))
B((calc_0)) --result_ld = 0--> D((calc_1))
D((calc_1)) --result_ld = 0--> B((calc_0))
D((calc_1)) --result_ld = 1--> C((ld_result))
C((ld_result)) --> E((drain_0))
E((drain_0)) --> F((drain_1))
F((drain_1)) --> E((drain_0))
```
