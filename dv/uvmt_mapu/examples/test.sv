// Copyright 2022 Acme Enterprises Inc.
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

   rand uvme_mapu_example_vseq_c  example_vseq; ///< Virtual Sequence to be run


   `uvm_component_utils(uvmt_mapu_example_test_c)


   /**
    * Rules for this test.
    */
   constraint my_cons {
      example_vseq.num_items == 10;
   }


   /**
    * Creates example_vseq.
    */
   extern function new(string name="uvmt_mapu_example_test", uvm_component parent=null);

   /**
    * Runs example_vseq on vsequencer.
    */
   extern virtual task main_phase(uvm_phase phase);

endclass : uvmt_mapu_example_test_c


function uvmt_mapu_example_test_c::new(string name="uvmt_mapu_example_test", uvm_component parent=null);

   super.new(name, parent);
   example_vseq = uvme_mapu_example_vseq_c::type_id::create("example_vseq");

endfunction : new


task uvmt_mapu_example_test_c::main_phase(uvm_phase phase);

   super.main_phase(phase);
   phase.raise_objection(this);
   `uvm_info("TEST", $sformatf("Starting Virtual Sequence:\n%s", example_vseq.sprint()), UVM_NONE)
   example_vseq.start(vsequencer);
   `uvm_info("TEST", $sformatf("Finished Virtual Sequence:\n%s", example_vseq.sprint()), UVM_NONE)
   phase.drop_objection(this);

endtask : main_phase


`endif // __UVMT_MAPU_EXAMPLE_TEST_SV__