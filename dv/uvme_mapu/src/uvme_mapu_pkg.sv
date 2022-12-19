// Copyright 2022 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_MAPU_PKG_SV__
`define __UVME_MAPU_PKG_SV__


/**
 * @defgroup uvme_mapu_pkg Matrix APU Sub-System UVM Environment
 * @{
 * @defgroup uvme_mapu_comps Components
 * @defgroup uvme_mapu_misc  Miscellaneous
 * @defgroup uvme_mapu_obj   Objects
 * @defgroup uvme_mapu_seq   Sequences & Sequence Items
 * @}
 */


// Pre-processor macros
`include "uvm_macros.svh"
`include "uvmx_macros.svh"
`include "uvml_math_macros.svh"
`include "uvml_sb_macros.svh"
`include "uvma_mapu_macros.svh"
`include "uvme_mapu_macros.svh"

// Interface(s)
`include "uvme_mapu_probe_if.sv"


 /**
 * Encapsulates all the types of the Matrix APU Block UVM environment.
 */
package uvme_mapu_pkg;

   import uvm_pkg      ::*;
   import uvmx_pkg     ::*;
   import uvml_math_pkg::*;
   import uvml_sb_pkg  ::*;
   import uvma_mapu_pkg::*;

   // Constants / Structs / Enums
   `include "uvme_mapu_tdefs.sv"
   `include "uvme_mapu_constants.sv"

   // Objects
   `include "uvme_mapu_cfg.sv"
   `include "uvme_mapu_cntxt.sv"

   // Components
   `include "uvme_mapu_vsqr.sv"
   `include "uvme_mapu_prd.sv"
   `include "uvme_mapu_cov_model.sv"
   `include "uvme_mapu_env.sv"

   // Sequences
   `include "uvme_mapu_vseq_lib.sv"

endpackage : uvme_mapu_pkg


// Module(s) / Checker(s)
`include "uvme_mapu_chkr.sv"


`endif // __UVME_MAPU_PKG_SV__
