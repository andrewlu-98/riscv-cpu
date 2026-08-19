# Single-Cycle RISC-V CPU

A single-cycle RISC-V CPU implemented in SystemVerilog, 
simulated with Icarus Verilog/GTKWave and deployed to an UPduino v3.1 
(iCE40 UP5K) FPGA. Architecture is currently being expanded to a 5-stage
pipelined RISC-V CPU.

## Features
- RV32I instruction set (R/I/S/B formats)
- Single-cycle datapath implemented according to "Computer Organization and Design" by David A. Patterson and John L. Hennessy
- Verified through waveform analysis and demonstrated functionality on FPGA with LED outputs

## Architecture of Single-Cycle RISC-V CPU
![Datapath diagram](docs/images/datapath.png)

## Getting Started
### Simulation
```bash
iverilog -g2012 -o sim.vvp src/*.sv tb/tb_top.sv
vvp sim.vvp
gtkwave waveform.vcd
```

### FPGA (UPduino v3.1)
```bash
apio build
apio upload
```

## Demo
![CPU running on hardware](docs/images/demo.gif)

## Known Limitations / Lessons Learned
- ...

## License
MIT
