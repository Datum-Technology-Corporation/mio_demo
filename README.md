[![License](https://img.shields.io/badge/License-GPL%203.0-blue.svg)](https://opensource.org/licenses/GPL-3.0)

# [Moore.io](https://www.mooreio.com/) Demo Project
Copyright 2023 [Datum Technology Corporation](https://datumtc.ca/)

## Executive Summary
|  | **[From Spreadsheet to UVM Simulation](https://mio-cli.readthedocs.io/en/latest/code_templates.html)** |
|-|-|
| [![Moore.io Logo](https://www.mooreio.com/content/images/logo.png)](https://www.mooreio.com/) | The [Moore.io](https://www.mooreio.com/) Demo project demonstrates the power of the [Moore.io CLI](https://mio-cli.readthedocs.io/en/latest/commands.html) and [UVMx](https://datumtc.ca/products/uvmx).  Both are used to fully verify a telecom-grade FPGA design in record time by generating >90% of the codebase directly from a spreadsheet specification and using a free simulator (Vivado).  This demo is broken into several Parts and this branch (`main`) contains all code for all parts.  The entire video series is available on [YouTube](https://www.youtube.com/channel/UCSqqT6JtmecBIoC_3DMLk0g).

## [Part 1 - Installation and Simulation](https://github.com/Datum-Technology-Corporation/mio_demo/tree/p1_start)
Set up a new user and workstation for `mio` and [Xilinx® Vivado™ ML Edition](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools.html), import existing Design and Test Bench code, and run UVM simulations and regressions.

## [Part 2 - Block level design UVM verification](https://github.com/Datum-Technology-Corporation/mio_demo/tree/p2_start)
Verify a matrix APU by starting with a pin list in a spreadsheet and finishing with a set of constrained-random regressions with prediction, scoreboarding and self-checking tests.

## Part 3 - UVM agent for a custom interface

## Part 4 - Sub-System design UVM verification

## Part 5 - FPGA design UVM verification
