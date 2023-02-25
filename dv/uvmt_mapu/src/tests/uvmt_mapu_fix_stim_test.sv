// Copyright 2023 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_MAPU_FIX_STIM_TEST_SV__
`define __UVMT_MAPU_FIX_STIM_TEST_SV__


/**
 * Test which runs Virtual Sequence 'fix_stim_vseq': reference stimulus for the DUT.
 * @ingroup uvmt_mapu_tests
 */
class uvmt_mapu_fix_stim_test_c extends uvmt_mapu_base_test_c;

   rand uvme_mapu_fix_stim_vseq_c  fix_stim_vseq; ///< Virtual Sequence run during main_phase.


   `uvm_component_utils(uvmt_mapu_fix_stim_test_c)


   /**
    * Rules for this test.
    */
   constraint fix_stim_cons {
      // env_cfg.scoreboarding_enabled == 1; // TODO Uncomment this line to enable scoreboarding for this test
   }


   /**
    * Default constructor.
    */
   function new(string name="uvmt_mapu_fix_stim_test", uvm_component parent=null);
      super.new(name, parent);
   endfunction

   /**
    * Creates fix_stim_vseq.
    */
   virtual function void create_sequences();
      super.create_sequences();
      fix_stim_vseq = uvme_mapu_fix_stim_vseq_c::type_id::create("fix_stim_vseq");
   endfunction

   /**
    * Runs fix_stim_vseq on vsequencer.
    */
   virtual task main_phase(uvm_phase phase);
      phase.raise_objection(this);
      `uvm_info("TEST", $sformatf("Starting 'fix_stim_vseq' Virtual Sequence:\n%s", fix_stim_vseq.sprint()), UVM_NONE)
      fix_stim_vseq.start(vsequencer);
      `uvm_info("TEST", $sformatf("Finished 'fix_stim_vseq' Virtual Sequence:\n%s", fix_stim_vseq.sprint()), UVM_NONE)
      phase.drop_objection(this);
   endtask

endclass : uvmt_mapu_fix_stim_test_c


`endif // __UVMT_MAPU_FIX_STIM_TEST_SV__