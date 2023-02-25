// Copyright 2023 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_MAPU_BASE_TEST_SV__
`define __UVMT_MAPU_BASE_TEST_SV__


/**
 * Component from which all other Matrix APU Block tests must extend.
 * Subclasses must provide stimulus via the virtual sequencer by implementing UVM runtime phases.
 * @ingroup uvmt_mapu_tests
 */
class uvmt_mapu_base_test_c extends uvmx_test_c #(
   .T_CFG      (uvmt_mapu_test_cfg_c),
   .T_ENV_CFG  (uvme_mapu_cfg_c     ),
   .T_ENV_CNTXT(uvme_mapu_cntxt_c   ),
   .T_ENV      (uvme_mapu_env_c     ),
   .T_ENV_VSQR (uvme_mapu_vsqr_c    )
);

   /// @name Agents
   /// @{
   uvma_clk_agent_c    clk_agent  ; ///<
   uvma_reset_agent_c  reset_agent; ///<
   /// @}

   /// @name Default sequences
   /// @{
   rand uvma_clk_start_vseq_c    clk_vseq  ; ///< Starts clock generation during pre_reset_phase()
   rand uvma_reset_pulse_vseq_c  reset_vseq; ///< Asserts reset during reset_phase()
   /// @}


   `uvm_component_utils_begin(uvmt_mapu_base_test_c)
      `uvm_field_object(test_cfg , UVM_DEFAULT)
      `uvm_field_object(env_cfg  , UVM_DEFAULT)
      `uvm_field_object(env_cntxt, UVM_DEFAULT)
   `uvm_component_utils_end
   `include "uvmt_mapu_base_test_workarounds.sv"


   /**
    * Describe rules_cons
    */
   constraint rules_cons {
      clk_vseq.frequency         == test_cfg.clk_frequency    ;
      env_cfg .reset_type        == test_cfg.reset_type       ;
      env_cfg .trn_log_enabled   == test_cfg.trn_log_enabled  ;
      env_cfg .cov_model_enabled == test_cfg.cov_model_enabled;
   }


   /**
    * Default constructor.
    */
   function new(string name="uvmt_mapu_base_test", uvm_component parent=null);
      super.new(name, parent);
   endfunction

   /**
    *
    */
   virtual function void create_components();
      clk_agent   = uvma_clk_agent_c  ::type_id::create("clk_agent"  , this);
      reset_agent = uvma_reset_agent_c::type_id::create("reset_agent", this);
   endfunction

   /**
    *
    */
   virtual function void connect_env_reset();
      reset_agent.reset_mon_trn_ap.connect(env.reset_mon_trn_export);
   endfunction

   /**
    *
    */
   virtual function void assign_cfg();
      uvm_config_db#(uvma_clk_cfg_c  )::set(this, "clk_agent"  , "cfg", test_cfg.clk_agent_cfg  );
      uvm_config_db#(uvma_reset_cfg_c)::set(this, "reset_agent", "cfg", test_cfg.reset_agent_cfg);
   endfunction

   /**
    *
    */
   virtual function void create_sequences();
      clk_vseq   = uvma_clk_start_vseq_c  ::type_id::create("clk_vseq"  );
      reset_vseq = uvma_reset_pulse_vseq_c::type_id::create("reset_vseq");
   endfunction

   /**
    * Runs clk_vseq.
    */
   virtual task pre_reset_phase(uvm_phase phase);
      phase.raise_objection(this);
      `uvm_info("TEST", $sformatf("Starting Clock Virtual Sequence:\n%s", clk_vseq.sprint()), UVM_NONE)
      clk_vseq.start(clk_agent.vsequencer);
      `uvm_info("TEST", $sformatf("Finished Clock Virtual Sequence:\n%s", clk_vseq.sprint()), UVM_NONE)
      phase.drop_objection(this);
   endtask

   /**
    * Runs reset_vseq.
    */
   virtual task reset_phase(uvm_phase phase);
      phase.raise_objection(this);
      `uvm_info("TEST", $sformatf("Starting Reset Virtual Sequence:\n%s", reset_vseq.sprint()), UVM_NONE)
      reset_vseq.start(reset_agent.vsequencer);
      `uvm_info("TEST", $sformatf("Finished Reset Virtual Sequence", reset_vseq.sprint()), UVM_NONE)
      phase.drop_objection(this);
   endtask

endclass : uvmt_mapu_base_test_c


`endif // __UVMT_MAPU_BASE_TEST_SV__