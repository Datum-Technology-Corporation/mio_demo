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
   rand int unsigned  data_width; ///<
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
      `uvm_field_int (                         data_width           , UVM_DEFAULT + UVM_DEC)
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
      agent_cfg.data_width == data_width;
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
      sb_cfg.enabled            == scoreboarding_enabled;
      sb_cfg.mode               == UVML_SB_MODE_IN_ORDER;
      sb_cfg.ignore_first_n_act == 0;
      sb_cfg.ignore_first_n_exp == 0;
      sb_cfg.log_enabled        == 1;
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
      sb_cfg    = uvml_sb_simplex_cfg_c::type_id::create("sb_cfg");
   endfunction

   /**
    *
    */
   function void post_randomize();
      sb_cfg.add_to_log("ovf");
      sb_cfg.add_to_log("m[0][0]");
      sb_cfg.add_to_log("m[0][1]");
      sb_cfg.add_to_log("m[0][2]");
      sb_cfg.add_to_log("m[0][3]");
      sb_cfg.add_to_log("m[1][0]");
      sb_cfg.add_to_log("m[1][1]");
      sb_cfg.add_to_log("m[1][2]");
      sb_cfg.add_to_log("m[1][3]");
      sb_cfg.add_to_log("m[2][0]");
      sb_cfg.add_to_log("m[2][1]");
      sb_cfg.add_to_log("m[2][2]");
      sb_cfg.add_to_log("m[2][3]");
      sb_cfg.add_to_log("m[3][0]");
      sb_cfg.add_to_log("m[3][1]");
      sb_cfg.add_to_log("m[3][2]");
      sb_cfg.add_to_log("m[3][3]");
   endfunction

endclass : uvme_mapu_cfg_c


`endif // __UVME_MAPU_CFG_SV__
