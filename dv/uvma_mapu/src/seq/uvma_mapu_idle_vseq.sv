// Copyright 2023 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_MAPU_IDLE_VSEQ_SV__
`define __UVMA_MAPU_IDLE_VSEQ_SV__


/**
 *
 * @ingroup uvma_mapu_seq
 */
class uvma_mapu_idle_vseq_c extends uvma_mapu_base_vseq_c;

   `uvm_object_utils(uvma_mapu_idle_vseq_c)
   `uvmx_idle_vseq()


   /**
    * Default constructor.
    */
   function new(string name="uvma_mapu_idle_vseq");
      super.new(name);
   endfunction

   /**
    *
    */
   task idle();
      uvma_mapu_dpi_seq_item_c  dpi_seq_item;
      uvma_mapu_dpo_seq_item_c  dpo_seq_item;
      fork
         forever begin
            `uvm_create_on(dpi_seq_item, p_sequencer.dpi_sequencer)
            `uvm_send_pri (dpi_seq_item, `UVMX_PRI_IDLE)
         end
         forever begin
            `uvm_create_on(dpo_seq_item, p_sequencer.dpo_sequencer)
            `uvm_send_pri (dpo_seq_item, `UVMX_PRI_IDLE)
         end
      join
   endtask

endclass : uvma_mapu_idle_vseq_c


`endif // __UVMA_MAPU_IDLE_VSEQ_SV__
