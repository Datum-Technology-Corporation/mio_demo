// Copyright 2023 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_MAPU_CNTXT_SV__
`define __UVME_MAPU_CNTXT_SV__


/**
 * Object encapsulating all state variables for Matrix APU Block environment (uvme_mapu_env_c).
 * @ingroup uvme_mapu_obj
 */
class uvme_mapu_cntxt_c extends uvmx_env_cntxt_c;

   /// @name Integrals
   /// @{
   /// @}

   /// @name Objects
   /// @{
   uvma_mapu_cntxt_c  agent_cntxt; ///< Block Agent context.
   uvml_sb_simplex_cntxt_c  sb_cntxt   ; ///< Scoreboard context
   /// @}


   `uvm_object_utils_begin(uvme_mapu_cntxt_c)
      `uvm_field_enum(uvmx_reset_state_enum, reset_state, UVM_DEFAULT)
      `uvm_field_object(agent_cntxt, UVM_DEFAULT)
      `uvm_field_object(sb_cntxt   , UVM_DEFAULT)
   `uvm_object_utils_end


   /**
    * Default constructor.
    */
   function new(string name="uvme_mapu_cntxt");
      super.new(name);
   endfunction

   /**
    * Creates objects.
    */
   virtual function void create_objects();
      agent_cntxt = uvma_mapu_cntxt_c::type_id::create("agent_cntxt");
      sb_cntxt    = uvml_sb_simplex_cntxt_c::type_id::create("sb_cntxt"   );
   endfunction

   /**
    * Returns all state variables to initial values.
    */
   virtual function void reset();
      agent_cntxt.reset();
   endfunction

endclass : uvme_mapu_cntxt_c


`endif // __UVME_MAPU_CNTXT_SV__