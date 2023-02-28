// Copyright 2023 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_MAPU_MON_SV__
`define __UVMA_MAPU_MON_SV__


/**
 * Component sampling Monitor Transactions from Matrix APU Interface (uvma_mapu_if).
 * @ingroup uvma_mapu_comps
 */
class uvma_mapu_mon_c extends uvmx_mon_c #(
   .T_CFG  (uvma_mapu_cfg_c  ),
   .T_CNTXT(uvma_mapu_cntxt_c)
);

   /// @name Components
   /// @{
   uvma_mapu_cp_mon_c   cp_monitor ; ///< Control Plane Monitor.
   uvma_mapu_dpi_mon_c  dpi_monitor; ///< Data Plane Input Monitor.
   uvma_mapu_dpo_mon_c  dpo_monitor; ///< Data Plane Output Monitor.
   /// @}


   `uvm_component_utils(uvma_mapu_mon_c)
   `uvmx_mon_clk  (clk    , UVMX_POS_EDGE  )
   `uvmx_mon_reset(reset_n, UVMX_ACTIVE_LOW)


   /**
    * Default constructor.
    */
   function new(string name="uvma_mapu_mon", uvm_component parent=null);
      super.new(name, parent);
   endfunction

   /**
    * Creates Monitor components.
    */
   virtual function void create_monitors();
      cp_monitor  = uvma_mapu_cp_mon_c ::type_id::create("cp_monitor" , this);
      dpi_monitor = uvma_mapu_dpi_mon_c::type_id::create("dpi_monitor", this);
      dpo_monitor = uvma_mapu_dpo_mon_c::type_id::create("dpo_monitor", this);
   endfunction

endclass : uvma_mapu_mon_c


`endif // __UVMA_MAPU_MON_SV__
