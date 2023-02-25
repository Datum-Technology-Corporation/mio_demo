// Copyright 2023 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_MAPU_BASE_VSEQ_SV__
`define __UVME_MAPU_BASE_VSEQ_SV__


/**
 * Abstract Virtual Sequence from which all Matrix APU Block Self-Test Environment Virtual Sequences extend.
 * @ingroup uvme_mapu_seq
 */
class uvme_mapu_base_vseq_c extends uvmx_seq_c #(
   .T_CFG  (uvme_mapu_cfg_c  ),
   .T_CNTXT(uvme_mapu_cntxt_c),
   .T_SQR  (uvme_mapu_vsqr_c )
);

   `uvm_object_utils(uvme_mapu_base_vseq_c)

   /**
    * Default constructor.
    */
   function new(string name="uvme_mapu_base_vseq");
      super.new(name);
   endfunction

endclass : uvme_mapu_base_vseq_c


`endif // __UVME_MAPU_BASE_VSEQ_SV__