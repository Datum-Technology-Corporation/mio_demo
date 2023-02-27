// Copyright 2023 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_MAPU_RAND_STIM_VSEQ_SV__
`define __UVME_MAPU_RAND_STIM_VSEQ_SV__


/**
 * Sequence that runs a fixed number of random Sequence Items with no overflows possible.
 * @ingroup uvme_mapu_seq
 */
class uvme_mapu_rand_stim_vseq_c extends uvme_mapu_base_vseq_c;

   /// @name Knobs
   /// @{
   rand int unsigned  num_items; ///< Number of Sequence Items to be generated.
   /// @}


   `uvm_object_utils_begin(uvme_mapu_rand_stim_vseq_c)
      `uvm_field_int(num_items, UVM_DEFAULT + UVM_DEC)
   `uvm_object_utils_end


   /**
    * Default values for random fields.
    */
   constraint defaults_cons {
      soft num_items == uvme_mapu_default_num_items_cons;
   }


   /**
    * Default constructor.
    */
   function new(string name="uvme_mapu_rand_stim_vseq");
      super.new(name);
   endfunction

   /**
    * Generates random #num_items with no overflows possible.
    */
   virtual task body();
      uvma_mapu_seq_item_c  seq_item;
      int unsigned add_max_val, mult_max_val;
      for (int unsigned ii=0; ii<num_items; ii++) begin
         `uvm_info("MAPU_RAND_STIM_VSEQ", $sformatf("Starting driving item #%0d of %0d", (ii+1), num_items), UVM_LOW)
         if (cfg.data_width == 32) begin
            add_max_val  = 1_000_000_000;
            mult_max_val = 1_000;
         end
         else if (cfg.data_width == 64) begin
            add_max_val  = 1_000_000_000_000_000;
            mult_max_val = 1_000_000_000;
         end
         `uvm_do_on_with(seq_item, p_sequencer.agent_vsequencer, {
            if (op == UVMA_MAPU_OP_ADD) {
               ma.max_val == add_max_val;
               mb.max_val == add_max_val;
            }
            else if (op == UVMA_MAPU_OP_MULT) {
               ma.max_val == mult_max_val;
               mb.max_val == mult_max_val;
            }
         })
         `uvm_info("MAPU_RAND_STIM_VSEQ", $sformatf("Finished driving item #%0d of %0d", (ii+1), num_items), UVM_MEDIUM)
      end
   endtask

endclass : uvme_mapu_rand_stim_vseq_c


`endif // __UVME_MAPU_RAND_STIM_VSEQ_SV__