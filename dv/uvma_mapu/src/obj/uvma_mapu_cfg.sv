// Copyright 2022 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_MAPU_CFG_SV__
`define __UVMA_MAPU_CFG_SV__


/**
 * Object encapsulating all parameters for creating, connecting and running all Matrix APU agent (uvma_mapu_agent_c) components.
 * @ingroup uvma_mapu_obj
 */
class uvma_mapu_cfg_c extends uvmx_agent_cfg_c;

   /// @name Integrals
   /// @{
   rand int unsigned  data_width; ///<
   rand int unsigned  ton       ; ///<
   /// @}

   /// @name Sequence Types
   /// @{
   uvm_object_wrapper  drv_in_vseq_type ; ///<
   uvm_object_wrapper  drv_out_vseq_type; ///<
   /// @}


   `uvm_object_utils_begin(uvma_mapu_cfg_c)
      `uvm_field_int (                         enabled        , UVM_DEFAULT)
      `uvm_field_enum(uvm_active_passive_enum, is_active      , UVM_DEFAULT)
      `uvm_field_int (                         data_width     , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int (                         ton            , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int (                         bypass_mode    , UVM_DEFAULT)
      `uvm_field_enum(uvmx_reset_type_enum   , reset_type     , UVM_DEFAULT)
      `uvm_field_enum(uvm_sequencer_arb_mode , sqr_arb_mode   , UVM_DEFAULT)
      `uvm_field_int (                         trn_log_enabled, UVM_DEFAULT)
   `uvm_object_utils_end


   /**
    * Rules for safe default options: enabled, passive, synchronous reset with transaction logging enabled.
    */
   constraint defaults_cons {
      soft data_width == uvma_mapu_default_data_width;
   }

   /**
    * Coverage model is in the environment.
    */
   constraint limits_cons {
      cov_model_enabled == 0;
      data_width <= `UVMA_MAPU_MAX_DATA_WIDTH;
      ton inside {[1:100]};
   }


   /**
    * Default constructor.
    */
   function new(string name="uvma_mapu_cfg");
      super.new(name);
   endfunction

   /**
    *
    */
   function void post_randomize();
      mon_vseq_type     = uvma_mapu_mon_vseq_c    ::get_type();
      idle_vseq_type    = uvma_mapu_idle_vseq_c   ::get_type();
      drv_in_vseq_type  = uvma_mapu_drv_in_vseq_c ::get_type();
      drv_out_vseq_type = uvma_mapu_drv_out_vseq_c::get_type();
   endfunction

endclass : uvma_mapu_cfg_c


`endif // __UVMA_MAPU_CFG_SV__
