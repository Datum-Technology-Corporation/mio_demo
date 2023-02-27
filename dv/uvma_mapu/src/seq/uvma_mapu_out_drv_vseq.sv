// Copyright 2023 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_MAPU_OUT_DRV_VSEQ_SV__
`define __UVMA_MAPU_OUT_DRV_VSEQ_SV__


/**
 * Virtual Sequence generating Data Plane Output Sequence Items and driving uvma_mapu_dpi_drv_c.
 * @ingroup uvma_mapu_seq
 */
class uvma_mapu_out_drv_vseq_c extends uvma_mapu_base_vseq_c;

   `uvm_object_utils(uvma_mapu_out_drv_vseq_c)
   `uvmx_out_drv_vseq()


   /**
    * Default constructor.
    */
   function new(string name="uvma_mapu_out_drv_vseq");
      super.new(name);
   endfunction

   /**
    * Samples row data while `o_vld=1`.
    */
   virtual task drive();
      uvma_mapu_dpo_seq_item_c  dpo_seq_item;
      bit                       within_transfer;
      forever begin
         within_transfer = 0;
         if (dpo_seq_item != null) begin
            if (dpo_seq_item.o_vld === 1) begin
               within_transfer = 1;
            end
         end
         if (within_transfer) begin
            `uvm_create_on(dpo_seq_item, p_sequencer.dpo_sequencer)
            `uvm_rand_send_pri_with(dpo_seq_item, `UVMX_PRI_DEFAULT, {
               i_rdy == 1;
            })
         end
         else begin
            randcase
               cfg.out_drv_ton_pct: begin
                  `uvm_create_on(dpo_seq_item, p_sequencer.dpo_sequencer)
                  `uvm_rand_send_pri_with(dpo_seq_item, `UVMX_PRI_DEFAULT, {
                     i_rdy == 1;
                  })
               end
               (100-cfg.out_drv_ton_pct): begin
                  clk();
               end
            endcase
         end
      end
   endtask

endclass : uvma_mapu_out_drv_vseq_c


`endif // __UVMA_MAPU_OUT_DRV_VSEQ_SV__