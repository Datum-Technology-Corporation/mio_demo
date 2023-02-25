// Copyright 2023 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_MAPU_DPI_MON_SV__
`define __UVMA_MAPU_DPI_MON_SV__


/**
 *
 * @ingroup uvma_mapu_comps
 */
class uvma_mapu_dpi_mon_c extends uvmx_mp_mon_c #(
   .T_MP     (virtual uvma_mapu_if.dpi_mon_mp),
   .T_CFG    (uvma_mapu_cfg_c                ),
   .T_CNTXT  (uvma_mapu_cntxt_c              ),
   .T_MON_TRN(uvma_mapu_dpi_mon_trn_c        )
);

   `uvm_component_utils(uvma_mapu_dpi_mon_c)
   `uvmx_mp_mon(dpi_mon_mp, dpi_mon_cb)


   /**
    * Default constructor.
    */
   function new(string name="uvma_mapu_dpi_mon", uvm_component parent=null);
      super.new(name, parent);
   endfunction

   /**
    *
    */
   virtual task sample_trn(ref uvma_mapu_dpi_mon_trn_c trn);
      trn.i_vld = mp.dpi_mon_cb.i_vld;
      trn.o_rdy = mp.dpi_mon_cb.o_rdy;
      trn.i_r0  = mp.dpi_mon_cb.i_r0 ;
      trn.i_r1  = mp.dpi_mon_cb.i_r1 ;
      trn.i_r2  = mp.dpi_mon_cb.i_r2 ;
   endtask

   /**
    *
    */
   virtual function void process_trn(ref uvma_mapu_dpi_mon_trn_c trn);
      `uvmx_trim(trn.i_r0, cfg.data_width)
      `uvmx_trim(trn.i_r1, cfg.data_width)
      `uvmx_trim(trn.i_r2, cfg.data_width)
   endfunction

endclass : uvma_mapu_dpi_mon_c


`endif // __UVMA_MAPU_DPI_MON_SV__
