// Copyright 2022 Contributors
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_DADDER_DP_OUT_SEQ_ITEM_SV__
`define __UVMA_DADDER_DP_OUT_SEQ_ITEM_SV__


/**
 * Object created by Decimal adder/subtracter Block Data Plane Output agent sequences running on uvma_dadder_dp_out_sqr_c and used by uvma_dadder_dp_out_drv_c.
 * @ingroup uvma_dadder_dp_out_seq
 */
class uvma_dadder_dp_out_seq_item_c extends uvml_seq_item_c;

   /// @name Metadata
   /// @{
   uvma_dadder_dp_out_cfg_c  cfg; ///< Agent configuration handle
   /// @}


   `uvm_object_utils_begin(uvma_dadder_dp_out_seq_item_c)
   `uvm_object_utils_end


   /**
    * Default constructor.
    */
   extern function new(string name="uvma_dadder_dp_out_seq_item");

endclass : uvma_dadder_dp_out_seq_item_c


function uvma_dadder_dp_out_seq_item_c::new(string name="uvma_dadder_dp_out_seq_item");

   super.new(name);

endfunction : new


`endif // __UVMA_DADDER_DP_OUT_SEQ_ITEM_SV__