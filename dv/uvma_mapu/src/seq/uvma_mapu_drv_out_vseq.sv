// Copyright 2022 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_MAPU_DRV_OUT_VSEQ_SV__
`define __UVMA_MAPU_DRV_OUT_VSEQ_SV__


/**
 *
 * @ingroup uvma_mapu_seq
 */
class uvma_mapu_drv_out_vseq_c extends uvma_mapu_base_vseq_c;

   `uvm_object_utils(uvma_mapu_drv_out_vseq_c)
   `uvmx_drv_out_vseq()


   /**
    * Default constructor.
    */
   function new(string name="uvma_mapu_drv_out_vseq");
      super.new(name);
   endfunction

   /**
    *
    */
   virtual task drive();
      uvma_mapu_dpo_seq_item_c  dpo_seq_item;
      forever begin
         randcase
            cfg.ton: begin
               `uvm_create_on(dpo_seq_item, p_sequencer.dpo_sequencer)
               `uvm_rand_send_pri_with(dpo_seq_item, `UVMX_PRI_DEFAULT, {
                  i_rdy == 1;
               })
            end
            (100-cfg.ton): begin
               clk();
            end
         endcase
      end
   endtask

endclass : uvma_mapu_drv_out_vseq_c


`endif // __UVMA_MAPU_DRV_OUT_VSEQ_SV__
