// Copyright 2023 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_MAPU_PKG_SV__
`define __UVMA_MAPU_PKG_SV__


/**
 * @defgroup uvma_mapu_pkg Matrix APU UVM Agent
 * @{
 * @defgroup uvma_mapu_comps Components
 * @defgroup uvma_mapu_misc  Miscellaneous
 * @defgroup uvma_mapu_obj   Objects
 * @defgroup uvma_mapu_seq   Sequences & Sequence Items
 * @}
 */


// Pre-processor macros
`include "uvm_macros.svh"
`include "uvmx_macros.svh"
`include "uvml_math_macros.svh"
`include "uvma_mapu_macros.svh"

// Interface(s)
`include "uvma_mapu_if.sv"


/**
 * Encapsulates all the types needed for a UVM agent capable of driving and monitoring a Matrix APU interface.
 * @ingroup uvma_mapu_pkg
 */
package uvma_mapu_pkg;

   import uvm_pkg      ::*;
   import uvmx_pkg     ::*;
   import uvml_math_pkg::*;

   // Constants / Structs / Enums
   `include "uvma_mapu_tdefs.sv"
   `include "uvma_mapu_constants.sv"

   // Objects
   `include "uvma_mapu_cfg.sv"
   `include "uvma_mapu_cntxt.sv"

   // Sequence Items and Monitor Transactions
   `include "uvma_mapu_seq_item.sv"
   `include "uvma_mapu_cp_seq_item.sv"
   `include "uvma_mapu_dpi_seq_item.sv"
   `include "uvma_mapu_dpo_seq_item.sv"
   `include "uvma_mapu_mon_trn.sv"
   `include "uvma_mapu_cp_mon_trn.sv"
   `include "uvma_mapu_dpi_mon_trn.sv"
   `include "uvma_mapu_dpo_mon_trn.sv"

   // Components
   `include "uvma_mapu_vsqr.sv"
   `include "uvma_mapu_cp_drv.sv"
   `include "uvma_mapu_dpi_drv.sv"
   `include "uvma_mapu_dpo_drv.sv"
   `include "uvma_mapu_drv.sv"
   `include "uvma_mapu_cp_mon.sv"
   `include "uvma_mapu_dpi_mon.sv"
   `include "uvma_mapu_dpo_mon.sv"
   `include "uvma_mapu_mon.sv"
   `include "uvma_mapu_logger.sv"
   `include "uvma_mapu_agent.sv"

   // Sequences
   `include "uvma_mapu_base_vseq.sv"
   `include "uvma_mapu_trn_base_vseq.sv"
   `include "uvma_mapu_mon_vseq.sv"
   `include "uvma_mapu_idle_vseq.sv"
   `include "uvma_mapu_drv_in_vseq.sv"
   `include "uvma_mapu_drv_out_vseq.sv"

endpackage : uvma_mapu_pkg


`endif // __UVMA_MAPU_PKG_SV__