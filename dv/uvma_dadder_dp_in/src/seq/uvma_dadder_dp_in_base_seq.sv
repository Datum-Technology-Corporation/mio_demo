// Copyright 2022 Contributors
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_DADDER_DP_IN_BASE_SEQ_SV__
`define __UVMA_DADDER_DP_IN_BASE_SEQ_SV__


/**
 * Abstract object from which all other Decimal adder/subtracter Block Data Plane Input agent sequences must extend.
 * Subclasses must be run on Decimal adder/subtracter Block Data Plane Input sequencer (uvma_dadder_dp_in_sqr_c) instance.
 * @ingroup uvma_dadder_dp_in_seq
 */
class uvma_dadder_dp_in_base_seq_c extends uvml_seq_c #(
   .REQ(uvma_dadder_dp_in_seq_item_c),
   .RSP(uvma_dadder_dp_in_seq_item_c)
);

   /// @name Objects
   /// @{
   uvma_dadder_dp_in_cfg_c    cfg  ; ///< Agent configuration handle
   uvma_dadder_dp_in_cntxt_c  cntxt; ///< Agent context handle
   /// @}


   `uvm_object_utils(uvma_dadder_dp_in_base_seq_c)
   `uvm_declare_p_sequencer(uvma_dadder_dp_in_sqr_c)


   /**
    * Default constructor.
    */
   extern function new(string name="uvma_dadder_dp_in_base_seq");

   /**
    * Assigns cfg and cntxt handles from p_sequencer.
    */
   extern virtual task pre_start();

endclass : uvma_dadder_dp_in_base_seq_c


function uvma_dadder_dp_in_base_seq_c::new(string name="uvma_dadder_dp_in_base_seq");

   super.new(name);

endfunction : new


task uvma_dadder_dp_in_base_seq_c::pre_start();

   cfg   = p_sequencer.cfg;
   cntxt = p_sequencer.cntxt;

endtask : pre_start


`endif // __UVMA_DADDER_DP_IN_BASE_SEQ_SV__