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
      uvma_mapu_mon_trn_c      in_trn ;
      uvma_mapu_dpi_mon_trn_c  dpi_trn;
      int unsigned  row_count;
      forever begin
         row_count = 0;
         do begin
            fork
               p_sequencer.cp_mon_trn_fifo .get(cp_trn );
               p_sequencer.dpi_mon_trn_fifo.get(dpi_trn);
            join
            if ((dpi_trn.i_vld === 1) && (dpi_trn.o_rdy === 1)) begin
               in_trn = uvma_mapu_mon_trn_c::type_id::create("in_trn");
               in_trn.dir_in = 1;
               in_trn.matrix.seti(row_count, 0, dpi_trn.i_r0);
               in_trn.matrix.seti(row_count, 1, dpi_trn.i_r0);
               in_trn.matrix.seti(row_count, 2, dpi_trn.i_r0);
               in_trn.matrix.seti(row_count, 3, dpi_trn.i_r0);
               in_trn.from(dpi_trn);
               if (row_count == 3) begin
                  in_trn.op = cp_trn.op;
                  in_trn.from(cp_trn);
               end
               row_count++;
            end
         end while (row_count<4);
         p_sequencer.in_mon_trn_ap.write(in_trn);
      end
   endtask

   /**
    *
    */
   task monitor_out();
      uvma_mapu_mon_trn_c      out_trn;
      uvma_mapu_cp_mon_trn_c   cp_trn ;
      uvma_mapu_dpo_mon_trn_c  dpo_trn;
      forever begin
         do begin
            p_sequencer.dpo_mon_trn_fifo.get(dpo_trn);
            if ((dpi_trn.o_vld === 1) && (dpi_trn.i_rdy === 1)) begin
               out_trn = uvma_mapu_mon_trn_c::type_id::create("out_trn");
               out_trn.dir_in = 1;
               out_trn.matrix.seti(row_count, 0, dpi_trn.i_r0);
               out_trn.matrix.seti(row_count, 1, dpi_trn.i_r0);
               out_trn.matrix.seti(row_count, 2, dpi_trn.i_r0);
               out_trn.matrix.seti(row_count, 3, dpi_trn.i_r0);
               out_trn.from(dpo_trn);
               row_count++;
            end
         end while (row_count<4);

         // ...
         out_trn.xyz = cp_trn.xyz;
         out_trn.from(cp_trn);
         p_sequencer.out_mon_trn_ap.write(out_trn);
      end
   endtask

endclass : uvma_mapu_mon_vseq_c


`endif // __UVMA_MAPU_MON_VSEQ_SV__
