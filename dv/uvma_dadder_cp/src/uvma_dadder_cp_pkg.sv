// Copyright 2022 Contributors
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_DADDER_CP_PKG_SV__
`define __UVMA_DADDER_CP_PKG_SV__


// Doxygen Groups
/**
 * @defgroup uvma_dadder_cp_pkg Decimal adder/subtracter Block Control Plane UVM Agent
 * @{
 * @defgroup uvma_dadder_cp_comps Components
 * @defgroup uvma_dadder_cp_misc  Miscellaneous
 * @defgroup uvma_dadder_cp_obj   Objects
 * @defgroup uvma_dadder_cp_seq   Sequences & Sequence Items
 * @}
 */


// Pre-processor macros
`include "uvm_macros.svh"
`include "uvml_macros.svh"
`include "uvml_logs_macros.svh"
`include "uvma_dadder_cp_macros.svh"

// Interface(s)
`ifndef UVMA_DADDER_CP_NO_IF
`include "uvma_dadder_cp_if.sv"
`endif


/**
 * Encapsulates all the types needed for a UVM agent capable of driving and monitoring a Decimal adder/subtracter Block Control Plane interface.
 * @ingroup uvma_dadder_cp_pkg
 */
package uvma_dadder_cp_pkg;

   import uvm_pkg      ::*;
   import uvml_pkg     ::*;
   import uvml_logs_pkg::*;

   // Constants / Structs / Enums
   `include "uvma_dadder_cp_tdefs.sv"
   `include "uvma_dadder_cp_constants.sv"

   // Objects
   `include "uvma_dadder_cp_cfg.sv"
   `include "uvma_dadder_cp_cntxt.sv"

   // High-level transactions
   `include "uvma_dadder_cp_seq_item.sv"
   `include "uvma_dadder_cp_mon_trn.sv"

   // Agent components
   `include "uvma_dadder_cp_sqr.sv"
   `include "uvma_dadder_cp_drv.sv"
   `include "uvma_dadder_cp_mon.sv"
   `include "uvma_dadder_cp_cov_model.sv"
   `include "uvma_dadder_cp_logger.sv"
   `include "uvma_dadder_cp_agent.sv"

   // Sequences
   `include "uvma_dadder_cp_seq_lib.sv"

endpackage : uvma_dadder_cp_pkg


// Module(s) / Checker(s)
`ifdef UVMA_DADDER_CP_INC_IF_CHKR
`include "uvma_dadder_cp_if_chkr.sv"
`endif


`endif // __UVMA_DADDER_CP_PKG_SV__