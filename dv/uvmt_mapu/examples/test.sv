// Copyright 2023 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// This file contains sample code that demonstrates how to add a new test to the Matrix APU Block Test Bench and UVM Test Library.


`ifndef __UVMT_MAPU_EXAMPLE_TEST_SV__
`define __UVMT_MAPU_EXAMPLE_TEST_SV__


/**
 * Test which runs Virtual Sequence 'example_vseq' for 10 items of stimulus.
 * @ingroup uvmt_mapu_tests
 */
class uvmt_mapu_example_test_c extends uvmt_mapu_base_test_c;

   rand uvme_mapu_example_vseq_c  example_vseq; ///< Virtual Sequence run during main_phase.


   `uvm_component_utils(uvmt_mapu_example_test_c)


   /**
    * Rules for this test.
    */
   constraint example_cons {
      example_vseq.num_items == 10;
   }


   /**
    * Default constructor.
    */
   function new(string name="uvmt_mapu_example_test", uvm_component parent=null);
      super.new(name, parent);
   endfunction

   /**
    * Creates example_vseq.
    */
   virtual function void create_sequences();
      example_vseq = uvme_mapu_example_vseq_c::type_id::create("example_vseq");
   endfunction

   /**
    * Runs example_vseq on vsequencer.
    */
   virtual task main_phase(uvm_phase phase);
      super.main_phase(phase);
      phase.raise_objection(this);
      `uvm_info("TEST", $sformatf("Starting 'example_vseq' Virtual Sequence:\n%s", example_vseq.sprint()), UVM_NONE)
      example_vseq.start(vsequencer);
      `uvm_info("TEST", $sformatf("Finished 'example_vseq' Virtual Sequence:\n%s", example_vseq.sprint()), UVM_NONE)
      phase.drop_objection(this);
   endtask

endclass : uvmt_mapu_example_test_c


`endif // __UVMT_MAPU_EXAMPLE_TEST_SV__