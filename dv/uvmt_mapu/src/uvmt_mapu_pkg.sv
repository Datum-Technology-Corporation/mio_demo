// Copyright 2022 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_MAPU_PKG_SV__
`define __UVMT_MAPU_PKG_SV__


/**
 * @defgroup uvmt_mapu_pkg Matrix APU Block UVM Test Bench
 * @{
 * @defgroup uvmt_mapu_misc   Miscellaneous
 * @defgroup uvmt_mapu_tb     Test Bench
 * @defgroup uvmt_mapu_tests  Tests
 * @}
 */


// Pre-processor macros
`include "uvm_macros.svh"
`include "uvmx_macros.svh"
`include "uvma_clk_macros.svh"
`include "uvma_reset_macros.svh"
`include "uvma_mapu_macros.svh"
`include "uvme_mapu_macros.svh"
`include "uvmt_mapu_macros.svh"

// Time units and precision for this test bench
timeunit       1ns;
timeprecision  1ps;


/**
 * Encapsulates all the types of the Matrix APU Block UVM Test Bench.
 */
package uvmt_mapu_pkg;

   import uvm_pkg       ::*;
   import uvmx_pkg      ::*;
   import uvml_sb_pkg   ::*;
   import uvma_clk_pkg  ::*;
   import uvma_reset_pkg::*;
   import uvma_mapu_pkg ::*;
   import uvme_mapu_pkg ::*;

   // Constants / Structs / Enums
   `include "uvmt_mapu_tdefs.sv"
   `include "uvmt_mapu_constants.sv"

   // Tests
   `include "uvmt_mapu_test_cfg.sv"
   `include "uvmt_mapu_base_test.sv"
   `include "uvmt_mapu_fix_stim_test.sv"
   `include "uvmt_mapu_fix_ill_stim_test.sv"
   `include "uvmt_mapu_rand_stim_test.sv"
   `include "uvmt_mapu_rand_ill_stim_test.sv"

endpackage : uvmt_mapu_pkg


// Module(s) / Checker(s)
`include "uvmt_mapu_dut_wrap.sv"
`include "uvmt_mapu_tb.sv"


`endif // __UVMT_MAPU_PKG_SV__
