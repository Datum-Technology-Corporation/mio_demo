// Copyright 2022 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_MAPU_COV_MODEL_SV__
`define __UVME_MAPU_COV_MODEL_SV__


/**
 * Component encapsulating Matrix APU Sub-Sytem's functional coverage model.
 * @ingroup uvme_mapu_comps
 */
class uvme_mapu_cov_model_c extends uvmx_env_cov_model_c #(
   .T_CFG  (uvme_mapu_cfg_c  ),
   .T_CNTXT(uvme_mapu_cntxt_c)
);

   /// @name Objects
   /// @{
   uvma_mapu_seq_item_c     seq_item   ; ///<
   uvma_mapu_mon_trn_c      in_mon_trn ; ///<
   uvma_mapu_mon_trn_c      out_mon_trn; ///<
   uvma_mapu_cp_mon_trn_c   cp_mon_trn ; ///< Control plane transaction being sampled
   uvma_mapu_dpi_mon_trn_c  dpi_mon_trn; ///< Data plane input transaction being sampled
   uvma_mapu_dpo_mon_trn_c  dpo_mon_trn; ///< Data plane output transaction being sampled
   /// @}

   /// @name FIFOs
   /// @{
   uvm_tlm_analysis_fifo #(uvma_mapu_seq_item_c   )  seq_item_fifo   ; ///< Queue of control plane transactions
   uvm_tlm_analysis_fifo #(uvma_mapu_mon_trn_c    )  in_mon_trn_fifo ; ///< Queue of control plane transactions
   uvm_tlm_analysis_fifo #(uvma_mapu_mon_trn_c    )  out_mon_trn_fifo; ///< Queue of control plane transactions
   uvm_tlm_analysis_fifo #(uvma_mapu_cp_mon_trn_c )  cp_mon_trn_fifo ; ///< Queue of control plane transactions
   uvm_tlm_analysis_fifo #(uvma_mapu_dpi_mon_trn_c)  dpi_mon_trn_fifo; ///< Queue of data plane input transactions
   uvm_tlm_analysis_fifo #(uvma_mapu_dpo_mon_trn_c)  dpo_mon_trn_fifo; ///< Queue of data plane output transactions
   /// @}


   `uvm_component_utils(uvme_mapu_cov_model_c)


   /**
    * Coverage for cfg
    */
   covergroup mapu_cfg_cg;
      // TODO Implement mapu_cfg_cg
      //      Ex: abc_cp : coverpoint cfg.abc;
   endgroup

   /**
    * Coverage for cntxt
    */
   covergroup mapu_cntxt_cg;
      // TODO Implement mapu_cntxt_cg
      //      Ex: abc_cp : coverpoint cntxt.abc;
   endgroup

   /**
    * Coverage for agent virtual interface.
    */
   covergroup mapu_agent_vif_cg;
      // TODO Implement mapu_cntxt_cg
      //      Ex: abc_cp : coverpoint cntxt.agent_cntxt.vif.abc;
   endgroup

   /**
    * Coverage for probe virtual interface.
    */
   covergroup mapu_probe_vif_cg;
      // TODO Implement mapu_cntxt_cg
      //      Ex: abc_cp : coverpoint cntxt.probe_vif.abc;
   endgroup

   /**
    * Coverage for Sequence Items
    */
   covergroup mapu_seq_item_cg;
      // TODO Implement mapu_seq_item_cg
      //      Ex: abc_cp : coverpoint seq_item.abc;
   endgroup

   /**
    * Coverage for input transactions
    */
   covergroup mapu_in_mon_trn_cg;
      // TODO Implement mapu_in_mon_trn_cg
      //      Ex: abc_cp : coverpoint in_mon_trn.abc;
   endgroup

   /**
    * Coverage for output transactions
    */
   covergroup mapu_out_mon_trn_cg;
      // TODO Implement mapu_out_mon_trn_cg
      //      Ex: abc_cp : coverpoint out_mon_trn.abc;
   endgroup

   /**
    * Coverage for control plane transactions
    */
   covergroup mapu_cp_mon_trn_cg;
      // TODO Implement mapu_cp_mon_trn_cg
      //      Ex: abc_cp : coverpoint cp_mon_trn.abc;
   endgroup

   /**
    * Coverage for data plane input transactions
    */
   covergroup mapu_dpi_mon_trn_cg;
      // TODO Implement mapu_dpi_mon_trn_cg
      //      Ex: abc_cp : coverpoint dpi_mon_trn.abc;
   endgroup

   /**
    * Coverage for data plane output transactions
    */
   covergroup mapu_dpo_mon_trn_cg;
      // TODO Implement mapu_dpo_mon_trn_cg
      //      Ex: abc_cp : coverpoint dpo_mon_trn.abc;
   endgroup


   /**
    * Creates covergroups.
    */
   function new(string name="uvme_mapu_cov_model", uvm_component parent=null);
      super.new(name, parent);
      mapu_cfg_cg         = new();
      mapu_cntxt_cg       = new();
      mapu_agent_vif_cg   = new();
      mapu_probe_vif_cg   = new();
      mapu_seq_item_cg    = new();
      mapu_in_mon_trn_cg  = new();
      mapu_out_mon_trn_cg = new();
      mapu_cp_mon_trn_cg  = new();
      mapu_dpi_mon_trn_cg = new();
      mapu_dpo_mon_trn_cg = new();
   endfunction

   /**
    * Creates TLM FIFOs.
    */
   virtual function void create_fifos();
      seq_item_fifo    = new("seq_item_fifo"   , this);
      in_mon_trn_fifo  = new("in_mon_trn_fifo" , this);
      out_mon_trn_fifo = new("out_mon_trn_fifo", this);
      cp_mon_trn_fifo  = new("cp_mon_trn_fifo" , this);
      dpi_mon_trn_fifo = new("dpi_mon_trn_fifo", this);
      dpo_mon_trn_fifo = new("dpo_mon_trn_fifo", this);
   endfunction

   /// @name Sampling functions
   /// @{
   virtual function void sample_cfg();
      mapu_cfg_cg.sample();
   endfunction

   virtual function void sample_cntxt();
      mapu_cntxt_cg.sample();
   endfunction

   virtual task sample_vifs();
      fork
         forever begin
            @(cntxt.agent_cntxt.vif.dut_mp.dut_cb);
            mapu_agent_vif_cg.sample();
         end
         forever begin
            @(cntxt.probe_vif.mp.cb);
            mapu_probe_vif_cg.sample();
         end
      join
   endtask

   virtual task sample_tlm();
      fork
         forever begin
            seq_item_fifo.get(seq_item);
            mapu_seq_item_cg.sample();
         end
         forever begin
            in_mon_trn_fifo.get(in_mon_trn);
            mapu_in_mon_trn_cg.sample();
         end
         forever begin
            out_mon_trn_fifo.get(out_mon_trn);
            mapu_out_mon_trn_cg.sample();
         end
         forever begin
            cp_mon_trn_fifo.get(cp_mon_trn);
            mapu_cp_mon_trn_cg.sample();
         end
         forever begin
            dpo_mon_trn_fifo.get(dpo_mon_trn);
            mapu_dpo_mon_trn_cg.sample();
         end
         forever begin
            dpi_mon_trn_fifo.get(dpi_mon_trn);
            mapu_dpi_mon_trn_cg.sample();
         end
      join
   endtask
   /// @}

endclass : uvme_mapu_cov_model_c


`endif // __UVME_MAPU_COV_MODEL_SV__