// Copyright 2023 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_MAPU_DRV_SV__
`define __UVMA_MAPU_DRV_SV__


/**
 * Component driving a Matrix APU virtual interface (uvma_mapu_if) with contents from uvma_mapu_seq_item_c requests.
 * @ingroup uvma_mapu_comps
 */
class uvma_mapu_drv_c extends uvmx_drv_c #(
   .T_CFG     (uvma_mapu_cfg_c  ),
   .T_CNTXT   (uvma_mapu_cntxt_c)
);

   /// @name Components
   /// @{
   uvma_mapu_cp_drv_c   cp_driver ; ///<
   uvma_mapu_dpi_drv_c  dpi_driver; ///<
   uvma_mapu_dpo_drv_c  dpo_driver; ///<
   /// @}


   `uvm_component_utils(uvma_mapu_drv_c)


   /**
    * Default constructor.
    */
   function new(string name="uvma_mapu_drv", uvm_component parent=null);
      super.new(name, parent);
   endfunction

   /**
    *
    */
   virtual function void create_drivers();
      cp_driver  = uvma_mapu_cp_drv_c ::type_id::create("cp_driver" , this);
      dpi_driver = uvma_mapu_dpi_drv_c::type_id::create("dpi_driver", this);
      dpo_driver = uvma_mapu_dpo_drv_c::type_id::create("dpo_driver", this);
   endfunction

endclass : uvma_mapu_drv_c


`endif // __UVMA_MAPU_DRV_SV__