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


`ifndef __UVMT_PKT_SNF_REG_BASE_TEST_SV__
`define __UVMT_PKT_SNF_REG_BASE_TEST_SV__


/**
 * Test from which all other Packet Store-and-Forward register-oriented tests must
 * extend.
 */
class uvmt_pkt_snf_reg_base_test_c extends uvmt_pkt_snf_base_test_c;
   
   `uvm_component_utils(uvmt_pkt_snf_reg_base_test_c)
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvmt_pkt_snf_reg_base_test", uvm_component parent=null);
   
   /**
    * Sets target register block from CLI argument.
    */
   extern virtual function void connect_phase(uvm_phase phase);
   
endclass : uvmt_pkt_snf_reg_base_test_c


function uvmt_pkt_snf_reg_base_test_c::new(string name="uvmt_pkt_snf_reg_base_test", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


function void uvmt_pkt_snf_reg_base_test_c::connect_phase(uvm_phase phase);
  
   super.connect_phase(phase);
   
   if (test_cfg.cli_block_name_override) begin
      test_cfg.selected_reg_block = ral.get_block_by_name(test_cfg.cli_block_name_parsed_str);
   end
   
endfunction : connect_phase


`endif // __UVMT_PKT_SNF_REG_BASE_TEST_SV__
