// Copyright 2023 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_MAPU_CNTXT_SV__
`define __UVMA_MAPU_CNTXT_SV__


/**
 * Object encapsulating all state variables for all Matrix APU Agent (uvma_mapu_agent_c) components.
 * @ingroup uvma_mapu_obj
 */
class uvma_mapu_cntxt_c extends uvmx_block_agent_cntxt_c #(
   .T_VIF(virtual uvma_mapu_if)
);
   /// @name Integrals
   /// @{
   bit           mon_overflow      ; ///< Current out trn has been flagged as overflowed.
   int unsigned  mon_overflow_count; ///< Count of out trn monitored with overflow=1.
   /// @}

   /// @name Objects
   /// @{
   /// @}

   /// @name Virtual Sequences
   /// @{
   uvm_sequence_base  in_drv_vseq ; ///< Virtual Sequence driving data into the DUT.
   uvm_sequence_base  out_drv_vseq; ///< Virtual Sequence driving data out of the DUT.
   /// @}


   `uvm_object_utils_begin(uvma_mapu_cntxt_c)
      `uvm_field_enum(uvmx_reset_state_enum, reset_state, UVM_DEFAULT)
      `uvm_field_object(in_drv_vseq , UVM_DEFAULT)
      `uvm_field_object(out_drv_vseq, UVM_DEFAULT)
      `uvm_field_int(mon_overflow      , UVM_DEFAULT          )
      `uvm_field_int(mon_overflow_count, UVM_DEFAULT + UVM_DEC)
   `uvm_object_utils_end


   /**
    * Creates event objects.
    */
   function new(string name="uvma_mapu_cntxt");
      super.new(name);
   endfunction

   /**
    * Returns all state variables to initial values.
    */
   virtual function void reset();
      mon_overflow       = 0;
      mon_overflow_count = 0;
   endfunction

endclass : uvma_mapu_cntxt_c


`endif // __UVMA_MAPU_CNTXT_SV__