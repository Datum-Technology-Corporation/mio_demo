// Copyright 2022 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_MAPU_DPO_DRV_SV__
`define __UVMA_MAPU_DPO_DRV_SV__


/**
 *
 * @ingroup uvma_mapu_comps
 */
class uvma_mapu_dpo_drv_c extends uvmx_mp_drv_c #(
   .T_MP      (virtual uvma_mapu_if.dpo_drv_mp),
   .T_CFG     (uvma_mapu_cfg_c                ),
   .T_CNTXT   (uvma_mapu_cntxt_c              ),
   .T_SEQ_ITEM(uvma_mapu_dpo_seq_item_c       )
);

   `uvm_component_utils(uvma_mapu_dpo_drv_c)
   `uvmx_mp_drv(dpo_drv_mp, dpo_drv_cb)


   /**
    * Default constructor.
    */
   function new(string name="uvma_mapu_dpo_drv", uvm_component parent=null);
      super.new(name, parent);
   endfunction

   /**
    * Drives #mp signals using #req's contents on the next clock cycle.
    */
   virtual task drive_item(ref uvma_mapu_dpo_seq_item_c item);
      mp.dpo_drv_cb.i_rdy <= item.i_rdy;
   endtask

   /**
    * Samples #mp signals on the next clock edge for the last transaction.
    */
   virtual task sample_post_clk(ref uvma_mapu_dpo_seq_item_c item);
      item.o_vld = mp.dpo_drv_cb.o_vld;
      item.o_r0  = mp.dpo_drv_cb.o_r0 ;
      item.o_r1  = mp.dpo_drv_cb.o_r1 ;
      item.o_r2  = mp.dpo_drv_cb.o_r2 ;
      item.o_r3  = mp.dpo_drv_cb.o_r3 ;
   endtask

endclass : uvma_mapu_dpo_drv_c


`endif // __UVMA_MAPU_DPO_DRV_SV__
