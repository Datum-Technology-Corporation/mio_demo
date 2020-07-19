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


`ifndef __UVME_PKT_SNF_PRD_SV__
`define __UVME_PKT_SNF_PRD_SV__


/**
 * Component implementing transaction-based software model of Packet Store-and-Forward DUT.
 */
class uvme_pkt_snf_prd_c extends uvm_component;
   
   // Objects
   uvme_pkt_snf_cfg_c    cfg;
   uvme_pkt_snf_cntxt_c  cntxt;
   
   // Input TLM
   uvm_analysis_export  #(uvma_apb_mon_trn_c)  apb_export;
   uvm_tlm_analysis_fifo#(uvma_apb_mon_trn_c)  apb_fifo;
   uvm_analysis_export  #(uvma_reset_mon_trn_c)  reset_export;
   uvm_tlm_analysis_fifo#(uvma_reset_mon_trn_c)  reset_fifo;
   
   // Output TLM
   // TODO Add TLM outputs to uvme_pkt_snf_prd_c
   //      Ex: uvm_analysis_port#(uvma_packet_trn_c)  pkts_out_ap;
   
   
   `uvm_component_utils_begin(uvme_pkt_snf_prd_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvme_pkt_snf_prd", uvm_component parent=null);
   
   /**
    * TODO Describe uvme_pkt_snf_prd_c::build_phase()
    */
   extern virtual function void build_phase(uvm_phase phase);
   
   /**
    * TODO Describe uvme_pkt_snf_prd_c::connect_phase()
    */
   extern virtual function void connect_phase(uvm_phase phase);
   
   /**
    * TODO Describe uvme_pkt_snf_prd_c::run_phase()
    */
   extern virtual task run_phase(uvm_phase phase);
   
   /**
    * TODO Describe uvme_pkt_snf_prd_c::process_apb()
    */
   extern task process_apb();
   
   /**
    * TODO Describe uvme_pkt_snf_prd_c::process_reset()
    */
   extern task process_reset();
   
endclass : uvme_pkt_snf_prd_c


function uvme_pkt_snf_prd_c::new(string name="uvme_pkt_snf_prd", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


function void uvme_pkt_snf_prd_c::build_phase(uvm_phase phase);
   
   super.build_phase(phase);
   
   void'(uvm_config_db#(uvme_pkt_snf_cfg_c)::get(this, "", "cfg", cfg));
   if (!cfg) begin
      `uvm_fatal("CFG", "Configuration handle is null")
   end
   
   void'(uvm_config_db#(uvme_pkt_snf_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (!cntxt) begin
      `uvm_fatal("CNTXT", "Context handle is null")
   end
   
   // Build Input TLM objects
   apb_export = new("apb_export", this);
   apb_fifo   = new("apb_fifo"  , this);
   reset_export = new("reset_export", this);
   reset_fifo   = new("reset_fifo"  , this);
   
   // Build Output TLM objects
   // TODO Create Output TLM objects for uvme_pkt_snf_prd_c
   //      Ex: pkts_out_ap = new("pkts_out_ap", this);
   
endfunction : build_phase


function void uvme_pkt_snf_prd_c::connect_phase(uvm_phase phase);
   
   super.connect_phase(phase);
   
   // Connect TLM objects
   apb_export.connect(apb_fifo.analysis_export);
   reset_export.connect(reset_fifo.analysis_export);
   
endfunction: connect_phase


task uvme_pkt_snf_prd_c::run_phase(uvm_phase phase);
   
   super.run_phase(phase);
   
   fork
      process_apb();
      process_reset();
   join_none
   
endtask: run_phase


task uvme_pkt_snf_prd_c::process_apb();
   
   uvma_apb_mon_trn_c  apb_trn;
   
   forever begin
      apb_fifo.get(apb_trn);
      
      // TODO Implement uvme_pkt_snf_prd_c::process_apb()
   end
   
endtask : process_apb


task uvme_pkt_snf_prd_c::process_reset();
   
   uvma_reset_mon_trn_c  reset_trn;
   
   forever begin
      reset_fifo.get(reset_trn);
      
      // TODO Implement uvme_pkt_snf_prd_c::process_reset()
   end
   
endtask : process_reset


`endif // __UVME_PKT_SNF_PRD_SV__
