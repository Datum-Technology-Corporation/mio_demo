// Copyright 2023 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_MAPU_COV_MODEL_SV__
`define __UVME_MAPU_COV_MODEL_SV__


/**
 * Component encapsulating Matrix APU Block's functional coverage model.
 * @ingroup uvme_mapu_comps
 */
class uvme_mapu_cov_model_c extends uvmx_env_cov_model_c #(
   .T_CFG  (uvme_mapu_cfg_c  ),
   .T_CNTXT(uvme_mapu_cntxt_c)
);

   /// @name Objects
   /// @{
   uvma_mapu_seq_item_c      seq_item    ; ///< Sequence Item being sampled.
   uvma_mapu_mon_trn_c       in_mon_trn  ; ///< Input Monitor Transaction being sampled.
   uvma_mapu_mon_trn_c       out_mon_trn ; ///< Output Monitor Transaction being sampled.
   uvma_mapu_cp_seq_item_c   cp_seq_item ; ///< Control Plane Sequence Item being sampled
   uvma_mapu_dpi_seq_item_c  dpi_seq_item; ///< Data Plane Input Sequence Item being sampled
   uvma_mapu_dpo_seq_item_c  dpo_seq_item; ///< Data Plane Output Sequence Item being sampled
   uvma_mapu_cp_mon_trn_c    cp_mon_trn  ; ///< Control Plane Monitor Transaction being sampled
   uvma_mapu_dpi_mon_trn_c   dpi_mon_trn ; ///< Data Plane Input Monitor Transaction being sampled
   uvma_mapu_dpo_mon_trn_c   dpo_mon_trn ; ///< Data Plane Output Monitor Transaction being sampled
   /// @}

   /// @name FIFOs
   /// @{
   uvm_tlm_analysis_fifo #(uvma_mapu_seq_item_c    )  seq_item_fifo    ; ///< Input FIFO for Sequence Items.
   uvm_tlm_analysis_fifo #(uvma_mapu_mon_trn_c     )  in_mon_trn_fifo  ; ///< Input FIFO for Input Monitor Transactions.
   uvm_tlm_analysis_fifo #(uvma_mapu_mon_trn_c     )  out_mon_trn_fifo ; ///< Input FIFO for Output Monitor Transactions.
   uvm_tlm_analysis_fifo #(uvma_mapu_cp_seq_item_c )  cp_seq_item_fifo ; ///< Input FIFO for Control Plane Sequence Items.
   uvm_tlm_analysis_fifo #(uvma_mapu_dpi_seq_item_c)  dpi_seq_item_fifo; ///< Input FIFO for Data Plane Input Sequence Items.
   uvm_tlm_analysis_fifo #(uvma_mapu_dpo_seq_item_c)  dpo_seq_item_fifo; ///< Input FIFO for Data Plane Output Sequence Items.
   uvm_tlm_analysis_fifo #(uvma_mapu_cp_mon_trn_c  )  cp_mon_trn_fifo  ; ///< Input FIFO for Control Plane Monitor Transactions.
   uvm_tlm_analysis_fifo #(uvma_mapu_dpi_mon_trn_c )  dpi_mon_trn_fifo ; ///< Input FIFO for Data Plane Input Monitor Transactions.
   uvm_tlm_analysis_fifo #(uvma_mapu_dpo_mon_trn_c )  dpo_mon_trn_fifo ; ///< Input FIFO for Data Plane Output Monitor Transactions.
   /// @}


   `uvm_component_utils(uvme_mapu_cov_model_c)


   /**
    * Environment configuration functional coverage.
    */
   covergroup mapu_cfg_cg;
      data_width_cp : coverpoint cfg.data_width {
         bins valid[] = {32,64};
      }
      out_drv_ton_pct_cp : coverpoint cfg.agent_cfg.out_drv_ton_pct {
         bins valid[] = {[1:100]};
      }
   endgroup

   /**
    * Environment context functional coverage.
    */
   covergroup mapu_cntxt_cg;
   endgroup

   /**
    * Agent Interface functional coverage.
    */
   covergroup mapu_agent_vif_cg;
   endgroup

   /**
    * Sequence Item functional coverage.
    */
   covergroup mapu_seq_item_cg;
      op_cp : coverpoint seq_item.op;
      coverpoint seq_item.ton_pct {
         bins valid[] = {[1:100]};
      }
   endgroup

   /**
    * Input Monitor Transaction functional coverage.
    */
   covergroup mapu_in_mon_trn_cg;
   endgroup

   /**
    * Output Monitor Transaction functional coverage.
    */
   covergroup mapu_out_mon_trn_cg;
      overflow_cp : coverpoint out_mon_trn.overflow;
   endgroup

   /**
    * Control Plane Sequence Item functional coverage.
    */
   covergroup mapu_cp_seq_item_cg;
      i_op_cp : coverpoint cp_seq_item.i_op;
   endgroup

   /**
    * Data Plane Input Sequence Item functional coverage.
    */
   covergroup mapu_dpi_seq_item_cg;
   endgroup

   /**
    * Data Plane Output Sequence Item functional coverage.
    */
   covergroup mapu_dpo_seq_item_cg;
   endgroup

   /**
    * Control Plane Monitor Transaction functional coverage.
    */
   covergroup mapu_cp_mon_trn_cg;
      o_of_cp : coverpoint cp_mon_trn.o_of;
   endgroup

   /**
    * Data Plane Input Monitor Transaction functional coverage.
    */
   covergroup mapu_dpi_mon_trn_cg;
   endgroup

   /**
    * Data Plane Output Monitor Transaction functional coverage.
    */
   covergroup mapu_dpo_mon_trn_cg;
   endgroup


   /**
    * Creates covergroups.
    */
   function new(string name="uvme_mapu_cov_model", uvm_component parent=null);
      super.new(name, parent);
      mapu_cfg_cg          = new();
      mapu_cntxt_cg        = new();
      mapu_agent_vif_cg    = new();
      mapu_seq_item_cg     = new();
      mapu_in_mon_trn_cg   = new();
      mapu_out_mon_trn_cg  = new();
      mapu_cp_seq_item_cg  = new();
      mapu_dpi_seq_item_cg = new();
      mapu_dpo_seq_item_cg = new();
      mapu_cp_mon_trn_cg   = new();
      mapu_dpi_mon_trn_cg  = new();
      mapu_dpo_mon_trn_cg  = new();
   endfunction

   /**
    * Creates TLM FIFOs.
    */
   virtual function void create_fifos();
      seq_item_fifo     = new("seq_item_fifo"    , this);
      in_mon_trn_fifo   = new("in_mon_trn_fifo"  , this);
      out_mon_trn_fifo  = new("out_mon_trn_fifo" , this);
      cp_seq_item_fifo  = new("cp_seq_item_fifo" , this);
      dpi_seq_item_fifo = new("dpi_seq_item_fifo", this);
      dpo_seq_item_fifo = new("dpo_seq_item_fifo", this);
      cp_mon_trn_fifo   = new("cp_mon_trn_fifo"  , this);
      dpi_mon_trn_fifo  = new("dpi_mon_trn_fifo" , this);
      dpo_mon_trn_fifo  = new("dpo_mon_trn_fifo" , this);
   endfunction

   /// @name Sampling functions
   /// @{
   virtual function void sample_cfg  (); mapu_cfg_cg  .sample(); endfunction
   virtual function void sample_cntxt(); mapu_cntxt_cg.sample(); endfunction

   virtual task sample_vifs();
      fork
         forever begin
            cntxt.agent_cntxt.clk_e.wait_trigger();
            mapu_agent_vif_cg.sample();
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
            cp_seq_item_fifo.get(cp_seq_item);
            mapu_cp_seq_item_cg.sample();
         end
         forever begin
            dpo_seq_item_fifo.get(dpo_seq_item);
            mapu_dpo_seq_item_cg.sample();
         end
         forever begin
            dpi_seq_item_fifo.get(dpi_seq_item);
            mapu_dpi_seq_item_cg.sample();
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
