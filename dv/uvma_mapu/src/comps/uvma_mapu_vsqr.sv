// Copyright 2022 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_MAPU_VSQR_SV__
`define __UVMA_MAPU_VSQR_SV__


/**
 * Component running Matrix APU sequences of uvma_mapu_seq_item_c requests (and responses).
 * Provides sequence items for uvma_mapu_drv_c.
 * @ingroup uvma_mapu_comps
 */
class uvma_mapu_vsqr_c extends uvmx_agent_vsqr_c #(
   .T_CFG     (uvma_mapu_cfg_c     ),
   .T_CNTXT   (uvma_mapu_cntxt_c   ),
   .T_SEQ_ITEM(uvma_mapu_seq_item_c)
);

   /// @name Components
   /// @{
   uvma_mapu_cp_sqr_c   cp_sequencer ; ///<
   uvma_mapu_dpi_sqr_c  dpi_sequencer; ///<
   uvma_mapu_dpo_sqr_c  dpo_sequencer; ///<
   /// @}

   /// @name Ports
   /// @{
   uvm_analysis_port #(uvma_mapu_mon_trn_c)  in_mon_trn_ap ; ///<
   uvm_analysis_port #(uvma_mapu_mon_trn_c)  out_mon_trn_ap; ///<
   /// @}

   /// @name FIFOs
   /// @{
   uvm_tlm_analysis_fifo #(uvma_mapu_cp_mon_trn_c )  cp_mon_trn_fifo ; ///<
   uvm_tlm_analysis_fifo #(uvma_mapu_dpi_mon_trn_c)  dpi_mon_trn_fifo; ///<
   uvm_tlm_analysis_fifo #(uvma_mapu_dpo_mon_trn_c)  dpo_mon_trn_fifo; ///<
   /// @}


   `uvm_component_utils(uvma_mapu_vsqr_c)


   /**
    * Default constructor.
    */
   function new(string name="uvma_mapu_vsqr", uvm_component parent=null);
      super.new(name, parent);
   endfunction

   /**
    *
    */
   virtual function void create_sequencers();
      cp_sequencer  = uvma_mapu_cp_sqr_c ::type_id::create("cp_sequencer" , this);
      dpi_sequencer = uvma_mapu_dpi_sqr_c::type_id::create("dpi_sequencer", this);
      dpo_sequencer = uvma_mapu_dpo_sqr_c::type_id::create("dpo_sequencer", this);
   endfunction

   /**
    * Creates TLM Ports.
    */
   virtual function void create_ports();
      in_mon_trn_ap  = new("in_mon_trn_ap" , this);
      out_mon_trn_ap = new("out_mon_trn_ap", this);
   endfunction

   /**
    * Creates TLM FIFOs.
    */
   virtual function void create_fifos();
      cp_mon_trn_fifo  = new("cp_mon_trn_fifo" , this);
      dpi_mon_trn_fifo = new("dpi_mon_trn_fifo", this);
      dpo_mon_trn_fifo = new("dpo_mon_trn_fifo", this);
   endfunction

endclass : uvma_mapu_vsqr_c


`endif // __UVMA_MAPU_VSQR_SV__