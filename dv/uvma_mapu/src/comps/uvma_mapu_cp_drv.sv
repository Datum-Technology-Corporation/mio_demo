// Copyright 2023 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_MAPU_CP_DRV_SV__
`define __UVMA_MAPU_CP_DRV_SV__


/**
 * Driver driving uvma_mapu_if with Control Plane Sequence Items (uvma_mapu_cp_seq_item_c).
 * @ingroup uvma_mapu_comps
 */
class uvma_mapu_cp_drv_c extends uvmx_mp_drv_c #(
   .T_MP      (virtual uvma_mapu_if.cp_drv_mp),
   .T_CFG     (uvma_mapu_cfg_c               ),
   .T_CNTXT   (uvma_mapu_cntxt_c             ),
   .T_SEQ_ITEM(uvma_mapu_cp_seq_item_c       )
);

   `uvm_component_utils(uvma_mapu_cp_drv_c)
   `uvmx_mp_drv(cp_drv_mp, cp_drv_cb)


   /**
    * Default constructor.
    */
   function new(string name="uvma_mapu_cp_drv", uvm_component parent=null);
      super.new(name, parent);
   endfunction

   /**
    * Drives the Control Plane Driver clocking block (cp_drv_cb) on each clock cycle.
    */
   virtual task drive_item(ref uvma_mapu_cp_seq_item_c item);
      mp.cp_drv_cb.i_en <= item.i_en;
      mp.cp_drv_cb.i_op <= item.i_op;
   endtask

   /**
    * Samples the Control Plane Driver clocking block (cp_drv_cb) after each clock cycle.
    */
   virtual task sample_post_clk(ref uvma_mapu_cp_seq_item_c item);
      item.o_of = mp.cp_drv_cb.o_of;
  endtask

endclass : uvma_mapu_cp_drv_c


`endif // __UVMA_MAPU_CP_DRV_SV__