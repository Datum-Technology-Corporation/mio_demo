// Copyright 2022 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_MAPU_CFG_SV__
`define __UVME_MAPU_CFG_SV__


/**
 * Object encapsulating all parameters for creating, connecting and running the Matrix APU Block environment
 * (uvme_mapu_env_c) components.
 * @ingroup uvme_mapu_obj
 */
class uvme_mapu_cfg_c extends uvmx_env_cfg_c;

   // @name Integrals
   /// @{
   /// @}

   /// @name Objects
   /// @{
   rand uvma_mapu_cfg_c  agent_cfg; ///< Control plane agent configuration
   rand uvml_sb_simplex_cfg_c  sb_cfg   ; ///< Data path scoreboard configuration
   /// @}


   `uvm_object_utils_begin(uvme_mapu_cfg_c)
      `uvm_field_int (                         enabled              , UVM_DEFAULT)
      `uvm_field_enum(uvm_active_passive_enum, is_active            , UVM_DEFAULT)
      `uvm_field_enum(uvmx_reset_type_enum   , reset_type           , UVM_DEFAULT)
      `uvm_field_int (                         scoreboarding_enabled, UVM_DEFAULT)
      `uvm_field_int (                         cov_model_enabled    , UVM_DEFAULT)
      `uvm_field_int (                         trn_log_enabled      , UVM_DEFAULT)
      `uvm_field_object(agent_cfg, UVM_DEFAULT)
      `uvm_field_object(sb_cfg   , UVM_DEFAULT)
   `uvm_object_utils_end


   /**
    * Rules for safe default options: enabled, passive with scoreboarding and transaction logging enabled.
    */
   constraint defaults_cons {

   }

   /**
    * Sets agents configuration.
    */
   constraint agent_cfg_cons {
      agent_cfg.reset_type == reset_type;
      if (enabled) {
         agent_cfg.enabled == 1;
      }
      else {
         agent_cfg.enabled == 0;
      }
      if (is_active == UVM_ACTIVE) {
         agent_cfg.is_active == UVM_ACTIVE;
      }
      else {
         agent_cfg.is_active == UVM_PASSIVE;
      }
      if (trn_log_enabled) {
         agent_cfg.trn_log_enabled == 1;
      }
      else {
         agent_cfg.trn_log_enabled == 0;
      }
   }

   /**
    * Sets scoreboard configuration.
    */
   constraint sb_cons {
      sb_cfg.enabled == scoreboarding_enabled;
      sb_cfg.mode    == UVML_SB_MODE_IN_ORDER;
   }


   /**
    * Default constructor.
    */
   function new(string name="uvme_mapu_cfg");
      super.new(name);
   endfunction

   /**
    *
    */
   virtual function void create_objects();
      agent_cfg = uvma_mapu_cfg_c::type_id::create("agent_cfg");
      sb_cfg    = uvml_sb_simplex_cfg_c::type_id::create("sb_cfg"   );
   endfunction

   /**
    *
    */
   function void post_randomize();
      // TODO Add scoreboard transaction log fields
      //      Ex: sb_dp_cfg.add_to_log("abc");
      //          sb_dp_cfg.add_to_log("def");
   endfunction

endclass : uvme_mapu_cfg_c


`endif // __UVME_MAPU_CFG_SV__