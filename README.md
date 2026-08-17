# Single-Cycle RV32I CPU

A single-cycle RISC-V CPU implemented in SystemVerilog, 
simulated with Icarus Verilog/GTKWave and deployed to an UPduino v3.1 
(iCE40 UP5K) FPGA. Architecture will be expanded to be pipelined.

## Features
- RV32I base integer instruction set (R/I/S/B formats)
- Single-cycle datapath following the Patterson & Hennessy design
- Verified in simulation and running on real FPGA hardware

## Architecture
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
