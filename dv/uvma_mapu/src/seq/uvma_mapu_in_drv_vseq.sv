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
    * * Drives 2 matrices, row-by-row using drive_row, while ensuring `i_en=1` and `i_op` is correct on the last row of the second matrix.
    * * Respects `ton` using `randcase`
    */
   virtual task drive_item(bit async=0, ref uvma_mapu_seq_item_c seq_item);
      uvma_mapu_cp_seq_item_c   cp_seq_item ;
      uvma_mapu_dpi_seq_item_c  dpi_seq_item;
      int unsigned row_count = 0;
      do begin
         randcase
            seq_item.ton_pct: begin
               drive_row(seq_item, seq_item.ma, row_count);
               row_count++;
            end
            (100-seq_item.ton_pct): begin
               clk();
            end
         endcase
      end while (row_count<3);
      do begin
         randcase
            seq_item.ton_pct: begin
               fork
                  begin
                     drive_row(seq_item, seq_item.mb, row_count-3);
                  end
                  begin
                     if (row_count == 5) begin
                        `uvm_create_on(cp_seq_item, p_sequencer.cp_sequencer)
                        cp_seq_item.from(seq_item);
                        cp_seq_item.i_en = 1;
                        cp_seq_item.i_op = seq_item.op;
                        `uvm_send_pri(cp_seq_item, `UVMX_PRI_DEFAULT)
                     end
                  end
               join
               row_count++;
            end
            (100-seq_item.ton_pct): begin
               clk();
            end
         endcase
      end while (row_count<6);
   endtask

   /**
    * Drives a single matrix row into the DUT.
    */
   virtual task drive_row(uvma_mapu_seq_item_c seq_item, uvml_math_mtx_c matrix, int unsigned row);
      uvma_mapu_dpi_seq_item_c  dpi_seq_item;
      while (cntxt.vif.o_rdy !== 1) begin
         clk();
      end
      `uvm_create_on(dpi_seq_item, p_sequencer.dpi_sequencer)
      dpi_seq_item.from(seq_item);
      dpi_seq_item.i_vld = 1;
      dpi_seq_item.i_r0  = matrix.geti(row, 0, cfg.data_width);
      dpi_seq_item.i_r1  = matrix.geti(row, 1, cfg.data_width);
      dpi_seq_item.i_r2  = matrix.geti(row, 2, cfg.data_width);
      `uvm_send_pri(dpi_seq_item, `UVMX_PRI_DEFAULT)
   endtask

endclass : uvma_mapu_in_drv_vseq_c


`endif // __UVMA_MAPU_IN_DRV_VSEQ_SV__