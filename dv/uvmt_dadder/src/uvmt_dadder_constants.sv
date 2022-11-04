// Copyright 2022 Contributors
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_DADDER_CONSTANTS_SV__
`define __UVMT_DADDER_CONSTANTS_SV__


const int unsigned uvmt_dadder_default_startup_timeout     =     10_000; ///< Default Heartbeat Monitor startup timeout in ns
const int unsigned uvmt_dadder_default_heartbeat_period    =      1_000; ///< Default Heartbeat Monitor period in ns
const int unsigned uvmt_dadder_default_simulation_timeout  = 20_000_000; ///< Default Watchdog Timer simulation timeout in ns


`endif // __UVMT_DADDER_CONSTANTS_SV__