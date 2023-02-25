// Copyright 2023 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// This file contains sample code that demonstrates how to add a new sequence to the Matrix APU Block environment.


`ifndef __UVME_MAPU_EXAMPLE_VSEQ_SV__
`define __UVME_MAPU_EXAMPLE_VSEQ_SV__


/**
 * Example Sequence that generates 10 fully random items by default.
 */
class uvme_mapu_example_vseq_c extends uvme_mapu_base_vseq_c;

   /// @name Knobs
   /// @{
   rand int unsigned  num_items; ///< Number of items to be generated.
   /// @}


   `uvm_object_utils_begin(uvme_mapu_example_vseq_c)
      `uvm_field_int(num_items, UVM_DEFAULT)
   `uvm_object_utils_end


   /**
    * Default values for random fields.
    */
   constraint defaults_cons {
      soft num_items == 10;
   }


   /**
    * Default constructor.
    */
   function new(string name="uvme_mapu_example_vseq");
      super.new(name);
   endfunction

   /**
    * Generates num_items of fully random items.
    */
   virtual task body();
      for (int unsigned ii=0; ii<num_items; ii++) begin
         `uvm_info("MAPU_EXAMPLE_VSEQ", $sformatf("Starting item %0d/%0d", (ii+1), num_items), UVM_LOW)
         `uvm_do_on_with(req, psequencer.agent_sequencer, {
            // ...
         })
         `uvm_info("MAPU_EXAMPLE_VSEQ", $sformatf("Finished item %0d/%0d", (ii+1), num_items), UVM_MEDIUM)
      end
   endtask

endclass : uvme_mapu_example_vseq_c


`endif // __UVME_MAPU_EXAMPLE_VSEQ_SV__