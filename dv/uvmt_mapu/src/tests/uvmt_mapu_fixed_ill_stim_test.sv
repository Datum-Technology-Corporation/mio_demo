// Copyright 2022 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_MAPU_FIXED_ILL_STIM_TEST_SV__
`define __UVMT_MAPU_FIXED_ILL_STIM_TEST_SV__


/**
 * Test which runs Virtual Sequence 'fixed_ill_stim_vseq': reference partially illegal stimulus for the DUT.
 * @ingroup uvmt_mapu_tests
 */
class uvmt_mapu_fixed_ill_stim_test_c extends uvmt_mapu_base_test_c;

   rand uvme_mapu_fixed_ill_stim_vseq_c  fixed_ill_stim_vseq; ///< Virtual Sequence to be run


   `uvm_component_utils(uvmt_mapu_fixed_ill_stim_test_c)


   /**
    * Rules for this test.
    */
   constraint fixed_stim_cons {
      // env_cfg.scoreboarding_enabled == 1; // TODO Uncomment this line to enable scoreboarding for this test
   }


   /**
    * Creates fixed_ill_stim_vseq.
    */
   function new(string name="uvmt_mapu_fixed_ill_stim_test", uvm_component parent=null);
      super.new(name, parent);
   endfunction

   /**
    *
    */
   virtual function void create_sequences();
      super.create_sequences();
      fixed_ill_stim_vseq = uvme_mapu_fixed_ill_stim_vseq_c::type_id::create("fixed_ill_stim_vseq");
   endfunction

   /**
    * Runs fixed_ill_stim_vseq on vsequencer.
    */
   virtual task main_phase(uvm_phase phase);
      phase.raise_objection(this);
      `uvm_info("TEST", $sformatf("Starting Virtual Sequence:\n%s", fixed_ill_stim_vseq.sprint()), UVM_NONE)
      fixed_ill_stim_vseq.start(vsequencer);
      `uvm_info("TEST", $sformatf("Finished Virtual Sequence:\n%s", fixed_ill_stim_vseq.sprint()), UVM_NONE)
      phase.drop_objection(this);
   endtask

endclass : uvmt_mapu_fixed_ill_stim_test_c


`endif // __UVMT_MAPU_FIXED_ILL_STIM_TEST_SV__