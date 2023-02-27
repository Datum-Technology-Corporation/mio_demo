// Copyright 2023 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_MAPU_VSEQ_LIB_SV__
`define __UVME_MAPU_VSEQ_LIB_SV__


`include "uvme_mapu_base_vseq.sv"
`include "uvme_mapu_fix_ill_stim_vseq.sv"
`include "uvme_mapu_fix_stim_vseq.sv"
`include "uvme_mapu_rand_ill_stim_vseq.sv"
`include "uvme_mapu_rand_stim_vseq.sv"


/**
 * Virtual Sequence Library containing Sequences for Matrix APU Block Environment.
 * @ingroup uvme_mapu_seq
 */
class uvme_mapu_vseq_lib_c extends uvmx_seq_lib_c #(
   .T_SEQ_ITEM(uvmx_seq_item_c)
);

   `uvm_object_utils          (uvme_mapu_vseq_lib_c)
   `uvm_sequence_library_utils(uvme_mapu_vseq_lib_c)

   /**
    * Default constructor.
    */
   function new(string name="uvme_mapu_vseq_lib");
      super.new(name);
   endfunction

   /**
    * Adds sequences to library.
    */
   virtual function void add_lib_sequences();
      add_sequence(uvme_mapu_fix_ill_stim_vseq_c ::get_type());
      add_sequence(uvme_mapu_fix_stim_vseq_c     ::get_type());
      add_sequence(uvme_mapu_rand_ill_stim_vseq_c::get_type());
      add_sequence(uvme_mapu_rand_stim_vseq_c    ::get_type());
   endfunction

endclass : uvme_mapu_vseq_lib_c


`endif // __UVME_MAPU_VSEQ_LIB_SV__