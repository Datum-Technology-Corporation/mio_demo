// Copyright 2023 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_MAPU_CFG_SV__
`define __UVMA_MAPU_CFG_SV__


/**
 * Object encapsulating all parameters for creating, connecting and running all Matrix APU Agent (uvma_mapu_agent_c) components.
 * @ingroup uvma_mapu_obj
 */
class uvma_mapu_cfg_c extends uvmx_agent_cfg_c;

   /// @name Integrals
   /// @{ 
   rand int unsigned data_width; ///< Selected data bit width.
   /// @}

   /// @name Virtual Sequence Types
   /// @{
   uvm_object_wrapper  in_drv_vseq_type ; ///< Virtual Sequence Type driving data into the DUT.
   uvm_object_wrapper  out_drv_vseq_type; ///< Virtual Sequence Type driving data out of the DUT.
   /// @}


   `uvm_object_utils_begin(uvma_mapu_cfg_c)
      `uvm_field_int (                         enabled        , UVM_DEFAULT)
      `uvm_field_enum(uvm_active_passive_enum, is_active      , UVM_DEFAULT)
      `uvm_field_int (                         bypass_mode    , UVM_DEFAULT)
      `uvm_field_enum(uvmx_reset_type_enum   , reset_type     , UVM_DEFAULT)
      `uvm_field_enum(uvm_sequencer_arb_mode , sqr_arb_mode   , UVM_DEFAULT)
      `uvm_field_int (                         trn_log_enabled, UVM_DEFAULT)
   `uvm_object_utils_end


   /**
    * Sets default values for all variable width buses.
    */
   constraint defaults_cons {
      soft data_width == uvma_mapu_data_default_width;
   }

   /**
    * * Disables the agent coverage model (model is in IP 'uvme_mapu')
    * * Sets max sizes for all variable width buses
    */
   constraint rules_cons {
      cov_model_enabled == 0;
      data_width <= `UVMA_MAPU_DATA_MAX_WIDTH;
      // TODO Add rules to constrain data_width
      //      Ex: data_width inside {32,64};
   }


   /**
    * Default constructor.
    */
   function new(string name="uvma_mapu_cfg");
      super.new(name);
   endfunction

   /**
    * Sets default Virtual Sequence types.
    */
   function void pre_randomize();
      super.pre_randomize();
      mon_vseq_type     = uvma_mapu_mon_vseq_c    ::get_type();
      idle_vseq_type    = uvma_mapu_idle_vseq_c   ::get_type();
      in_drv_vseq_type  = uvma_mapu_in_drv_vseq_c ::get_type();
      out_drv_vseq_type = uvma_mapu_out_drv_vseq_c::get_type();
   endfunction

endclass : uvma_mapu_cfg_c


`endif // __UVMA_MAPU_CFG_SV__