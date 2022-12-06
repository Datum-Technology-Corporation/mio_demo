// Copyright 2022 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// This file contains sample code that demonstrates how to add a new sequence to the Matrix APU UVM Agent.


`ifndef __UVMA_MAPU_EXAMPLE_SEQ_SV__
`define __UVMA_MAPU_EXAMPLE_SEQ_SV__


/**
 * Example Sequence that generates 10 fully random items by default.
 */
class uvma_mapu_example_seq_c extends uvma_mapu_base_seq_c;

   /// @name Knobs
   /// @{
   rand int unsigned  num_items; ///< Number of items to be generated.
   /// @}


   `uvm_object_utils_begin(uvma_mapu_example_seq_c)
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
   extern function new(string name="uvma_mapu_example_seq");

   /**
    * Generates num_items of fully random items.
    */
   extern virtual task body();

endclass : uvma_mapu_example_seq_c


function uvma_mapu_example_seq_c::new(string name="uvma_mapu_example_seq");

   super.new(name);

endfunction : new


task uvma_mapu_example_seq_c::body();

   for (int unsigned ii=0; ii<num_items; ii++) begin
      `uvm_info("MAPU_EXAMPLE_SEQ", $sformatf("Starting item %0d/%0d", (ii+1), num_items), UVM_HIGH)
      `uvm_do_with(req, {
         // ...
      })
   end

endtask : body


`endif // __UVMA_MAPU_EXAMPLE_SEQ_SV__