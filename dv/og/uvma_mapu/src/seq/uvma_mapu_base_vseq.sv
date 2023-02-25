// Copyright 2023 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_MAPU_BASE_VSEQ_SV__
`define __UVMA_MAPU_BASE_VSEQ_SV__


/**
 *
 * @ingroup uvma_mapu_seq
 */
class uvma_mapu_base_vseq_c extends uvmx_agent_seq_c #(
   .T_CFG     (uvma_mapu_cfg_c     ),
   .T_CNTXT   (uvma_mapu_cntxt_c   ),
   .T_SQR     (uvma_mapu_vsqr_c    ),
   .T_SEQ_ITEM(uvma_mapu_seq_item_c)
);

   `uvm_object_utils(uvma_mapu_base_vseq_c)

   /**
    * Default constructor.
    */
   function new(string name="uvma_mapu_base_vseq");
      super.new(name);
   endfunction

endclass : uvma_mapu_base_vseq_c


`endif // __UVMA_MAPU_BASE_VSEQ_SV__