// 
// Copyright 2020 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// 
// Licensed under the Solderpad Hardware License v 2.1 (the “License”); you may
// not use this file except in compliance with the License, or, at your option,
// the Apache License version 2.0. You may obtain a copy of the License at
// 
//     https://solderpad.org/licenses/SHL-2.1/
// 
// Unless required by applicable law or agreed to in writing, any work
// distributed under the License is distributed on an “AS IS” BASIS, WITHOUT
// WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
// License for the specific language governing permissions and limitations
// under the License.
// 


`ifndef __UVME_PKT_SNF_PKG_SV__
`define __UVME_PKT_SNF_PKG_SV__


// Pre-processor macros
`include "uvm_macros.svh"
`include "uvml_hrtbt_macros.sv"
`include "uvme_pkt_snf_macros.sv"

// Interface(s)


 /**
 * Encapsulates all the types needed for an UVM environment capable of driving/
 * monitoring and verifying the behavior of an Packet Store-and-Forward design.
 */
package uvme_pkt_snf_pkg;
   
   import uvm_pkg       ::*;
   import uvml_hrtbt_pkg::*;
   import uvml_sb_pkg   ::*;
   import uvml_ral_pkg  ::*;
   import uvma_apb_pkg  ::*;
   import uvma_reset_pkg::*;
   
   // Constants / Structs / Enums
   `include "uvme_pkt_snf_constants.sv"
   `include "uvme_pkt_snf_tdefs.sv"
   
   // Register Abstraction Layer
   `include "uvme_pkt_snf_ral.sv"
   
   // Objects
   `include "uvme_pkt_snf_cfg.sv"
   `include "uvme_pkt_snf_cntxt.sv"
   
   // Predictor
   `include "uvme_pkt_snf_prd.sv"
   
   // Environment components
   `include "uvme_pkt_snf_cov_model.sv"
   `include "uvme_pkt_snf_sb.sv"
   `include "uvme_pkt_snf_vsqr.sv"
   `include "uvme_pkt_snf_env.sv"
   
   // Virtual sequences
   `include "uvme_pkt_snf_base_vseq.sv"
   `include "uvme_pkt_snf_reg_base_vseq.sv"
   `include "uvme_pkt_snf_reg_bit_bash_vseq.sv"
   `include "uvme_pkt_snf_reg_hw_reset_vseq.sv"
   `include "uvme_pkt_snf_reset_vseq.sv"
   `include "uvme_pkt_snf_vseq_lib.sv"
   
endpackage : uvme_pkt_snf_pkg


// Module(s) / Checker(s)
`ifdef UVME_PKT_SNF_INC_CHKR
`include "uvma_pkt_snf_chkr.sv"
`endif


`endif // __UVME_PKT_SNF_PKG_SV__
