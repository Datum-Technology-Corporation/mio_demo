// Copyright 2022 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_MAPU_RAND_STIM_VSEQ_SV__
`define __UVME_MAPU_RAND_STIM_VSEQ_SV__


/**
 * Sequence that runs 10 (by default) fully random DUT input sequence items.
 * @ingroup uvme_mapu_seq
 */
class uvme_mapu_rand_stim_vseq_c extends uvme_mapu_base_vseq_c;

   /// @name Knobs
   /// @{
   rand int unsigned  num_items; ///< Number of sequence items to be generated.
   /// @}


   `uvm_object_utils_begin(uvme_mapu_rand_stim_vseq_c)
      `uvm_field_int(num_items, UVM_DEFAULT + UVM_DEC)
   `uvm_object_utils_end


   /**
    * Default values for random fields.
    */
   constraint defaults_cons {
      soft num_items == 1;
   }


   /**
    * Default constructor.
    */
   function new(string name="uvme_mapu_rand_stim_vseq");
      super.new(name);
   endfunction

   /**
    * Generates #num_items of fully random reqs.
    */
   virtual task body();
      uvma_mapu_seq_item_c  seq_item;
      for (int unsigned ii=0; ii<num_items; ii++) begin
         `uvm_info("MAPU_RAND_STIM_VSEQ", $sformatf("Driving item #%0d of %0d", (ii+1), num_items), UVM_HIGH)
         `uvm_do_on(seq_item, p_sequencer.agent_vsequencer)
      end
   endtask

endclass : uvme_mapu_rand_stim_vseq_c


`endif // __UVME_MAPU_RAND_STIM_VSEQ_SV__
