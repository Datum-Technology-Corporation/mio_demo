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


`ifndef __UVME_PKT_SNF_ENV_SV__
`define __UVME_PKT_SNF_ENV_SV__


/**
 * Top-level component that encapsulates, builds and connects all other
 * Packet Store-and-Forward environment components.
 */
class uvme_pkt_snf_env_c extends uvm_env;
   
   // Objects
   uvme_pkt_snf_cfg_c    cfg;
   uvme_pkt_snf_cntxt_c  cntxt;
   
   // Register Abstraction Layer (RAL)
   uvme_pkt_snf_ral_c      ral;
   uvma_apb_reg_adapter_c  reg_adapter;
   
   // Components
   uvme_pkt_snf_cov_model_c  cov_model;
   uvme_pkt_snf_prd_c        predictor;
   uvme_pkt_snf_sb_c         sb;
   uvme_pkt_snf_vsqr_c       vsequencer;
   
   // Environment(s)
   // TODO: Add sub-environments
   //       Ex: uvme_sub_env_env_c  sub_env;
   
   // Agents
   uvma_apb_agent_c  apb_agent;
   uvma_reset_agent_c  reset_agent;
   
   
   `uvm_component_utils_begin(uvme_pkt_snf_env_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvme_pkt_snf_env", uvm_component parent=null);
   
   /**
    * 1. Ensures cfg & cntxt handles are not null
    * 2. Assigns cfg and cntxt handles via assign_cfg() & assign_cntxt()
    * 3. Builds all components via create_<x>()
    */
   extern virtual function void build_phase(uvm_phase phase);
   
   /**
    * 1. Connects agents to predictor via connect_predictor()
    * 2. Connects ral to predictor & provisioning agent via connect_ral()
    * 3. Connects predictor & agents to scoreboard via connect_scoreboard()
    * 4. Assembles virtual sequencer handles via assemble_vsequencer()
    * 5. Connects agents to coverage model via connect_coverage_model()
    */
   extern virtual function void connect_phase(uvm_phase phase);
   
   /**
    * Assigns configuration handles to components using UVM Configuration Database.
    */
   extern virtual function void assign_cfg();
   
   /**
    * Assigns context handles to components using UVM Configuration Database.
    */
   extern virtual function void assign_cntxt();
   
   /**
    * Creates sub-environment components.
    */
   extern virtual function void create_sub_envs();
   
   /**
    * Creates agent components.
    */
   extern virtual function void create_agents();
   
   /**
    * Creates ral_adapter which translates to/from ral to apb_agent.
    */
   extern virtual function void create_ral_adapter();
   
   /**
    * Creates additional (non-agent) environment components (and objects).
    */
   extern virtual function void create_env_components();
   
   /**
    * Creates environment's virtual sequencer.
    */
   extern virtual function void create_vsequencer();
   
   /**
    * Creates environment's coverage model.
    */
   extern virtual function void create_cov_model();
   
   /**
    * Connects agents to predictor.
    */
   extern virtual function void connect_predictor();
   
   /**
    * Connects scoreboards components to agents/predictor.
    */
   extern virtual function void connect_scoreboard();
   
   /**
    * Connects RAL to provisioning agent (apb_agent).
    */
   extern virtual function void connect_ral();
   
   /**
    * Connects environment coverage model to agents/scoreboards/predictor.
    */
   extern virtual function void connect_coverage_model();
   
   /**
    * Assembles virtual sequencer from agent sequencers.
    */
   extern virtual function void assemble_vsequencer();
   
endclass : uvme_pkt_snf_env_c


function uvme_pkt_snf_env_c::new(string name="uvme_pkt_snf_env", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


function void uvme_pkt_snf_env_c::build_phase(uvm_phase phase);
   
   super.build_phase(phase);
   
   void'(uvm_config_db#(uvme_pkt_snf_cfg_c)::get(this, "", "cfg", cfg));
   if (!cfg) begin
      `uvm_fatal("CFG", "Configuration handle is null")
   end
   else begin
      `uvm_info("CFG", $sformatf("Found configuration handle:\n%s", cfg.sprint()), UVM_DEBUG)
   end
   
   if (cfg.enabled) begin
      void'(uvm_config_db#(uvme_pkt_snf_cntxt_c)::get(this, "", "cntxt", cntxt));
      if (!cntxt) begin
         `uvm_info("CNTXT", "Context handle is null; creating.", UVM_DEBUG)
         cntxt = uvme_pkt_snf_cntxt_c::type_id::create("cntxt");
      end
      
      assign_cfg           ();
      assign_cntxt         ();
      create_sub_envs      ();
      create_agents        ();
      create_ral_adapter   ();
      create_env_components();
      
      if (cfg.is_active) begin
         create_vsequencer();
      end
      
      if (cfg.cov_model_enabled) begin
         create_cov_model();
      end
   end
   
endfunction : build_phase


function void uvme_pkt_snf_env_c::connect_phase(uvm_phase phase);
   
   super.connect_phase(phase);
   
   if (cfg.enabled) begin
      if (cfg.scoreboarding_enabled) begin
         connect_predictor ();
         connect_scoreboard();
      end
      
      if (cfg.is_active) begin
         connect_ral();
         assemble_vsequencer();
      end
      
      if (cfg.cov_model_enabled) begin
         connect_coverage_model();
      end
   end
   
endfunction: connect_phase


function void uvme_pkt_snf_env_c::assign_cfg();
   
   uvm_config_db#(uvme_pkt_snf_cfg_c)::set(this, "*", "cfg", cfg);
   uvm_config_db#(uvma_apb_cfg_c)::set(this, "apb_agent", "cfg", cfg.apb_cfg);
   uvm_config_db#(uvma_reset_cfg_c)::set(this, "*reset_agent", "cfg", cfg.reset_cfg);
   
   // TODO Assign sub-environment cfg handle
   //      Ex: uvm_config_db#(uvme_sub_env_cfg_c)::set(this, "sub_env", "cfg", cfg.sub_env_cfg);
   
endfunction: assign_cfg


function void uvme_pkt_snf_env_c::assign_cntxt();
   
   uvm_config_db#(uvme_pkt_snf_cntxt_c)::set(this, "*"          , "cntxt", cntxt            );
   uvm_config_db#(uvma_apb_cntxt_c    )::set(this, "apb_agent"  , "cntxt", cntxt.apb_cntxt  );
   uvm_config_db#(uvma_reset_cntxt_c  )::set(this, "reset_agent", "cntxt", cntxt.reset_cntxt);
   
   // TODO Assign sub-environment cntxt handle
   //      Ex: uvm_config_db#(uvme_sub_env_cntxt_c)::set(this, "sub_env", "cntxt", cntxt.sub_env_cntxt);
   
endfunction: assign_cntxt


function void uvme_pkt_snf_env_c::create_sub_envs();
   
   // TODO: Create sub-environments
   //       Ex: sub_env = uvme_sub_env_c::type_id::create("sub_env");
   
endfunction: create_sub_envs


function void uvme_pkt_snf_env_c::create_agents();
   
   apb_agent   = uvma_apb_agent_c  ::type_id::create("apb_agent"  , this);
   reset_agent = uvma_reset_agent_c::type_id::create("reset_agent", this);
   
endfunction: create_agents


function void uvme_pkt_snf_env_c::create_env_components();
   
   if (cfg.scoreboarding_enabled) begin
      predictor = uvme_pkt_snf_prd_c::type_id::create("predictor", this);
      sb        = uvme_pkt_snf_sb_c ::type_id::create("sb"       , this);
   end
   
endfunction: create_env_components


function void uvme_pkt_snf_env_c::create_ral_adapter();
   
   reg_adapter = uvma_apb_reg_adapter_c::type_id::create("reg_adapter");
   ral = cfg.pkt_snf_ral;
   
endfunction: create_ral_adapter


function void uvme_pkt_snf_env_c::create_vsequencer();
   
   vsequencer = uvme_pkt_snf_vsqr_c::type_id::create("vsequencer", this);
   
endfunction: create_vsequencer


function void uvme_pkt_snf_env_c::create_cov_model();
   
   cov_model = uvme_pkt_snf_cov_model_c::type_id::create("cov_model", this);
   
endfunction: create_cov_model


function void uvme_pkt_snf_env_c::connect_predictor();
   
   apb_agent  .mon_ap.connect(predictor.apb_export  );
   reset_agent.mon_ap.connect(predictor.reset_export);
   // TODO Connect agents monitor analysis ports to predictor
   
endfunction: connect_predictor


function void uvme_pkt_snf_env_c::connect_scoreboard();
   
   // TODO Connect agents -> scoreboard
   //      Ex: apb_agent.mon_ap.connect(sb.apb_sb.act_export);
   
   // TODO Connect predictor -> scoreboard
   //      Ex: predictor.apb_ap.connect(sb.apb_sb.exp_export);
   
endfunction: connect_scoreboard


function void uvme_pkt_snf_env_c::connect_ral();
   
   ral.default_map.set_sequencer(apb_agent.sequencer, reg_adapter);
   ral.default_map.set_auto_predict(1);
   
endfunction: connect_ral


function void uvme_pkt_snf_env_c::connect_coverage_model();
   
   // TODO Implement uvme_pkt_snf_env_c::connect_coverage_model()
   //      Ex: apb_agent.mon_ap.connect(cov_model.apb_export);
   
endfunction: connect_coverage_model


function void uvme_pkt_snf_env_c::assemble_vsequencer();
   
   vsequencer.apb_sequencer = apb_agent.sequencer;
   vsequencer.reset_sequencer = reset_agent.sequencer;
   // TODO Assemble virtual sequencer from agent sequencers
   
endfunction: assemble_vsequencer


`endif // __UVME_PKT_SNF_ENV_SV__
