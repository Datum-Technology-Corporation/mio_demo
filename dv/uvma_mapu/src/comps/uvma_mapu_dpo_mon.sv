// Copyright 2023 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_MAPU_DPO_MON_SV__
`define __UVMA_MAPU_DPO_MON_SV__


/**
 * Monitor sampling Data Plane Output Monitor Transactions (uvma_mapu_dpo_mon_trn_c) from uvma_mapu_if.
 * @ingroup uvma_mapu_comps
 */
class uvma_mapu_dpo_mon_c extends uvmx_mp_mon_c #(
   .T_MP     (virtual uvma_mapu_if.dpo_mon_mp),
   .T_CFG    (uvma_mapu_cfg_c                ),
   .T_CNTXT  (uvma_mapu_cntxt_c              ),
   .T_MON_TRN(uvma_mapu_dpo_mon_trn_c        )
);

   `uvm_component_utils(uvma_mapu_dpo_mon_c)
   `uvmx_mp_mon(dpo_mon_mp, dpo_mon_cb)


   /**
    * Default constructor.
    */
   function new(string name="uvma_mapu_dpo_mon", uvm_component parent=null);
      super.new(name, parent);
   endfunction

   /**
    * Samples #trn from the Data Plane Output Monitor clocking block (dpi_mon_cb) on each clock cycle.
    */
   virtual task sample_trn(ref uvma_mapu_dpo_mon_trn_c trn);
      trn.i_rdy = mp.dpo_mon_cb.i_rdy;
      trn.o_vld = mp.dpo_mon_cb.o_vld;
      trn.o_r0  = mp.dpo_mon_cb.o_r0 ;
      trn.o_r1  = mp.dpo_mon_cb.o_r1 ;
      trn.o_r2  = mp.dpo_mon_cb.o_r2 ;
   endtask

endclass : uvma_mapu_dpo_mon_c


`endif // __UVMA_MAPU_DPO_MON_SV__