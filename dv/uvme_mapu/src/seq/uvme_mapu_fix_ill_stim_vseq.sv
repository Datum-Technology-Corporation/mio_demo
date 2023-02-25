// Copyright 2023 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_MAPU_FIX_ILL_STIM_VSEQ_SV__
`define __UVME_MAPU_FIX_ILL_STIM_VSEQ_SV__


/**
 * Virtual Sequence that always generates the same (i.e. reference) partially illegal stimulus for the DUT.
 * @ingroup uvme_mapu_seq
 */
class uvme_mapu_fix_ill_stim_vseq_c extends uvme_mapu_base_vseq_c;

   `uvm_object_utils(uvme_mapu_fix_ill_stim_vseq_c)

   /**
    * Default constructor.
    */
   function new(string name="uvme_mapu_fix_ill_stim_vseq");
      super.new(name);
   endfunction

   /**
    * TODO Describe uvme_mapu_fix_ill_stim_vseq_c::body()
    */
   virtual task body();
      uvma_mapu_seq_item_c  seq_item;
      // TODO Implement uvme_mapu_fix_ill_stim_vseq_c::body()
      //      Ex: `uvm_create_on(seq_item, p_sequencer.agent_vsequencer)
      //          seq_item.abc = 123;
      //          `uvm_send(seq_item)
      //          `uvm_create_on(seq_item, p_sequencer.agent_vsequencer)
      //          seq_item.abc = 456;
      //          `uvm_send(seq_item)
   endtask

endclass : uvme_mapu_fix_ill_stim_vseq_c


`endif // __UVME_MAPU_FIX_ILL_STIM_VSEQ_SV__