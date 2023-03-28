// Copyright 2023 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_MAPU_FIX_ILL_STIM_TEST_SV__
`define __UVMT_MAPU_FIX_ILL_STIM_TEST_SV__


/**
 * Self-checking Test which runs Virtual Sequence 'fix_ill_stim_vseq': reference partially illegal stimulus for the DUT.
 * @ingroup uvmt_mapu_tests
 */
class uvmt_mapu_fix_ill_stim_test_c extends uvmt_mapu_base_test_c;

   rand uvme_mapu_fix_ill_stim_vseq_c  fix_ill_stim_vseq; ///< Virtual Sequence run during main_phase.


   `uvm_component_utils(uvmt_mapu_fix_ill_stim_test_c)


   /**
    * Keep 'i_rdy' always ON.
    */
   constraint fix_ill_stim_cons {
      env_cfg.scoreboarding_enabled == 1;
      env_cfg.agent_cfg.out_drv_ton_pct == 100;
   }


   /**
    * Default constructor.
    */
   function new(string name="uvmt_mapu_fix_ill_stim_test", uvm_component parent=null);
      super.new(name, parent);
   endfunction

   /**
    * Creates fix_ill_stim_vseq.
    */
   virtual function void create_sequences();
      super.create_sequences();
      fix_ill_stim_vseq = uvme_mapu_fix_ill_stim_vseq_c::type_id::create("fix_ill_stim_vseq");
   endfunction

   /**
    * Runs fix_ill_stim_vseq on vsequencer.
    */
   virtual task main_phase(uvm_phase phase);
      phase.raise_objection(this);
      `uvm_info("TEST", $sformatf("Starting 'fix_ill_stim_vseq' Virtual Sequence:\n%s", fix_ill_stim_vseq.sprint()), UVM_NONE)
      fix_ill_stim_vseq.start(vsequencer);
      `uvm_info("TEST", $sformatf("Finished 'fix_ill_stim_vseq' Virtual Sequence:\n%s", fix_ill_stim_vseq.sprint()), UVM_NONE)
      phase.drop_objection(this);
   endtask

   /**
    * Ensures that error events were observed and predicted.
    */
   virtual function void check_phase(uvm_phase phase);
      super.check_phase(phase);
      if (env_cntxt.prd_overflow_count == 0) begin
         `uvm_error("TEST", "Did not create overflow condition during test")
      end
      if (env_cntxt.agent_cntxt.mon_overflow_count == 0) begin
         `uvm_error("TEST", "Did not observe overflow during test")
      end
   endfunction : check_phase

endclass : uvmt_mapu_fix_ill_stim_test_c


`endif // __UVMT_MAPU_FIX_ILL_STIM_TEST_SV__