// Copyright 2022 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_MAPU_RAND_ILL_STIM_TEST_SV__
`define __UVMT_MAPU_RAND_ILL_STIM_TEST_SV__


/**
 * Test which runs Virtual Sequence 'rand_ill_stim_vseq' for 10 items of completely random, partially illegal stimulus.
 * @ingroup uvmt_mapu_tests
 */
class uvmt_mapu_rand_ill_stim_test_c extends uvmt_mapu_base_test_c;

   rand uvme_mapu_rand_ill_stim_vseq_c  rand_ill_stim_vseq; ///< Virtual Sequence to be run


   `uvm_component_utils(uvmt_mapu_rand_ill_stim_test_c)


   /**
    * Rules for this test.
    */
   constraint rand_stim_cons {
      // env_cfg.scoreboarding_enabled == 1; // TODO Uncomment this line to enable scoreboarding for this test
      if (test_cfg.cli_num_items_override) {
         rand_ill_stim_vseq.num_items == test_cfg.cli_num_items;
      }
      else {
         rand_ill_stim_vseq.num_items == 10;
      }
   }


   /**
    * Default constructor.
    */
   function new(string name="uvmt_mapu_fixed_stim_test", uvm_component parent=null);
      super.new(name, parent);
   endfunction

   /**
    * Creates rand_stim_vseq
    */
   virtual function void create_sequences();
      super.create_sequences();
      rand_ill_stim_vseq = uvme_mapu_rand_ill_stim_vseq_c::type_id::create("rand_ill_stim_vseq");
   endfunction

   /**
    * Runs fixed_stim_vseq on vsequencer.
    */
   virtual task main_phase(uvm_phase phase);
      phase.raise_objection(this);
      `uvm_info("TEST", $sformatf("Starting Virtual Sequence:\n%s", rand_ill_stim_vseq.sprint()), UVM_NONE)
      rand_ill_stim_vseq.start(vsequencer);
      `uvm_info("TEST", $sformatf("Finished Virtual Sequence:\n%s", rand_ill_stim_vseq.sprint()), UVM_NONE)
      phase.drop_objection(this);
   endtask

endclass : uvmt_mapu_rand_ill_stim_test_c


`endif // __UVMT_MAPU_RAND_ILL_STIM_TEST_SV__