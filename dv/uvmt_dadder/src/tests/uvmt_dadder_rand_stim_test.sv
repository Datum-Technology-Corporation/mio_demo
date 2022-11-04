// Copyright 2022 Contributors
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_DADDER_RAND_STIM_TEST_SV__
`define __UVMT_DADDER_RAND_STIM_TEST_SV__


/**
 * Test which runs virtual sequence 'rand_stim_vseq' for 10 items of completely random stimulus.
 * @ingroup uvmt_dadder_tests
 */
class uvmt_dadder_rand_stim_test_c extends uvmt_dadder_base_test_c;

   rand uvme_dadder_rand_stim_vseq_c  rand_stim_vseq; ///< Virtual sequence to be run


   `uvm_component_utils(uvmt_dadder_rand_stim_test_c)


   /**
    * Rules for this test.
    */
   constraint rand_stim_cons {
      env_cfg.scoreboarding_enabled == 1;
      if (test_cfg.cli_num_items_override) {
         rand_stim_vseq.num_items == test_cfg.cli_num_items_parsed;
      }
      else {
         rand_stim_vseq.num_items == 10;
      }
   }


   /**
    * Creates rand_stim_vseq.
    */
   extern function new(string name="uvmt_dadder_rand_stim_test", uvm_component parent=null);

   /**
    * Runs rand_stim_vseq on vsequencer.
    */
   extern virtual task main_phase(uvm_phase phase);

endclass : uvmt_dadder_rand_stim_test_c


function uvmt_dadder_rand_stim_test_c::new(string name="uvmt_dadder_rand_stim_test", uvm_component parent=null);

   super.new(name, parent);
   rand_stim_vseq = uvme_dadder_rand_stim_vseq_c::type_id::create("rand_stim_vseq");

endfunction : new


task uvmt_dadder_rand_stim_test_c::main_phase(uvm_phase phase);

   super.main_phase(phase);
   phase.raise_objection(this);
   `uvm_info("TEST", $sformatf("Starting rand_stim virtual sequence:\n%s", rand_stim_vseq.sprint()), UVM_NONE)
   rand_stim_vseq.start(vsequencer);
   `uvm_info("TEST", $sformatf("Finished rand_stim virtual sequence:\n%s", rand_stim_vseq.sprint()), UVM_NONE)
   phase.drop_objection(this);

endtask : main_phase


`endif // __UVMT_DADDER_RAND_STIM_TEST_SV__