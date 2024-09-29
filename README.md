# RISCBlade: A Custom RISC-V Based Architecture

## Overview
RISCBlade is a custom-designed RISC-V-based architecture with ARM-like functionality, developed using Quartus. The project includes a Python interpreter that converts Python scripts into machine code compatible with the RISCBlade architecture. This makes RISCBlade a versatile platform for educational, research, and development purposes in hardware design, instruction set architecture, and embedded systems.

RISCBlade was developed as part of an academic project with the goal of designing an architecture capable of running ARM-like instructions, with the added flexibility of converting high-level Python code into machine code that could run on custom hardware.

## Features
- **Custom RISC-V Instruction Set**: Implements a subset of the RISC-V instruction set with modifications inspired by ARM architecture.
- **Python to Machine Code Interpreter**: Converts high-level Python code into machine instructions compatible with RISCBlade.
- **Quartus Integration**: Full Quartus support for hardware simulation and testing.
- **Design Documentation**: Detailed design documentation outlining the development process, architecture design, and testing phases.
- **Modular Design**: Architecture and supporting scripts are modular, making it easy to extend functionality.

## Project Structure
- **Python Scripts**: Contains the Python interpreter that converts Python code into machine instructions for RISCBlade.
- **Design**: This directory contains the Master Design Document and all design-related files, including design journals and high-level architecture descriptions.
- **Implementation**: All Verilog source code for the custom RISC-V architecture.
- **Meeting Notes**: Documentation of team meetings, key design decisions, and milestones throughout the project.

## How to Use RISCBlade

### 1. Python to Machine Code Translation
The Python interpreter provided in the `Python Scripts` folder allows you to write basic Python code, which is then converted into machine-level instructions compatible with RISCBlade.

#### Usage:
1. Write your Python script using supported commands.
2. Run the interpreter to generate machine code.
3. Load the machine code into Quartus for execution on the RISCBlade architecture.

### 2. Quartus Simulation
RISCBlade is fully compatible with Quartus, allowing users to simulate the hardware and run machine-level instructions.

#### Steps:
1. Open the project in Quartus using the provided project files (`.qpf`).
2. Compile the Verilog code for the RISCBlade architecture.
3. Load the generated machine code into the architecture for testing and validation.

## Documentation
The Master Design Document outlines the entire design process, including:
- Architecture design decisions
- Instruction set modifications
- Python interpreter functionality
- Hardware simulation and testing

For detailed information, please refer to the `design/MasterDesignDocument.pdf`.

## Future Improvements
- **Extended Instruction Set**: Implement additional RISC-V and ARM instructions to increase functionality.
- **Optimized Python Interpreter**: Enhance the interpreter for more efficient translation and support for complex Python constructs.
- **Hardware Testing**: Move beyond simulation to test the architecture on physical hardware platforms.

## License
This project is licensed under the MIT License - see the LICENSE file for details.
