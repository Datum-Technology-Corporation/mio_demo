// Copyright 2022 Contributors
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_DADDER_CP_CFG_SV__
`define __UVMA_DADDER_CP_CFG_SV__


/**
 * Object encapsulating all parameters for creating, connecting and running all Decimal adder/subtracter Block Control Plane agent (uvma_dadder_cp_agent_c) components.
 * @ingroup uvma_dadder_cp_obj
 */
class uvma_dadder_cp_cfg_c extends uvml_cfg_c;

   /// @name Generic options
   /// @{
   rand bit                      enabled          ; ///< Components do not execute their run_phase() if '0'.
   rand uvm_active_passive_enum  is_active        ; ///< Driver does not execute its run_phase() if 'UVM_PASSIVE'.
   rand uvml_reset_type_enum     reset_type       ; ///< Sets whether the monitor is sensitive to a/synchronous reset.
   rand uvm_sequencer_arb_mode   sqr_arb_mode     ; ///< Arbitration mode for the sequencer.
   rand bit                      cov_model_enabled; ///< Gates the connection of the functional coverage model.
   rand bit                      trn_log_enabled  ; ///< Gates the connection of the transaction logger.
   /// @}

   /// @name Protocol Options
   /// @{
   rand int unsigned  data_width; ///< Specifies data bus width in bits (b)
   /// @}


   `uvm_object_utils_begin(uvma_dadder_cp_cfg_c)
      `uvm_field_int (                         enabled          , UVM_DEFAULT)
      `uvm_field_enum(uvm_active_passive_enum, is_active        , UVM_DEFAULT)
      `uvm_field_enum(uvml_reset_type_enum   , reset_type       , UVM_DEFAULT)
      `uvm_field_enum(uvm_sequencer_arb_mode , sqr_arb_mode     , UVM_DEFAULT)
      `uvm_field_int (                         cov_model_enabled, UVM_DEFAULT)
      `uvm_field_int (                         trn_log_enabled  , UVM_DEFAULT)
      `uvm_field_int(data_width, UVM_DEFAULT + UVM_DEC)
   `uvm_object_utils_end


   /**
    * Rules for safe default options: enabled, passive, synchronous reset with transaction logging enabled.
    */
   constraint defaults_cons {
      soft enabled           == 1;
      soft is_active         == UVM_PASSIVE;
      soft reset_type        == UVML_RESET_TYPE_SYNCHRONOUS;
      soft sqr_arb_mode      == UVM_SEQ_ARB_FIFO;
      soft cov_model_enabled == 0;
      soft trn_log_enabled   == 1;
      soft data_width        == uvma_dadder_cp_default_data_width;
   }


   /**
    * Default constructor.
    */
   extern function new(string name="uvma_dadder_cp_cfg");

endclass : uvma_dadder_cp_cfg_c


function uvma_dadder_cp_cfg_c::new(string name="uvma_dadder_cp_cfg");

   super.new(name);

endfunction : new


`endif // __UVMA_DADDER_CP_CFG_SV__