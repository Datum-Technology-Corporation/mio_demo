// Copyright 2023 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_MAPU_BASE_TEST_SV__
`define __UVMT_MAPU_BASE_TEST_SV__


/**
 * Abstract Test from which all other Matrix APU Block Tests must extend.
 * Subclasses must provide stimulus via vsequencer by implementing UVM runtime phases.
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
   uvma_clk_agent_c    clk_agent  ; ///< Clock agent.
   uvma_reset_agent_c  reset_agent; ///< Reset agent.
   /// @}

   /// @name Default Sequences
   /// @{
   rand uvma_clk_start_vseq_c    clk_vseq  ; ///< Starts clock generation during pre_reset_phase.
   rand uvma_reset_pulse_vseq_c  reset_vseq; ///< Asserts reset during reset_phase.
   /// @}


   `uvm_component_utils(uvmt_mapu_base_test_c)
   `include "uvmt_mapu_base_test_workarounds.sv"


   /**
    * Describe rules_cons
    */
   constraint rules_cons {
      clk_vseq.frequency         == test_cfg.clk_frequency    ;
      env_cfg .reset_type        == test_cfg.reset_type       ;
      env_cfg .trn_log_enabled   == test_cfg.trn_log_enabled  ;
      env_cfg .cov_model_enabled == test_cfg.cov_model_enabled;
      env_cfg .data_width == `UVMT_MAPU_DATA_WIDTH;
   }


   /**
    * Default constructor.
    */
   function new(string name="uvmt_mapu_base_test", uvm_component parent=null);
      super.new(name, parent);
   endfunction

   /**
    * Creates Agent components.
    */
   virtual function void create_components();
      clk_agent   = uvma_clk_agent_c  ::type_id::create("clk_agent"  , this);
      reset_agent = uvma_reset_agent_c::type_id::create("reset_agent", this);
   endfunction

   /**
    * Connects the reset agent to the environment's reset port.
    */
   virtual function void connect_env_reset();
      reset_agent.reset_mon_trn_ap.connect(env.reset_mon_trn_export);
   endfunction

   /**
    * Assigns configuration objects to Agents.
    */
   virtual function void assign_cfg();
      uvm_config_db#(uvma_clk_cfg_c  )::set(this, "clk_agent"  , "cfg", test_cfg.clk_agent_cfg  );
      uvm_config_db#(uvma_reset_cfg_c)::set(this, "reset_agent", "cfg", test_cfg.reset_agent_cfg);
   endfunction

   /**
    * Creates Sequences.
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

   /**
    * Ensures that the number of overflow events observed and predicted match.
    */
   virtual function void check_phase(uvm_phase phase);
      if (env_cntxt.prd_overflow_count != env_cntxt.agent_cntxt.mon_overflow_count) begin
         `uvm_error("TEST", $sformatf("Number of predicte overflow events (%0d) and observed (%0d) do not match", env_cntxt.prd_overflow_count, env_cntxt.agent_cntxt.mon_overflow_count))
      end
   endfunction : check_phase

endclass : uvmt_mapu_base_test_c


`endif // __UVMT_MAPU_BASE_TEST_SV__