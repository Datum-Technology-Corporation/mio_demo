// Copyright 2022 Contributors
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_DADDER_PKG_SV__
`define __UVMT_DADDER_PKG_SV__


// Doxygen Groups
/**
 * @defgroup uvmt_dadder_pkg Decimal adder/subtracter Block UVM Test Bench
 * @{
 * @defgroup uvmt_dadder_misc   Miscellaneous
 * @defgroup uvmt_dadder_tb     Test Bench
 * @defgroup uvmt_dadder_tests  Tests
 * @}
 */


// Pre-processor macros
`include "uvm_macros.svh"
`include "uvml_macros.svh"
`include "uvml_logs_macros.svh"
`include "uvma_clk_macros.svh"
`include "uvma_reset_macros.svh"
`include "uvma_dadder_cp_macros.svh"
`include "uvma_dadder_dp_in_macros.svh"
`include "uvma_dadder_dp_out_macros.svh"
`include "uvme_dadder_macros.svh"
`include "uvmt_dadder_macros.svh"

// Time units and precision for this test bench
timeunit       1ns;
timeprecision  1ps;

// Interface(s)


/**
 * Encapsulates all the types of the Decimal adder/subtracter Block UVM Test Bench.
 */
package uvmt_dadder_pkg;

   import uvm_pkg       ::*;
   import uvml_pkg      ::*;
   import uvml_logs_pkg ::*;
   import uvml_sb_pkg   ::*;
   import uvml_ral_pkg  ::*;
   import uvma_clk_pkg  ::*;
   import uvma_reset_pkg::*;
   import uvma_dadder_cp_pkg    ::*;
   import uvma_dadder_dp_in_pkg ::*;
   import uvma_dadder_dp_out_pkg::*;
   import uvme_dadder_pkg       ::*;

   // Constants / Structs / Enums
   `include "uvmt_dadder_tdefs.sv"
   `include "uvmt_dadder_constants.sv"

   // Tests
   `include "uvmt_dadder_test_cfg.sv"
   `include "uvmt_dadder_base_test.sv"
   `include "uvmt_dadder_rand_stim_test.sv"

endpackage : uvmt_dadder_pkg


// Module(s) / Checker(s)
`include "uvmt_dadder_dut_wrap.sv"
`include "uvmt_dadder_dut_chkr.sv"
`include "uvmt_dadder_tb.sv"


`endif // __UVMT_DADDER_PKG_SV__