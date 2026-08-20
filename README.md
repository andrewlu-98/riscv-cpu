

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
https://github.com/user-attachments/assets/baee744b-ccb3-421a-a821-c558eb897a09

The video above displays the output of 6 LEDs mapped to the CPU's writeback multiplexer (mux_from_data_top), showing the computed values being written back into the register file. The CPU steps through R, I, and L type instructions predetermined in the instruction memory. For instance, the first LED pattern correctly outputs the instruction at mem[4], which executes add x13, x16, x25 and instantly outputs 001011 (11) as expected from the stored values of 6 and 5 in the read registers x16 and x25, respectively. In the final two clock cycles, the CPU executes two L-Type instructions, taking values from the data memory and displaying the preset values of 56 (111000) and 57 (111001).

https://github.com/user-attachments/assets/79e45d1c-5ee0-43f8-9947-7b15e7aad049

The 6 LEDs are now mapped to read_data2_top (the data being stored), where the CPU outputs two consecutive sw (store word) instructions. The LEDs correctly display values extracted from registers x15 and x14, which are 30 (011110) and 20 (010100), respectively.

https://github.com/user-attachments/assets/527aa49d-5643-4116-8128-c9413cd19a5f

To visualize what a B-type instruction does, the LEDs are remapped to the output of the program counter (PC_top[7:2]). Upon hitting the beq x9, x9, 12 instruction, the ALU compares the two registers and evaluates the condition as true. We see that the value jumps from 16 (00010000, 2 least significant bits not shown in video) to 40 (00101000), which is due to the shift left 1 block. 

## Challenges / Lessons Learned
As someone with no prior experience with computer architecture, starting this project felt pretty daunting until I found the right resources that I could gradually follow. After implementing each submodule and verifying them with their testbenches, most of the debugging process took place during top module simulation and deployment onto the FPGA. Though most issues encountered during the top module implementation & simulation could've been avoided with a deeper understanding of the RTL design, these gaps forced me to recognize how data is transferred from data memory to the register file when loading words (with the immediate mimicking a pointer) and how data is transferred in the opposite direction when storing words. This project has proved the importance of working through RTL design & implementation with a concrete understanding of every connection. 

After confirming the functionality of the CPU from waveform analysis, cramming the CPU onto the FPGA posed new challenges. One small issue was that the real pin numbers did not match the typical linear numbering from 1-20, which led to some digging in documentation to clarify. A bigger issue was that this basic CPU couldn't fit within the 5,000 lookup tables in the FPGA. This required moving some assign statements into clocked blocks. While this did delay some logic statements to occur at negative clock edges and therefore reduce the maximum clock speed that this program could run at, I was willing to take this tradeoff due to how the CPU's functionality remained intact and that my goal for this CPU was to be a starting point in my computer architecture journey. One more issue I encountered was the redundancy of the shift left block in the RTL design, as the bit that was shifted in was already accounted for in my immediate generator module. As I embark on implementing a pipelined CPU, I'm curious about finding new ways to approach RTL design and optimize code.

## License
MIT
