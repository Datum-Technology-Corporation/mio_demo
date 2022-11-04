// Copyright 2022 Contributors
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_DADDER_CP_SEQ_LIB_SV__
`define __UVMA_DADDER_CP_SEQ_LIB_SV__


`include "uvma_dadder_cp_base_seq.sv"


/**
 * Object cataloging the Decimal adder/subtracter Block Control Plane UVM Agent sequences.
 * @ingroup uvma_dadder_cp_seq
 */
class uvma_dadder_cp_seq_lib_c extends uvml_seq_lib_c #(
   .REQ(uvm_sequence_item),
   .RSP(uvm_sequence_item)
);

   `uvm_object_utils          (uvma_dadder_cp_seq_lib_c)
   `uvm_sequence_library_utils(uvma_dadder_cp_seq_lib_c)


   /**
    * 1. Initializes sequence library
    * 2. Adds sequences to library
    */
   extern function new(string name="uvma_dadder_cp_seq_lib");

endclass : uvma_dadder_cp_seq_lib_c


function uvma_dadder_cp_seq_lib_c::new(string name="uvma_dadder_cp_seq_lib");

   super.new(name);
   init_sequence_library();

endfunction : new


`endif // __UVMA_DADDER_CP_SEQ_LIB_SV__