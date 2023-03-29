[![License](https://img.shields.io/badge/License-GPL%203.0-blue.svg)](https://opensource.org/licenses/GPL-3.0)

# Moore.io Demo Project - [Part 1 - Installation and Simulation](https://www.youtube.com/channel/UCSqqT6JtmecBIoC_3DMLk0g)
Copyright 2023 [Datum Technology Corporation](https://datumtc.ca/)

## About
|  | Executive Summary |
|-|-|
| [![Moore.io Logo](https://www.mooreio.com/content/images/logo.png)](https://www.mooreio.com/) | The [Moore.io](https://www.mooreio.com/) Demo project demonstrates the power of the [Moore.io CLI](https://mio-cli.readthedocs.io/en/latest/commands.html) and [UVMx Template System](https://mio-cli.readthedocs.io/en/latest/code_templates.html).  Both are described thoroughly in the [Moore.io CLI User Manual](https://mio-cli.readthedocs.io/en/latest/index.html).  This demo series is broken into several Parts: this branch (`p1_start`) contains only the sample Design and Test Bench code.  The branch [`p1_end`](https://github.com/Datum-Technology-Corporation/mio_demo/tree/p1_end) contains the 'solution' for those playing along.  The [video](https://www.youtube.com/channel/UCSqqT6JtmecBIoC_3DMLk0g) for this Part is available on [Datum's YouTube Channel](https://www.youtube.com/channel/UCSqqT6JtmecBIoC_3DMLk0g).

The entire demo video series is available on [YouTube](https://www.youtube.com/channel/UCSqqT6JtmecBIoC_3DMLk0g).

## Contents
### 1 - Installation
1. Sign up for a free Moore.io user account: https://www.mooreio.com/register
2. Install the Moore.io CLI Client: `pip3 install mio-cli`
3. Download the Vivado self-extracting web installer (`Xilinx_Unified_2022.2_1014_8888_Lin64.bin`) from https://www.xilinx.com/support/download.html
4. Install Vivado: `./Xilinx_Unified_2022.2_1014_8888_Lin64.bin`
5. Set up an environment variable, `MIO_VIVADO_HOME`, to point to the Vivado installation location: `export MIO_VIVADO_HOME=.../bin`
6. Enter user credentials: `mio login`
7. Ensure that the Moore.io CLI Client is ready for work: `mio doctor`


### 2 - Import existing codebase
1. Clone the Moore.io demo Git repository for this video: `git clone https://github.com/Datum-Technology-Corporation/mio_demo.git -b p1_start mio_p1`
2. Import project

> 1. `cd mio_p1`
> 2. `mio init`

3. Import design

> 1. `pushd rtl/design`
> 2. `mio init`
> 3. `kwrite ip.yml`
> 4. `popd`

4. Import test bench

> 1. `pushd dv/tb`
> 2. `mio init`
> 3. `kwrite ip.yml`
> 4. `popd`


### 3 - Simulation
1. Run a single simulation (interactive mode): `mio sim tb -t hello_world -s 1 -w -v none`
2. Add 'hello_world' to test suite: `kwrite dv/tb/src/ts.yml`
3. Run a regression: `mio regr tb sanity`
