// Copyright 2022 Contributors
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_DADDER_VSEQ_LIB_SV__
`define __UVME_DADDER_VSEQ_LIB_SV__


`include "uvme_dadder_base_vseq.sv"
`include "uvme_dadder_clk_vseq.sv"
`include "uvme_dadder_reset_vseq.sv"
`include "uvme_dadder_rand_stim_vseq.sv"


/**
 * Object cataloging the Decimal adder/subtracter Block environment's virtual sequences.
 * @ingroup uvme_dadder_seq
 */
class uvme_dadder_vseq_lib_c extends uvml_vseq_lib_c #(
   .REQ(uvm_sequence_item),
   .RSP(uvm_sequence_item)
);

   `uvm_object_utils          (uvme_dadder_vseq_lib_c)
   `uvm_sequence_library_utils(uvme_dadder_vseq_lib_c)

   /**
    * 1. Initializes sequence library
    * 2. Adds sequences to library
    */
   extern function new(string name="uvme_dadder_vseq_lib");

endclass : uvme_dadder_vseq_lib_c


function uvme_dadder_vseq_lib_c::new(string name="uvme_dadder_vseq_lib");

   super.new(name);
   init_sequence_library();
   add_sequence(uvme_dadder_rand_stim_vseq_c::get_type());

endfunction : new


`endif // __UVME_DADDER_VSEQ_LIB_SV__