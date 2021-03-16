// 
// Copyright 2021 Datum Technology Corporation
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


`ifndef __UVME_PKT_SNF_CNTXT_SV__
`define __UVME_PKT_SNF_CNTXT_SV__


/**
 * Object encapsulating all state variables for Packet Store-and-Forward environment
 * (uvme_pkt_snf_env_c) components.
 */
class uvme_pkt_snf_cntxt_c extends uvm_object;
   
   // TODO Add sub-environments context handles
   //      Ex: uvme_sub_env_cntxt_c  sub_env_cntxt;
   
   // Agent context handles
   uvma_apb_cntxt_c  apb_cntxt;
   uvma_reset_cntxt_c  reset_cntxt;
   
   // TODO Add scoreboard context handles
   //      Ex: uvme_pkt_snf_sb_cntxt_c  sb_egress_cntxt;
   //          uvme_pkt_snf_sb_cntxt_c  sb_ingress_cntxt;
   
   // Events
   uvm_event  sample_cfg_e;
   uvm_event  sample_cntxt_e;
   
   
   `uvm_object_utils_begin(uvme_pkt_snf_cntxt_c)
       // TODO: Add sub-environments context field macros
       //       Ex: `uvm_field_object(sub_env_cntxt, UVM_DEFAULT)
      
      `uvm_field_object(apb_cntxt, UVM_DEFAULT)
      `uvm_field_object(reset_cntxt, UVM_DEFAULT)
      
      // TODO Add scoreboard context field macros
      //      Ex: `uvm_field_object(sb_egress_cntxt , UVM_DEFAULT)
      //          `uvm_field_object(sb_ingress_cntxt, UVM_DEFAULT)
      
      `uvm_field_event(sample_cfg_e  , UVM_DEFAULT)
      `uvm_field_event(sample_cntxt_e, UVM_DEFAULT)
   `uvm_object_utils_end
   
   
   /**
    * Builds events and sub-context objects.
    */
   extern function new(string name="uvme_pkt_snf_cntxt");
   
endclass : uvme_pkt_snf_cntxt_c


function uvme_pkt_snf_cntxt_c::new(string name="uvme_pkt_snf_cntxt");
   
   super.new(name);
   
   // TODO Create environment cntxt objects
   //      Ex: sub_env_cntxt  = uvme_sub_env_cntxt_c::type_id::create("sub_env_cntxt");
   
   apb_cntxt = uvma_apb_cntxt_c::type_id::create("apb_cntxt");
   reset_cntxt = uvma_reset_cntxt_c::type_id::create("reset_cntxt");
   
   // TODO Create uvme_pkt_snf_cntxt_c scoreboard context objects
   //      Ex: sb_egress_cntxt  = uvma_pkt_snf_sb_cntxt_c::type_id::create("sb_egress_cntxt" );
   //          sb_ingress_cntxt = uvma_pkt_snf_sb_cntxt_c::type_id::create("sb_ingress_cntxt");
   
   sample_cfg_e   = new("sample_cfg_e"  );
   sample_cntxt_e = new("sample_cntxt_e");
   
endfunction : new


`endif // __UVME_PKT_SNF_CNTXT_SV__
