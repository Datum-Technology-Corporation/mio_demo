// Copyright 2023 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_MAPU_IN_DRV_VSEQ_SV__
`define __UVMA_MAPU_IN_DRV_VSEQ_SV__


/**
 * Virtual Sequence taking in uvma_mapu_seq_item_c instances and driving uvma_mapu_drv_c with Control Plane and
 * Data Plane Input Sequence Items.
 * @ingroup uvma_mapu_seq
 */
class uvma_mapu_in_drv_vseq_c extends uvma_mapu_base_vseq_c;

   `uvm_object_utils(uvma_mapu_in_drv_vseq_c)
   `uvmx_in_drv_vseq()

   /**
    * Default constructor.
    */
   function new(string name="uvma_mapu_in_drv_vseq");
      super.new(name);
   endfunction

   /**
    * Trims data outside the configured widths.
    */
   virtual function void process(ref uvma_mapu_seq_item_c seq_item);
      // TODO Implement uvma_mapu_in_drv_vseq_c::process() (or remove if not needed)
      //      Ex: `uvmx_trim(seq_item.abc, cfg.data_width)
   endfunction

   /**
    * TODO Describe uvma_mapu_in_drv_vseq_c::drive_item()
    *      Note: For asynchronous protocols (async==1), the response must be sent via `virtual task respond(seq_item)`.
    *            Use `uvma_mapu_cntxt_c` to store shared data.
    */
   virtual task drive_item(bit async=0, ref uvma_mapu_seq_item_c seq_item);
      uvma_mapu_cp_seq_item_c   cp_seq_item ;
      uvma_mapu_dpi_seq_item_c  dpi_seq_item;
      // TODO Implement uvma_mapu_in_drv_vseq_c::drive()
      //      Ex: fork
      //             begin
      //                `uvm_create_on(cp_seq_item, p_sequencer.cp_sequencer)
      //                cp_seq_item.from(seq_item);
      //                `uvm_rand_send_pri_with(cp_seq_item, `UVMX_PRI_DEFAULT, {
      //                   def == seq_item.abc;
      //                })
      //             end
      //             begin
      //                `uvm_create_on(dpi_seq_item, p_sequencer.dpi_sequencer)
      //                dpi_seq_item.from(seq_item);
      //                `uvm_rand_send_pri_with(dpi_seq_item, `UVMX_PRI_DEFAULT, {
      //                   xyz == seq_item.qrs;
      //                })
      //             end
      //          join
   endtask

endclass : uvma_mapu_in_drv_vseq_c


`endif // __UVMA_MAPU_IN_DRV_VSEQ_SV__