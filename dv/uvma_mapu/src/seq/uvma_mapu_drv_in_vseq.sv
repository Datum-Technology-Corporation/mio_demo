// Copyright 2022 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_MAPU_DRV_IN_VSEQ_SV__
`define __UVMA_MAPU_DRV_IN_VSEQ_SV__


/**
 *
 * @ingroup uvma_mapu_seq
 */
class uvma_mapu_drv_in_vseq_c extends uvma_mapu_base_vseq_c;

   `uvm_object_utils(uvma_mapu_drv_in_vseq_c)
   `uvmx_drv_in_vseq()

   /**
    * Default constructor.
    */
   function new(string name="uvma_mapu_drv_in_vseq");
      super.new(name);
   endfunction

   /**
    *
    */
   virtual function void process(ref uvma_mapu_seq_item_c seq_item);
      `uvmx_trim(seq_item.abc, cfg.data_width)
   endfunction

   /**
    * If `async` is set to `1`, the response must be sent via `respond(item)`.
    */
   virtual task drive_item(bit async=0, ref uvma_mapu_seq_item_c seq_item);
      uvma_mapu_cp_seq_item_c   cp_seq_item ;
      uvma_mapu_dpi_seq_item_c  dpi_seq_item;
      int unsigned row_count = 0;
      do begin
         randcase
            seq_item.ton: begin
               `uvm_create_on(dpi_seq_item, p_sequencer.dpi_sequencer)
               dpi_seq_item.from(seq_item);
               `uvm_rand_send_pri_with(dpi_seq_item, `UVMX_PRI_DEFAULT, {
                  i_vld == 1;
                  i_r0  == seq_item.ma.mi[row_count][0];
                  i_r1  == seq_item.ma.mi[row_count][1];
                  i_r2  == seq_item.ma.mi[row_count][2];
                  i_r3  == seq_item.ma.mi[row_count][3];
               })
               row_count++;
            end
            (100-seq_item.ton): begin
               clk();
            end
         endcase
      end while (row_count<4);
      row_count = 0;
      do begin
         randcase
            seq_item.ton: begin
               `uvm_create_on(dpi_seq_item, p_sequencer.dpi_sequencer)
               dpi_seq_item.from(seq_item);
               fork
                  begin
                     `uvm_rand_send_pri_with(dpi_seq_item, `UVMX_PRI_DEFAULT, {
                        i_vld == 1;
                        i_r0  == seq_item.mb.mi[row_count][0];
                        i_r1  == seq_item.mb.mi[row_count][1];
                        i_r2  == seq_item.mb.mi[row_count][2];
                        i_r3  == seq_item.mb.mi[row_count][3];
                     })
                  end
                  begin
                     if (row_count == 3) begin
                        `uvm_create_on(cp_seq_item, p_sequencer.cp_sequencer)
                        cp_seq_item.from(seq_item);
                        `uvm_rand_send_pri_with(cp_seq_item, `UVMX_PRI_DEFAULT, {
                           i_en == 1;
                           i_op == seq_item.op;
                        })
                     end
                     else begin
                        clk();
                     end
                  end
               join
               row_count++;
            end
            (100-seq_item.ton): begin
               clk();
            end
         endcase
      end while (row_count<4);
   endtask

endclass : uvma_mapu_drv_in_vseq_c


`endif // __UVMA_MAPU_DRV_IN_VSEQ_SV__
