// 
// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// 
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may
// not use this file except in compliance with the License, or, at your option,
// the Apache License version 2.0. You may obtain a copy of the License at
// 
//     https://solderpad.org/licenses/SHL-2.1/
// 
// Unless required by applicable law or agreed to in writing, any work
// distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
// WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
// License for the specific language governing permissions and limitations
// under the License.
// 


`ifndef __UVME_PKT_SNF_CFG_SV__
`define __UVME_PKT_SNF_CFG_SV__


/**
 * Object encapsulating all parameters for creating, connecting and running
 * Packet Store-and-Forward environment (uvme_pkt_snf_env_c) components.
 */
class uvme_pkt_snf_cfg_c extends uvm_object;
   
   // Generic options
   rand bit                      enabled;
   rand uvm_active_passive_enum  is_active;
   rand bit                      scoreboarding_enabled;
   rand bit                      cov_model_enabled;
   rand bit                      trn_log_enabled;
   
   // Sub-system parameters
   rand longint unsigned  ral_base_address;
   rand int unsigned      reset_clk_period;
   rand int unsigned      apb_clk_period;
   
   // TODO: Add sub-environments configuration handles
   //       Ex: rand uvme_sub_env_cfg_c  sub_env_cfg;
   
   // Agent cfg handles
   rand uvma_apb_cfg_c  apb_cfg;
   rand uvma_reset_cfg_c  reset_cfg;
   
   // Objects
   rand uvme_pkt_snf_ral_c  pkt_snf_ral;
   // TODO Add scoreboard configuration handles
   //      Ex: rand uvml_sb_cfg_c  sb_egress_cfg;
   //          rand uvml_sb_cfg_c  sb_ingress_cfg;
   
   
   `uvm_object_utils_begin(uvme_pkt_snf_cfg_c)
      `uvm_field_int (                         enabled              , UVM_DEFAULT)
      `uvm_field_enum(uvm_active_passive_enum, is_active            , UVM_DEFAULT)
      `uvm_field_int (                         scoreboarding_enabled, UVM_DEFAULT)
      `uvm_field_int (                         cov_model_enabled    , UVM_DEFAULT)
      `uvm_field_int (                         trn_log_enabled      , UVM_DEFAULT)
      
      `uvm_field_int(ral_base_address, UVM_DEFAULT          )
      `uvm_field_int(reset_clk_period, UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(apb_clk_period  , UVM_DEFAULT + UVM_DEC)
      
      // TODO: Add sub-environments configuration field macros
      //       Ex: `uvm_field_object(sub_env_cfg, UVM_DEFAULT)
      
      `uvm_field_object(apb_cfg  , UVM_DEFAULT)
      `uvm_field_object(reset_cfg, UVM_DEFAULT)
      
      `uvm_field_object(pkt_snf_ral, UVM_DEFAULT)
      // TODO Add scoreboard cfg field macros
      //      Ex: `uvm_field_object(sb_egress_cfg , UVM_DEFAULT)
      //          `uvm_field_object(sb_ingress_cfg, UVM_DEFAULT)
   `uvm_object_utils_end
   
   
   constraint defaults_cons {
      soft enabled                == 0;
      soft is_active              == UVM_PASSIVE;
      soft scoreboarding_enabled  == 1;
      soft cov_model_enabled      == 0;
      soft trn_log_enabled        == 1;
      soft ral_base_address       == uvme_pkt_snf_ral_default_base_address;
      soft reset_clk_period       == uvme_pkt_snf_reset_default_clk_period;
      soft apb_clk_period         == uvme_pkt_snf_apb_default_clk_period;
   }
   
   constraint agent_cfg_cons {
      if (enabled) {
         apb_cfg.enabled == 1;
         reset_cfg.enabled == 1;
      }
      
      if (is_active == UVM_ACTIVE) {
         apb_cfg.is_active == UVM_ACTIVE;
         reset_cfg.is_active == UVM_ACTIVE;
      }
      
      if (trn_log_enabled) {
         apb_cfg.trn_log_enabled == 1;
         reset_cfg.trn_log_enabled == 1;
      }
   }
   
   
   /**
    * Creates sub-configuration objects.
    */
   extern function new(string name="uvme_pkt_snf_cfg");
   
endclass : uvme_pkt_snf_cfg_c


function uvme_pkt_snf_cfg_c::new(string name="uvme_pkt_snf_cfg");
   
   super.new(name);
   
   // TODO Create environment cfg objects
   //      Ex: sub_env_cfg  = uvme_sub_env_cfg_c::type_id::create("sub_env_cfg");
   
   apb_cfg = uvma_apb_cfg_c::type_id::create("apb_cfg");
   reset_cfg = uvma_reset_cfg_c::type_id::create("reset_cfg");
   
   pkt_snf_ral = uvme_pkt_snf_ral_c::type_id::create("pkt_snf_ral");
   pkt_snf_ral.build();
   pkt_snf_ral.lock_model();
   
   // TODO Create scoreboard cfg objects
   //      Ex: sb_egress_cfg  = uvml_sb_cfg_c::type_id::create("sb_egress_cfg" );
   //          sb_ingress_cfg = uvml_sb_cfg_c::type_id::create("sb_ingress_cfg");
   
endfunction : new


`endif // __UVME_PKT_SNF_CFG_SV__
