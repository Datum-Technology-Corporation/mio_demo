// 
// Copyright 2020 Datum Technology Corporation
// 
// Licensed under the Solderpad Hardware License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// 
//     https://solderpad.org/licenses/
// 
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// 


`ifndef __UVMT_PKT_SNF_PKG_SV__
`define __UVMT_PKT_SNF_PKG_SV__


// Pre-processor macros
`include "uvm_macros.svh"
`include "uvml_hrtbt_macros.sv"
`include "uvmt_pkt_snf_macros.sv"

// Time units and precision for this test bench
timeunit       1ns;
timeprecision  1ps;

// Interface(s) / Module(s) / Checker(s)
`include "uvmt_pkt_snf_clk_gen_if.sv"
`ifdef UVMT_PKT_SNF_INC_DUT_CHKR
`include "uvmt_pkt_snf_dut_chkr.sv"
`endif


/**
 * Encapsulates all the types and test cases for the verification of an
 * Packet Store-and-Forward RTL design.
 */
package uvmt_pkt_snf_pkg;
   
   import uvm_pkg::*;
   import uvml_hrtbt_pkg::*;
   import uvml_logs_pkg::*;
   import uvma_apb_pkg::*;
   import uvma_reset_pkg::*;
   import uvme_pkt_snf_pkg::*;
   
   // Constants / Structs / Enums
   `include "uvmt_pkt_snf_constants.sv"
   `include "uvmt_pkt_snf_tdefs.sv"
   
   // Virtual sequence library
   // TODO Add virtual sequences
   //      Ex: `include "uvmt_pkt_snf_sanity_vseq.sv"
   `include "uvmt_pkt_snf_vseq_lib.sv"
   
   // Base test case
   `include "uvmt_pkt_snf_test_cfg.sv"
   `include "uvmt_pkt_snf_base_test.sv"
   
   // Functional tests
   `include "uvmt_pkt_snf_reg_base_test.sv"
   `include "uvmt_pkt_snf_reg_hw_reset_test.sv"
   `include "uvmt_pkt_snf_reg_bit_bash_test.sv"
   
endpackage : uvmt_pkt_snf_pkg


`endif // __UVMT_PKT_SNF_PKG_SV__
