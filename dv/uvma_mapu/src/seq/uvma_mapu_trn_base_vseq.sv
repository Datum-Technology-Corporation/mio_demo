// Copyright 2022 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_MAPU_TRN_BASE_VSEQ_SV__
`define __UVMA_MAPU_TRN_BASE_VSEQ_SV__


/**
 *
 * @ingroup uvma_mapu_seq
 */
class uvma_mapu_trn_base_vseq_c extends uvma_mapu_base_vseq_c;

   `uvm_object_utils(uvma_mapu_trn_base_vseq_c)
   `uvmx_trn_vseq()

   /**
    * Default constructor.
    */
   function new(string name="uvma_mapu_trn_base_vseq");
      super.new(name);
   endfunction

   /**
    * If `async` is set to `1`, the response must be sent via `respond(item)`.
    */
   virtual task drive_item(bit async=0, ref uvm_sequence_item seq_item);
      // To be implemented by sub-classes
   endtask

endclass : uvma_mapu_trn_base_vseq_c


`endif // __UVMA_MAPU_TRN_BASE_VSEQ_SV__