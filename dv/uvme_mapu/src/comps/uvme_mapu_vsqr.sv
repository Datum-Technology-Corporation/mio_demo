// Copyright 2023 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_MAPU_VSQR_SV__
`define __UVME_MAPU_VSQR_SV__


/**
 * Virtual Sequencer running Matrix APU Block Environment Virtual Sequences extending uvme_mapu_base_vseq_c.
 * @ingroup uvme_mapu_comps
 */
class uvme_mapu_vsqr_c extends uvmx_env_vsqr_c #(
   .T_CFG  (uvme_mapu_cfg_c  ),
   .T_CNTXT(uvme_mapu_cntxt_c)
);

   /// @name Sequencers
   /// @{
   uvma_mapu_vsqr_c  agent_vsequencer; ///< Block Agent Sequencer.
   /// @}


   `uvm_component_utils(uvme_mapu_vsqr_c)


   /**
    * Default constructor.
    */
   function new(string name="uvme_mapu_sqr", uvm_component parent=null);
      super.new(name, parent);
   endfunction

endclass : uvme_mapu_vsqr_c


`endif // __UVME_MAPU_VSQR_SV__