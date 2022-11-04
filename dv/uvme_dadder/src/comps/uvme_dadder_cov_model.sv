// Copyright 2022 Contributors
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_DADDER_COV_MODEL_SV__
`define __UVME_DADDER_COV_MODEL_SV__


/**
 * Component encapsulating Decimal adder/subtracter Sub-Sytem's functional coverage model.
 * @ingroup uvme_dadder_comps
 */
class uvme_dadder_cov_model_c extends uvm_component;

   /// @name Objects
   /// @{
   uvme_dadder_cfg_c             cfg       ; ///< Environment configuration handle
   uvme_dadder_cntxt_c           cntxt     ; ///< Environment context handle
   uvma_dadder_cp_mon_trn_c      cp_trn    ; ///< Control plane transaction being sampled
   uvma_dadder_dp_in_mon_trn_c   dp_in_trn ; ///< Data plane input transaction being sampled
   uvma_dadder_dp_out_mon_trn_c  dp_out_trn; ///< Data plane output transaction being sampled
   /// @}

   /// @name TLM
   /// @{
   uvm_tlm_analysis_fifo #(uvma_dadder_cp_mon_trn_c    )  cp_fifo      ; ///< Queue of control plane transactions
   uvm_tlm_analysis_fifo #(uvma_dadder_dp_in_mon_trn_c )  dp_in_fifo   ; ///< Queue of data plane input transactions
   uvm_tlm_analysis_fifo #(uvma_dadder_dp_out_mon_trn_c)  dp_out_fifo  ; ///< Queue of data plane outut transactions
   uvm_analysis_port     #(uvma_dadder_cp_mon_trn_c    )  cp_export    ; ///< Port taking in control plane transactions
   uvm_analysis_port     #(uvma_dadder_dp_in_mon_trn_c )  dp_in_export ; ///< Port taking in control plane transactions
   uvm_analysis_port     #(uvma_dadder_dp_out_mon_trn_c)  dp_out_export; ///< Port taking in control plane transactions
   /// @}


   `uvm_component_utils_begin(uvme_dadder_cov_model_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end


   /**
    * Coverage for #cfg
    */
   covergroup dadder_cfg_cg;
      coverpoint cfg.data_width {
         bins range[4] = {8,16,32,64};
      }
   endgroup : dadder_cfg_cg

   /**
    * Coverage for #cntxt
    */
   covergroup dadder_cntxt_cg;
      reset_state_cp : coverpoint cntxt.reset_state;
   endgroup : dadder_cntxt_cg

   /**
    * Coverage for control plane transactions
    */
   covergroup dadder_cp_trn_cg;
      en_cp : coverpoint cp_trn.en;
      op_cp : coverpoint cp_trn.op;
   endgroup : dadder_cp_trn_cg

   /**
    * Coverage for data plane input transactions
    */
   covergroup dadder_dp_in_trn_cg;
      carry_in_cp : coverpoint dp_in_trn.carry_in;
      op_a_cp     : coverpoint dp_in_trn.op_a    ;
      op_b_cp     : coverpoint dp_in_trn.op_b    ;
   endgroup : dadder_dp_in_trn_cg

   /**
    * Coverage for data plane output transactions
    */
   covergroup dadder_dp_out_trn_cg;
      of_out_cp   : coverpoint dp_out_trn.of_out  ;
      data_out_cp : coverpoint dp_out_trn.data_out;
   endgroup : dadder_dp_out_trn_cg


   /**
    * Creates covergroups.
    */
   extern function new(string name="uvme_dadder_cov_model", uvm_component parent=null);

   /**
    * 1. Ensures #cfg & #cntxt handles are not null.
    * 2. Creates fifos.
    */
   extern virtual function void build_phase(uvm_phase phase);

   /**
    * Connects exports to fifos.
    */
   extern virtual function void connect_phase(uvm_phase phase);

   /**
    * Forks all sampling loops.
    */
   extern virtual task run_phase(uvm_phase phase);

   /**
    * Uses uvm_config_db to retrieve cfg.
    */
   extern function void get_cfg();

   /**
    * Uses uvm_config_db to retrieve cntxt.
    */
   extern function void get_cntxt();

   /**
    * Creates TLM FIFOs and Analysis Ports.
    */
   extern function void create_tlm_objects();

   /**
    * Connects Exports to FIFOs.
    */
   extern function void connect_ports();

   /**
    * Samples #dadder_cfg_cg
    */
   extern function void sample_cfg();

   /**
    * Samples #dadder_cntxt_cg
    */
   extern function void sample_cntxt();

   /**
    * Samples #dadder_cp_trn_cg
    */
   extern function void sample_cp_trn();

   /**
    * Samples #dadder_dp_in_trn_cg
    */
   extern function void sample_dp_in_trn();

   /**
    * Samples #dadder_dp_out_trn_cg
    */
   extern function void sample_dp_out_trn();

endclass : uvme_dadder_cov_model_c


function uvme_dadder_cov_model_c::new(string name="uvme_dadder_cov_model", uvm_component parent=null);

   super.new(name, parent);
   dadder_cfg_cg        = new();
   dadder_cntxt_cg      = new();
   dadder_cp_trn_cg     = new();
   dadder_dp_in_trn_cg  = new();
   dadder_dp_out_trn_cg = new();

endfunction : new


function void uvme_dadder_cov_model_c::build_phase(uvm_phase phase);

   super.build_phase(phase);
   get_cfg           ();
   get_cntxt         ();
   create_tlm_objects();

endfunction : build_phase


function void uvme_dadder_cov_model_c::connect_phase(uvm_phase phase);

   super.connect_phase(phase);
   connect_ports();

endfunction : connect_phase


task uvme_dadder_cov_model_c::run_phase(uvm_phase phase);

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
      // Control plane
      forever begin
         cp_fifo.get(cp_trn);
         sample_cp_trn();
      end
      // Data plane input
      forever begin
         dp_in_fifo.get(dp_in_trn);
         sample_dp_in_trn();
      end
      // Data plane output
      forever begin
         dp_out_fifo.get(dp_out_trn);
         sample_dp_out_trn();
      end
   join_none

endtask : run_phase


function void uvme_dadder_cov_model_c::get_cfg();

   void'(uvm_config_db#(uvme_dadder_cfg_c)::get(this, "", "cfg", cfg));
   if (!cfg) begin
      `uvm_fatal("DADDER_COV_MODEL", "Configuration handle is null")
   end

endfunction : get_cfg


function void uvme_dadder_cov_model_c::get_cntxt();

   void'(uvm_config_db#(uvme_dadder_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (!cntxt) begin
      `uvm_fatal("DADDER_COV_MODEL", "Context handle is null")
   end

endfunction : get_cntxt


function void uvme_dadder_cov_model_c::create_tlm_objects();

   cp_fifo     = new("cp_fifo"    , this);
   dp_in_fifo  = new("dp_in_fifo" , this);
   dp_out_fifo = new("dp_out_fifo", this);

endfunction : create_tlm_objects


function void uvme_dadder_cov_model_c::connect_ports();

   cp_export     = cp_fifo    .analysis_export;
   dp_in_export  = dp_in_fifo .analysis_export;
   dp_out_export = dp_out_fifo.analysis_export;

endfunction : connect_ports


function void uvme_dadder_cov_model_c::sample_cfg();

   dadder_cfg_cg.sample();

endfunction : sample_cfg


function void uvme_dadder_cov_model_c::sample_cntxt();

   dadder_cntxt_cg.sample();

endfunction : sample_cntxt


function void uvme_dadder_cov_model_c::sample_cp_trn();

   dadder_cp_trn_cg.sample();

endfunction : sample_cp_trn


function void uvme_dadder_cov_model_c::sample_dp_in_trn();

   dadder_dp_in_trn_cg.sample();

endfunction : sample_dp_in_trn


function void uvme_dadder_cov_model_c::sample_dp_out_trn();

   dadder_dp_out_trn_cg.sample();

endfunction : sample_dp_out_trn


`endif // __UVME_DADDER_COV_MODEL_SV__