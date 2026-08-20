# Single-Cycle RISC-V CPU

A single-cycle RISC-V CPU implemented in SystemVerilog, 
simulated with Icarus Verilog/GTKWave and deployed to an UPduino v3.1 
(iCE40 UP5K) FPGA. Architecture is currently being expanded to a 5-stage
pipelined RISC-V CPU.

## Features
- RV32I instruction set (R/I/S/B formats)
- Single-cycle datapath implemented according to "Computer Organization and Design" by David A. Patterson and John L. Hennessy
- Verified through waveform analysis and demonstrated functionality on FPGA with LED outputs

## Architecture
![Datapath diagram](docs/images/datapath.png)

## Getting Started
After installations of Icarus Verilog, GTKWave, and apio, the CPU can be simulated and then deployed on an FPGA with the following Linux workflow. For individual module simulations, replace the asterisk in src/*.sv with the module name and replace tb_top in tb/tb_top.sv with the correct testbench.
### Simulation
```bash
iverilog -g2012 -o sim.vvp src/*.sv tb/tb_top.sv
vvp sim.vvp
gtkwave waveform.vcd
```
![GTKWave Waveform](docs/images/waveform.png)
The waveform displays the successful execution of a series of instructions written into the instruction memory module.

### FPGA
```bash
apio build
apio upload
```
![CPU running on FPGA](docs/videos/R-I-L-Types.MOV)
![CPU running on FPGA](docs/videos/S-Type.MOV)
![CPU running on FPGA](docs/videos/B-Type.MOV)

## Challenges / Lessons Learned
As someone with no prior experience with computer architecture, starting this project felt pretty daunting until I found the right resources that I could gradually follow. After implementing each submodule and verifying them with their testbenches, most of the debugging process took place during top module simulation and deployment onto the FPGA. Though most issues encountered during the top module implementation & simulation could've been avoided with a deeper understanding of the RTL design, these gaps forced me to recognize how data is transferred from data memory to the register file when loading words (with the immediate mimicking a pointer) and how data is transferred in the opposite direction when storing words. This project has proved the importance of working through RTL design & implementation with a concrete understanding of every connection. 

After confirming the functionality of the CPU from waveform analysis, cramming the CPU onto the FPGA posed new challenges. One small issue was that the real pin numbers did not match the typical linear numbering from 1-20, which led to some digging in documentation to clarify. A bigger issue was that this basic CPU couldn't fit within the 5,000 lookup tables in the FPGA. This required moving some assign statements into clocked blocks. While this did delay some logic statements to occur at negative clock edges and therefore reduce the maximum clock speed that this program could run at, I was willing to take this tradeoff due to how the CPU's functionality remained intact and that my goal for this CPU was to be a starting point in my computer architecture journey. As I embark on implementing a pipelined CPU, I'm curious about finding new ways to approach RTL design and optimize code.

## License
MIT
