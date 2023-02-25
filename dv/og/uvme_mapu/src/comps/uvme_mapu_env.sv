// Copyright 2023 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_MAPU_ENV_SV__
`define __UVME_MAPU_ENV_SV__


/**
 * Top-level component that encapsulates, builds and connects all other Matrix APU Block environment components.
 * @ingroup uvme_mapu_comps
 */
class uvme_mapu_env_c extends uvmx_env_c #(
   .T_CFG      (uvme_mapu_cfg_c      ),
   .T_CNTXT    (uvme_mapu_cntxt_c    ),
   .T_VSQR     (uvme_mapu_vsqr_c     ),
   .T_PRD      (uvme_mapu_prd_c      ),
   .T_SB       (uvme_mapu_sb_c       ),
   .T_COV_MODEL(uvme_mapu_cov_model_c)
);

   /// @name Agents
   /// @{
   uvma_mapu_agent_c  agent; ///< Block agent
   /// @}


   `uvm_component_utils(uvme_mapu_env_c)


   /**
    * Default constructor.
    */
   function new(string name="uvme_mapu_env", uvm_component parent=null);
      super.new(name, parent);
   endfunction

   /**
    * Retrieves probe_vif in #cntxt using uvm_config_db.
    */
   virtual function void get_vifs();
      if (!uvm_config_db#(virtual uvme_mapu_probe_if)::get(this, "", "vif", cntxt.probe_vif)) begin
         `uvm_fatal("MAPU_ENV", $sformatf("Could not find probe_vif handle of type %s in uvm_config_db", $typename(cntxt.probe_vif)))
      end
      else begin
         `uvm_info("MAPU_ENV", $sformatf("Found probe_vif handle of type %s in uvm_config_db", $typename(cntxt.probe_vif)), UVM_DEBUG)
      end
   endfunction

   /**
    * Assigns configuration handles to components using UVM Configuration Database.
    */
   virtual function void assign_cfg();
      uvm_config_db#(uvma_mapu_cfg_c)::set(this, "agent", "cfg", cfg.agent_cfg);
      uvm_config_db#(uvml_sb_simplex_cfg_c)::set(this, "scoreboard", "cfg", cfg.sb_cfg);
   endfunction

   /**
    * Assigns context handles to components using UVM Configuration Database.
    */
   virtual function void assign_cntxt();
      uvm_config_db#(uvma_mapu_cntxt_c)::set(this, "agent", "cntxt", cntxt.agent_cntxt);
      uvm_config_db#(uvml_sb_simplex_cntxt_c)::set(this, "scoreboard", "cntxt", cntxt.sb_cntxt);
   endfunction

   /**
    * Creates agent components.
    */
   virtual function void create_agents();
      agent = uvma_mapu_agent_c::type_id::create("agent", this);
   endfunction

   /**
    * Connects agents to predictor.
    */
   virtual function void connect_predictor();
      agent.in_mon_trn_ap.connect(predictor.in_fifo.analysis_export);
   endfunction

   /**
    * Connects scoreboards components to agents/predictor.
    */
   virtual function void connect_scoreboard();
      predictor.out_ap        .connect(scoreboard.exp_export);
      agent    .out_mon_trn_ap.connect(scoreboard.act_export);
   endfunction

   /**
    * Connects environment coverage model to agents/scoreboards/predictor.
    */
   virtual function void connect_coverage_model();
      agent.seq_item_ap   .connect(cov_model.seq_item_fifo   .analysis_export);
      agent.in_mon_trn_ap .connect(cov_model.in_mon_trn_fifo .analysis_export);
      agent.out_mon_trn_ap.connect(cov_model.out_mon_trn_fifo.analysis_export);
      agent.cp_mon_trn_ap .connect(cov_model.cp_mon_trn_fifo .analysis_export);
      agent.dpi_mon_trn_ap.connect(cov_model.dpi_mon_trn_fifo.analysis_export);
      agent.dpo_mon_trn_ap.connect(cov_model.dpo_mon_trn_fifo.analysis_export);
   endfunction

   /**
    * Assembles virtual sequencer from agent sequencers.
    */
   virtual function void assemble_vsequencer();
      vsequencer.agent_vsequencer = agent.vsequencer;
   endfunction

endclass : uvme_mapu_env_c


`endif // __UVME_MAPU_ENV_SV__
