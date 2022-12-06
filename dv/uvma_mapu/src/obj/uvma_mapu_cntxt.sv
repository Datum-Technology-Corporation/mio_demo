// Copyright 2022 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_MAPU_CNTXT_SV__
`define __UVMA_MAPU_CNTXT_SV__


/**
 * Object encapsulating all state variables for all Matrix APU agent (uvma_mapu_agent_c) components.
 * @ingroup uvma_mapu_obj
 */
class uvma_mapu_cntxt_c extends uvmx_agent_cntxt_c #(
   .T_VIF(virtual uvma_mapu_if)
);
   /// @name Integrals
   /// @{
   /// @}

   /// @name Objects
   /// @{
   /// @}

   /// @name Sequences
   /// @{
   uvm_sequence_base  drv_in_vseq ; ///<
   uvm_sequence_base  drv_out_vseq; ///<
   /// @}


   `uvm_object_utils_begin(uvma_mapu_cntxt_c)
      `uvm_field_enum(uvmx_reset_state_enum, reset_state, UVM_DEFAULT)
      `uvm_field_object(drv_in_vseq , UVM_DEFAULT)
      `uvm_field_object(drv_out_vseq, UVM_DEFAULT)
   `uvm_object_utils_end


   /**
    * Creates event objects.
    */
   function new(string name="uvma_mapu_cntxt");
      super.new(name);
   endfunction

   /**
    * Returns all state variables to initial values.
    * Called by monitor (uvma_mapu_mon_c) when it witnesses a reset pulse.
    */
   virtual function void reset();
      // TODO Implement uvma_mapu_cntxt_c::reset()
      //      Ex: abc = 0;
   endfunction

endclass : uvma_mapu_cntxt_c


`endif // __UVMA_MAPU_CNTXT_SV__
