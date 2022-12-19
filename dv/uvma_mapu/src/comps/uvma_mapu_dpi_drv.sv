// Copyright 2022 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_MAPU_DPI_DRV_SV__
`define __UVMA_MAPU_DPI_DRV_SV__


/**
 *
 * @ingroup uvma_mapu_comps
 */
class uvma_mapu_dpi_drv_c extends uvmx_mp_drv_c #(
   .T_MP      (virtual uvma_mapu_if.dpi_drv_mp),
   .T_CFG     (uvma_mapu_cfg_c                ),
   .T_CNTXT   (uvma_mapu_cntxt_c              ),
   .T_SEQ_ITEM(uvma_mapu_dpi_seq_item_c       )
);

   `uvm_component_utils(uvma_mapu_dpi_drv_c)
   `uvmx_mp_drv(dpi_drv_mp, dpi_drv_cb)


   /**
    * Default constructor.
    */
   function new(string name="uvma_mapu_dpi_drv", uvm_component parent=null);
      super.new(name, parent);
   endfunction

   /**
    * Drives #mp signals using #req's contents on the next clock cycle.
    */
   virtual task drive_item(ref uvma_mapu_dpi_seq_item_c item);
      mp.dpi_drv_cb.i_vld <= item.i_vld;
      mp.dpi_drv_cb.i_r0  <= item.i_r0 ;
      mp.dpi_drv_cb.i_r1  <= item.i_r1 ;
      mp.dpi_drv_cb.i_r2  <= item.i_r2 ;
      mp.dpi_drv_cb.i_r3  <= item.i_r3 ;
      item.o_rdy = mp.dpi_drv_cb.o_rdy;
   endtask

   /**
    * Zero-out unused data bits.
    */
   virtual function void process_item(ref uvma_mapu_dpi_seq_item_c item);
      `uvmx_trim(item.i_r0, cfg.data_width)
      `uvmx_trim(item.i_r1, cfg.data_width)
      `uvmx_trim(item.i_r2, cfg.data_width)
      `uvmx_trim(item.i_r3, cfg.data_width)
   endfunction

endclass : uvma_mapu_dpi_drv_c


`endif // __UVMA_MAPU_DPI_DRV_SV__
