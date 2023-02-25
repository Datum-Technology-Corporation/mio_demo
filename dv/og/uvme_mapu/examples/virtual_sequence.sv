// Copyright 2023 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// This file contains sample code that demonstrates how to add a new sequence to the Matrix APU Block environment.


`ifndef __UVME_MAPU_EXAMPLE_VSEQ_SV__
`define __UVME_MAPU_EXAMPLE_VSEQ_SV__


/**
 * Example Virtual Sequence that runs 10 (by default) fully random items.
 */
class uvme_mapu_example_vseq_c extends uvme_mapu_base_vseq_c;

   /// @name Knobs
   /// @{
   rand int unsigned  num_items; ///< Number of sequence items to be generated.
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
   extern function new(string name="uvme_mapu_example_vseq");

   /**
    * Generates #num_items.
    */
   extern virtual task body();

endclass : uvme_mapu_example_vseq_c


function uvme_mapu_example_vseq_c::new(string name="uvme_mapu_example_vseq");

   super.new(name);

endfunction : new


task uvme_mapu_example_vseq_c::body();

   uvma_mapu_cp_seq_item_c   cp_req ;
   uvma_mapu_dpi_seq_item_c  dpi_req;
   uvma_mapu_dpo_seq_item_c  dpo_req;

   fork
      begin : main
         for (int unsigned ii=0; ii<num_items; ii++) begin
            `uvm_info("MAPU_EXAMPLE_VSEQ", $sformatf("Starting item %0d/%0d", (ii+1), num_items), UVM_HIGH)
            fork
               begin
                  `uvm_do_on_with(cp_req , p_sequencer.cp_sequencer, {
                     // ...
                  })
               end
               begin
                  `uvm_do_on_with(dpi_req, p_sequencer.dpi_sequencer, {
                     // ...
                  })
               end
            join
         end
      end

      begin : dpo
         forever begin
            `uvm_do_on_with(dpo_req, p_sequencer.dpo_sequencer, {
               // ...
            })
         end
      end
   join_any
   disable fork;

endtask : body


`endif // __UVME_MAPU_EXAMPLE_VSEQ_SV__