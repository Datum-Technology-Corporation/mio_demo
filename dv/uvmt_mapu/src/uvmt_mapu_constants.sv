// Copyright 2022 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_MAPU_CONSTANTS_SV__
`define __UVMT_MAPU_CONSTANTS_SV__


const int unsigned uvmt_mapu_default_clk_frequency            = 100_000_000; ///< Default clock frequency (100Mhz)
const int unsigned uvmt_mapu_default_startup_timeout          =      10_000; ///< Default Heartbeat Monitor startup timeout in ns
const int unsigned uvmt_mapu_default_heartbeat_period         =       1_000; ///< Default Heartbeat Monitor period in ns
const int unsigned uvmt_mapu_default_heartbeat_refresh_period =       5_000; ///< Default Heartbeat Monitor refresh period in ns
const int unsigned uvmt_mapu_default_simulation_timeout       =   1_000_000; ///< Default Watchdog Timer simulation timeout in ns


`endif // __UVMT_MAPU_CONSTANTS_SV__