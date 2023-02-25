// Copyright 2023 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_MAPU_DPO_SEQ_ITEM_SV__
`define __UVMA_MAPU_DPO_SEQ_ITEM_SV__


/**
 *
 * @ingroup uvma_mapu_seq
 */
class uvma_mapu_dpo_seq_item_c extends uvmx_seq_item_c #(
   .T_CFG  (uvma_mapu_cfg_c  ),
   .T_CNTXT(uvma_mapu_cntxt_c)
);

   /// @name Data
   /// @{
   rand bit  i_rdy; ///< Flow control for upstream block
   /// @}

   /// @name Metadata
   /// @{
   logic               o_vld; ///< Indicates data input lines are valid
   uvma_mapu_data_l_t  o_r0 ; ///< Input row element 0
   uvma_mapu_data_l_t  o_r1 ; ///< Input row element 1
   uvma_mapu_data_l_t  o_r2 ; ///< Input row element 2
   /// @}


   `uvm_object_utils_begin(uvma_mapu_dpo_seq_item_c)
      `uvm_field_int(i_rdy, UVM_DEFAULT)
      `uvm_field_int(o_vld, UVM_DEFAULT)
      `uvm_field_int(o_r0 , UVM_DEFAULT)
      `uvm_field_int(o_r1 , UVM_DEFAULT)
      `uvm_field_int(o_r2 , UVM_DEFAULT)
   `uvm_object_utils_end


   /**
    * Default constructor.
    */
   function new(string name="uvma_mapu_dpo_seq_item");
      super.new(name);
   endfunction

endclass : uvma_mapu_dpo_seq_item_c


`endif // __UVMA_MAPU_DPO_SEQ_ITEM_SV__
