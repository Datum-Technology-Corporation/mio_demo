// Copyright 2021 Datum Technology Corporation
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVMT_PKT_SNF_PKG_SV__
`define __UVMT_PKT_SNF_PKG_SV__


// Pre-processor macros
`include "uvm_macros.svh"
`include "uvml_hrtbt_macros.sv"
`include "uvmt_pkt_snf_macros.sv"

// Time units and precision for this test bench
timeunit       1ns;
timeprecision  1ps;

// Interface(s)
`include "uvmt_pkt_snf_clk_gen_if.sv"


/**
 * Encapsulates all the types and test cases for the verification of the
 * Moore.io Demo Project Packet Store-and-Forward (SnF) RTL design.
 */
package uvmt_pkt_snf_pkg;
   
   import uvm_pkg         ::*;
   import uvml_hrtbt_pkg  ::*;
   import uvml_logs_pkg   ::*;
   import uvma_apb_pkg    ::*;
   import uvma_reset_pkg  ::*;
   import uvme_pkt_snf_pkg::*;
   
   // Constants / Structs / Enums
   `include "uvmt_pkt_snf_constants.sv"
   `include "uvmt_pkt_snf_tdefs.sv"
   
   // Sequences
   
   // Base test case
   `include "uvmt_pkt_snf_test_cfg.sv"
   `include "uvmt_pkt_snf_base_test.sv"
   
   // Functional tests
   `include "uvmt_pkt_snf_reg_base_test.sv"
   `include "uvmt_pkt_snf_reg_hw_reset_test.sv"
   `include "uvmt_pkt_snf_reg_bit_bash_test.sv"
   
endpackage : uvmt_pkt_snf_pkg


// Module(s) / Checker(s)
`include "uvmt_pkt_snf_dut_wrap.sv"
`include "uvmt_pkt_snf_dut_chkr.sv"
`include "uvmt_pkt_snf_tb.sv"


`endif // __UVMT_PKT_SNF_PKG_SV__
