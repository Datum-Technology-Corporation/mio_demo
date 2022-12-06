// Copyright 2022 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_MAPU_CP_MON_SV__
`define __UVMA_MAPU_CP_MON_SV__


/**
 *
 * @ingroup uvma_mapu_comps
 */
class uvma_mapu_cp_mon_c extends uvmx_mp_mon_c #(
   .T_MP     (virtual uvma_mapu_if.cp_mon_mp),
   .T_CFG    (uvma_mapu_cfg_c               ),
   .T_CNTXT  (uvma_mapu_cntxt_c             ),
   .T_MON_TRN(uvma_mapu_cp_mon_trn_c        )
);

   `uvm_component_utils(uvma_mapu_cp_mon_c)
   `uvmx_mp_mon(cp_mon_mp, cp_mon_cb)


   /**
    * Default constructor.
    */
   function new(string name="uvma_mapu_cp_mon", uvm_component parent=null);
      super.new(name, parent);
   endfunction

   /**
    *
    */
   virtual task sample_trn(ref uvma_mapu_cp_mon_trn_c trn);
      trn.i_en = mp.cp_mon_cb.i_en;
      trn.i_op = mp.cp_mon_cb.i_op;
      trn.o_of = mp.cp_mon_cb.o_of;
   endtask

endclass : uvma_mapu_cp_mon_c


`endif // __UVMA_MAPU_CP_MON_SV__
