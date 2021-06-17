// Copyright 2021 Datum Technology Corporation
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVMT_PKT_SNF_TEST_CFG_SV__
`define __UVMT_PKT_SNF_TEST_CFG_SV__


/**
 * Object encapsulating configuration parameters common to most if not all tests
 * extending from uvmt_pkt_snf_base_test_c.
 */
class uvmt_pkt_snf_test_cfg_c extends uvm_object;
   
   // Generic knobs
   rand int unsigned  startup_timeout   ; // Specified in nanoseconds (ns)
   rand int unsigned  heartbeat_period  ; // Specified in nanoseconds (ns)
   rand int unsigned  simulation_timeout; // Specified in nanoseconds (ns)
   
   // Test-specific knobs
   uvm_reg_block  selected_reg_block;
   
   // Command line arguments
   string  cli_block_name_str         = "BLKNM";
   bit     cli_block_name_override    = 0;
   string  cli_block_name_parsed_str  = "";
   
   
   `uvm_object_utils_begin(uvmt_pkt_snf_test_cfg_c)
      `uvm_field_int(startup_timeout   , UVM_DEFAULT)
      `uvm_field_int(heartbeat_period  , UVM_DEFAULT)
      `uvm_field_int(simulation_timeout, UVM_DEFAULT)
      
      `uvm_field_object(selected_reg_block, UVM_DEFAULT)
      
      `uvm_field_string(cli_block_name_str       , UVM_DEFAULT)
      `uvm_field_int   (cli_block_name_override  , UVM_DEFAULT)
      `uvm_field_string(cli_block_name_parsed_str, UVM_DEFAULT)
   `uvm_object_utils_end
   
   
   constraint timeouts_default_cons {
      soft startup_timeout    == uvmt_pkt_snf_default_startup_timeout   ; 
      soft heartbeat_period   == uvmt_pkt_snf_default_heartbeat_period  ;
      soft simulation_timeout == uvmt_pkt_snf_default_simulation_timeout;
   }
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvmt_pkt_snf_test_cfg");
   
   /**
    * TODO Describe uvmt_pkt_snf_test_cfg_c::process_cli_args()
    */
   extern function void process_cli_args();
   
endclass : uvmt_pkt_snf_test_cfg_c


function uvmt_pkt_snf_test_cfg_c::new(string name="uvmt_pkt_snf_test_cfg");
   
   super.new(name);
   
endfunction : new


function void uvmt_pkt_snf_test_cfg_c::process_cli_args();
   
   if (uvm_cmdline_proc.get_arg_value({"+", cli_block_name_str, "="}, cli_block_name_parsed_str)) begin
      if (cli_block_name_parsed_str != "") begin
         cli_block_name_override = 1;
      end
      else begin
         cli_block_name_override = 0;
      end
   end
   else begin
      cli_block_name_override = 0;
   end
   
endfunction : process_cli_args


`endif // __UVMT_PKT_SNF_TEST_CFG_SV__
