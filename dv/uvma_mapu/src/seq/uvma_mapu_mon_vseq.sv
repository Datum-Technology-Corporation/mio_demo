// Copyright 2022 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_MAPU_MON_VSEQ_SV__
`define __UVMA_MAPU_MON_VSEQ_SV__


/**
 *
 * @ingroup uvma_mapu_seq
 */
class uvma_mapu_mon_vseq_c extends uvma_mapu_base_vseq_c;

   `uvm_object_utils(uvma_mapu_mon_vseq_c)
   `uvmx_mon_vseq()

   /**
    * Default constructor.
    */
   function new(string name="uvma_mapu_mon_vseq");
      super.new(name);
   endfunction

   /**
    *
    */
   task monitor();
      fork
         monitor_in ();
         monitor_out();
      join
   endtask

   /**
    *
    */
   task monitor_in();
      uvma_mapu_mon_trn_c      in_trn   ;
      uvma_mapu_cp_mon_trn_c   cp_trn   ;
      uvma_mapu_dpi_mon_trn_c  dpi_trn  ;
      bit                      first_m  ;
      int unsigned             row_count;
      forever begin
         first_m = 1;
         repeat (2) begin
            row_count = 0;
            in_trn = uvma_mapu_mon_trn_c::type_id::create("in_trn");
            in_trn.dir_in = 1;
            do begin
               p_sequencer.cp_mon_trn_fifo .get(cp_trn );
               p_sequencer.dpi_mon_trn_fifo.get(dpi_trn);
               if ((dpi_trn.i_vld === 1) && (dpi_trn.o_rdy === 1)) begin
                  in_trn.matrix.seti(row_count, 0, cfg.data_width, dpi_trn.i_r0);
                  in_trn.matrix.seti(row_count, 1, cfg.data_width, dpi_trn.i_r1);
                  in_trn.matrix.seti(row_count, 2, cfg.data_width, dpi_trn.i_r2);
                  in_trn.matrix.seti(row_count, 3, cfg.data_width, dpi_trn.i_r3);
                  in_trn.from(dpi_trn);
                  row_count++;
               end
            end while (row_count<4);
            if (!first_m) begin
               while (cp_trn.i_en !== 1) begin
                  p_sequencer.cp_mon_trn_fifo .get(cp_trn );
                  p_sequencer.dpi_mon_trn_fifo.get(dpi_trn);
               end
               case (cp_trn.i_op)
                  0: in_trn.op = UVMA_MAPU_OP_ADD ;
                  1: in_trn.op = UVMA_MAPU_OP_MULT;
                  default: in_trn.set_error(1);
               endcase
               in_trn.from(cp_trn);
            end
            p_sequencer.in_mon_trn_ap.write(in_trn);
            first_m = 0;
         end
      end
   endtask

   /**
    *
    */
   task monitor_out();
      uvma_mapu_mon_trn_c      out_trn;
      uvma_mapu_dpo_mon_trn_c  dpo_trn;
      int unsigned  row_count;
      forever begin
         row_count = 0;
         out_trn = uvma_mapu_mon_trn_c::type_id::create("out_trn");
         do begin
            p_sequencer.dpo_mon_trn_fifo.get(dpo_trn);
            if ((dpo_trn.o_vld === 1) && (dpo_trn.i_rdy === 1)) begin
               out_trn.matrix.seti(row_count, 0, cfg.data_width, dpo_trn.o_r0);
               out_trn.matrix.seti(row_count, 1, cfg.data_width, dpo_trn.o_r1);
               out_trn.matrix.seti(row_count, 2, cfg.data_width, dpo_trn.o_r2);
               out_trn.matrix.seti(row_count, 3, cfg.data_width, dpo_trn.o_r3);
               out_trn.from(dpo_trn);
               row_count++;
            end
         end while (row_count<4);
         `uvmx_heartbeat(p_sequencer)
         p_sequencer.out_mon_trn_ap.write(out_trn);
      end
   endtask

endclass : uvma_mapu_mon_vseq_c


`endif // __UVMA_MAPU_MON_VSEQ_SV__
