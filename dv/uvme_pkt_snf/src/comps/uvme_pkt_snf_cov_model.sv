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


`ifndef __UVME_PKT_SNF_COV_MODEL_SV__
`define __UVME_PKT_SNF_COV_MODEL_SV__


/**
 * Component encapsulating Packet Store-and-Forward environment's functional coverage model.
 */
class uvme_pkt_snf_cov_model_c extends uvm_component;
   
   // Objects
   uvme_pkt_snf_cfg_c    cfg;
   uvme_pkt_snf_cntxt_c  cntxt;
   // TODO Add covergoup sampling variable(s)
   //      Ex: uvma_apb_mon_trn_c  apb_trn;
   
   // Input TLM
   // TODO Add Input TLM to uvme_pkt_snf_cov_model_c
   //      Ex: uvm_analysis_port    #(uvma_apb_mon_trn_c)  apb_export;
   //          uvm_tlm_analysis_fifo#(uvma_apb_mon_trn_c)  apb_fifo;
   
   
   `uvm_component_utils_begin(uvme_pkt_snf_cov_model_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end
   
   
   // TODO Add covergroup(s) to uvme_pkt_snf_cov_model_c
   //      Ex: covergroup pkt_snf_cfg_cg;
   //             abc_cpt : coverpoint cfg.abc;
   //             xyz_cpt : coverpoint cfg.xyz;
   //          endgroup : pkt_snf_cfg_cg
   //          
   //          covergroup pkt_snf_cntxt_cg;
   //             abc_cpt : coverpoint cntxt.abc;
   //             xyz_cpt : coverpoint cntxt.xyz;
   //          endgroup : pkt_snf_cntxt_cg
   //          
   //          covergroup apb_trn_cg;
   //             address : coverpoint apb_trn.address {
   //                bins low   = {32'h0000_0000, 32'h4FFF_FFFF};
   //                bins med   = {32'h5000_0000, 32'h9FFF_FFFF};
   //                bins high  = {32'hA000_0000, 32'hFFFF_FFFF};
   //             }
   //          endgroup : apb_trn_cg
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvme_pkt_snf_cov_model", uvm_component parent=null);
   
   /**
    * Ensures cfg & cntxt handles are not null.
    */
   extern virtual function void build_phase(uvm_phase phase);
   
   /**
    * Describe uvme_pkt_snf_cov_model_c::run_phase()
    */
   extern virtual task run_phase(uvm_phase phase);
   
   /**
    * TODO Describe uvme_pkt_snf_cov_model_c::sample_cfg()
    */
   extern virtual function void sample_cfg();
   
   /**
    * TODO Describe uvme_pkt_snf_cov_model_c::sample_cntxt()
    */
   extern virtual function void sample_cntxt();
   
   // TODO Add coverage functions to uvme_pkt_snf_cov_model_c
   //      Ex: /**
   //           * Samples trn via apb_cg
   //           */
   //          extern function void sample_apb();
   
endclass : uvme_pkt_snf_cov_model_c


function uvme_pkt_snf_cov_model_c::new(string name="uvme_pkt_snf_cov_model", uvm_component parent=null);
   
   super.new(name, parent);
   
   // TODO Create coverage groups for uvme_pkt_snf_cov_model_c
   //      Ex: apb_cg = new();
   
endfunction : new


function void uvme_pkt_snf_cov_model_c::build_phase(uvm_phase phase);
   
   super.build_phase(phase);
   
   void'(uvm_config_db#(uvme_pkt_snf_cfg_c)::get(this, "", "cfg", cfg));
   if (!cfg) begin
      `uvm_fatal("CFG", "Configuration handle is null")
   end
   
   void'(uvm_config_db#(uvme_pkt_snf_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (!cntxt) begin
      `uvm_fatal("CNTXT", "Context handle is null")
   end
   
   // TODO Build Input TLM
   //      Ex: apb_export = new("apb_export", this);
   //          apb_fifo   = new("apb_fifo"  , this);
   
endfunction : build_phase


task uvme_pkt_snf_cov_model_c::run_phase(uvm_phase phase);
   
   super.run_phase(phase);
   
   fork
      // Configuration
      forever begin
         cntxt.sample_cfg_e.wait_trigger();
         sample_cfg();
      end
      
      // Context
      forever begin
         cntxt.sample_cntxt_e.wait_trigger();
         sample_cntxt();
      end
      
      // TODO Implement uvme_pkt_snf_cov_model_c::run_phase()
      //      Ex: forever begin
      //             apb_fifo.get(apb_trn);
      //             sample_apb();
      //          end
   join_none
   
endtask : run_phase


function void uvme_pkt_snf_cov_model_c::sample_cfg();
   
   // TODO Implement uvme_pkt_snf_cov_model_c::sample_cfg();
   //      Ex: pkt_snf_cfg_cg.sample();
   
endfunction : sample_cfg


function void uvme_pkt_snf_cov_model_c::sample_cntxt();
   
   // TODO Implement uvme_pkt_snf_cov_model_c::sample_cntxt();
   //      Ex: pkt_snf_cntxt_cg.sample();
   
endfunction : sample_cntxt


// TODO Implement coverage function(s) to uvme_pkt_snf_cov_model_c
//      Ex: function void uvme_pkt_snf_cov_model_c::sample_apb();
//             
//             apb_trn_cg.sample();
//             
//          endfunction : sample_apb


`endif // __UVME_PKT_SNF_COV_MODEL_SV__
