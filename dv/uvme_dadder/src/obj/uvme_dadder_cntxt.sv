// Copyright 2022 Contributors
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_DADDER_CNTXT_SV__
`define __UVME_DADDER_CNTXT_SV__


/**
 * Object encapsulating all state variables for Decimal adder/subtracter Block environment (uvme_dadder_env_c) components.
 * @ingroup uvme_dadder_obj
 */
class uvme_dadder_cntxt_c extends uvml_cntxt_c;

   virtual uvme_dadder_probe_if  probe_vif; ///< Handle to DUT probe interface

   /// @name Integrals
   /// @{
   uvml_reset_state_enum  reset_state; ///< Predicted Pre/In/Post reset state of the DUT
   /// @}

   /// @name Agents
   /// @{
   uvma_clk_cntxt_c    clk_cntxt  ; ///< Clock agent context
   uvma_reset_cntxt_c  reset_cntxt; ///< Reset agent context
   uvma_dadder_cp_cntxt_c      cp_cntxt    ; ///< Control plane agent content
   uvma_dadder_dp_in_cntxt_c   dp_in_cntxt ; ///< Data plane input agent content
   uvma_dadder_dp_out_cntxt_c  dp_out_cntxt; ///< Data plane output agent content
   /// @}

   /// @name Objects
   /// @{
   uvml_sb_simplex_cntxt_c  sb_cntxt      ; ///< Data path scoreboard context
   uvm_event                sample_cfg_e  ; ///< Triggers sampling of environment configuration by the functional coverage model.
   uvm_event                sample_cntxt_e; ///< Triggers sampling of environment context by the functional coverage model.
   /// @}


   `uvm_object_utils_begin(uvme_dadder_cntxt_c)
      `uvm_field_object(clk_cntxt   , UVM_DEFAULT)
      `uvm_field_object(reset_cntxt , UVM_DEFAULT)
      `uvm_field_object(cp_cntxt    , UVM_DEFAULT)
      `uvm_field_object(dp_in_cntxt , UVM_DEFAULT)
      `uvm_field_object(dp_out_cntxt, UVM_DEFAULT)
      `uvm_field_object(sb_cntxt      , UVM_DEFAULT)
      `uvm_field_event (sample_cfg_e  , UVM_DEFAULT)
      `uvm_field_event (sample_cntxt_e, UVM_DEFAULT)
   `uvm_object_utils_end


   /**
    * Builds events and sub-context objects.
    */
   extern function new(string name="uvme_dadder_cntxt");


   /**
    * Returns all state variables to initial values.
    */
   extern function void reset();

endclass : uvme_dadder_cntxt_c


function uvme_dadder_cntxt_c::new(string name="uvme_dadder_cntxt");

   super.new(name);
   reset_state = UVML_RESET_STATE_PRE_RESET;
   clk_cntxt    = uvma_clk_cntxt_c  ::type_id::create("clk_cntxt"  );
   reset_cntxt  = uvma_reset_cntxt_c::type_id::create("reset_cntxt");
   cp_cntxt     = uvma_dadder_cp_cntxt_c    ::type_id::create("cp_cntxt"    );
   dp_in_cntxt  = uvma_dadder_dp_in_cntxt_c ::type_id::create("dp_in_cntxt" );
   dp_out_cntxt = uvma_dadder_dp_out_cntxt_c::type_id::create("dp_out_cntxt");
   sb_cntxt       = uvml_sb_simplex_cntxt_c::type_id::create("sb_cntxt");
   sample_cfg_e   = new("sample_cfg_e"  );
   sample_cntxt_e = new("sample_cntxt_e");

endfunction : new


function void uvme_dadder_cntxt_c::reset();

   cp_cntxt    .reset();
   dp_in_cntxt .reset();
   dp_out_cntxt.reset();

endfunction : reset


`endif // __UVME_DADDER_CNTXT_SV__