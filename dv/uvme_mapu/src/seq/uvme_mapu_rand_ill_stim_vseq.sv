// Copyright 2023 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_MAPU_RAND_ILL_STIM_VSEQ_SV__
`define __UVME_MAPU_RAND_ILL_STIM_VSEQ_SV__


/**
 * Sequence that runs a fixed number of fully, potentially illegal random Sequence Items.
 * @ingroup uvme_mapu_seq
 */
class uvme_mapu_rand_ill_stim_vseq_c extends uvme_mapu_base_vseq_c;

   /// @name Knobs
   /// @{
   rand int unsigned  num_items ; ///< Number of sequence items to be generated.
   rand int unsigned  num_errors; ///< Number of errored sequence items to be generated.
   /// @}

   /// @name Data
   /// @{
   bit  error_idx[]; ///< Indicates if a sequence item is to be illegal.
   /// @}


   `uvm_object_utils_begin(uvme_mapu_rand_ill_stim_vseq_c)
      `uvm_field_int(num_items , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(num_errors, UVM_DEFAULT + UVM_DEC)
      `uvm_field_array_int(error_idx, UVM_DEFAULT)
   `uvm_object_utils_end


   /**
    * Default values for random fields.
    */
   constraint defaults_cons {
      soft num_items  == uvme_mapu_default_num_items_cons;
      soft num_errors == 1;
   }

   /**
    * Must have less errors than items.
    */
   constraint rules_cons {
      num_items > num_errors;
   }


   /**
    * Default constructor.
    */
   function new(string name="uvme_mapu_rand_ill_stim_vseq");
      super.new(name);
   endfunction

   /**
    * Fills error_idx.
    */
   function void post_randomize();
      super.post_randomize();
      error_idx = new[num_items];
      repeat (num_errors) begin
         error_idx[$urandom_range(0,(num_items-1))] = 1;
      end
   endfunction

   /**
    * Generates #num_items of fully random reqs.
    */
   virtual task body();
      uvma_mapu_seq_item_c  seq_item;
      for (int unsigned ii=0; ii<num_items; ii++) begin
         `uvm_info("MAPU_RAND_STIM_VSEQ", $sformatf("Driving item #%0d of %0d", (ii+1), num_items), UVM_HIGH)
         if (error_idx[ii]) begin
            `uvm_do_on_with(seq_item, p_sequencer.agent_vsequencer, {
               // ...
            })
         end
         else begin
            `uvm_do_on_with(seq_item, p_sequencer.agent_vsequencer, {
               // ...
            })
         end
      end
   endtask

endclass : uvme_mapu_rand_ill_stim_vseq_c


`endif // __UVME_MAPU_RAND_ILL_STIM_VSEQ_SV__