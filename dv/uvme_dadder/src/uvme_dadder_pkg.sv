// Copyright 2022 Contributors
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_DADDER_PKG_SV__
`define __UVME_DADDER_PKG_SV__


// Doxygen Groups
/**
 * @defgroup uvme_dadder_pkg Decimal adder/subtracter Sub-System UVM Environment
 * @{
 * @defgroup uvme_dadder_comps Components
 * @defgroup uvme_dadder_misc  Miscellaneous
 * @defgroup uvme_dadder_obj   Objects
 * @defgroup uvme_dadder_seq   Sequences & Sequence Items
 * @}
 */


// Pre-processor macros
`include "uvm_macros.svh"
`include "uvml_macros.svh"
`include "uvml_sb_macros.svh"
`include "uvml_ral_macros.svh"
`include "uvma_clk_macros.svh"
`include "uvma_reset_macros.svh"
`include "uvma_dadder_cp_macros.svh"
`include "uvma_dadder_dp_in_macros.svh"
`include "uvma_dadder_dp_out_macros.svh"
`include "uvme_dadder_macros.svh"

// Interface(s)
`include "uvme_dadder_probe_if.sv"


 /**
 * Encapsulates all the types of the Decimal adder/subtracter Block UVM environment.
 */
package uvme_dadder_pkg;

   import uvm_pkg       ::*;
   import uvml_pkg      ::*;
   import uvml_sb_pkg   ::*;
   import uvml_ral_pkg  ::*;
   import uvma_clk_pkg  ::*;
   import uvma_reset_pkg::*;
   import uvma_dadder_cp_pkg    ::*;
   import uvma_dadder_dp_in_pkg ::*;
   import uvma_dadder_dp_out_pkg::*;

   // Constants / Structs / Enums
   `include "uvme_dadder_tdefs.sv"
   `include "uvme_dadder_constants.sv"

   // Objects
   `include "uvme_dadder_cfg.sv"
   `include "uvme_dadder_cntxt.sv"

   // Components
   `include "uvme_dadder_vsqr.sv"
   `include "uvme_dadder_prd.sv"
   `include "uvme_dadder_cov_model.sv"
   `include "uvme_dadder_env.sv"

   // Sequences
   `include "uvme_dadder_vseq_lib.sv"

endpackage : uvme_dadder_pkg


// Module(s) / Checker(s)
`ifdef UVME_DADDER_INC_CHKR
`include "uvme_dadder_chkr.sv"
`endif


`endif // __UVME_DADDER_PKG_SV__