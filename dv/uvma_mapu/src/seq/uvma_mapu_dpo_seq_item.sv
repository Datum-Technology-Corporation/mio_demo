// Copyright 2023 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_MAPU_DPO_SEQ_ITEM_SV__
`define __UVMA_MAPU_DPO_SEQ_ITEM_SV__


/**
 * Sequence Item providing stimulus for the Data Plane Output Driver (uvma_mapu_dpo_drv_c).
 * @ingroup uvma_mapu_seq
 */
class uvma_mapu_dpo_seq_item_c extends uvmx_seq_item_c #(
   .T_CFG  (uvma_mapu_cfg_c  ),
   .T_CNTXT(uvma_mapu_cntxt_c)
);

   /// @name Data
   /// @{
   rand bit  i_rdy; ///< Flow control from downstream block
   /// @}

   /// @name Metadata
   /// @{
   logic               o_vld; ///< Indicates data output lines are valid
   uvma_mapu_data_l_t  o_r0 ; ///< Output row element 0
   uvma_mapu_data_l_t  o_r1 ; ///< Output row element 1
   uvma_mapu_data_l_t  o_r2 ; ///< Output row element 2
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

   /**
    * Describes transaction for logger.
    */
   virtual function uvmx_metadata_t get_metadata();
      string i_rdy_str;
      string o_r0_str;
      string o_r1_str;
      string o_r2_str;
      if (o_vld === 1) begin
         i_rdy_str = $sformatf("%h", i_rdy);
         o_r0_str = $sformatf("%h", o_r0);
         o_r1_str = $sformatf("%h", o_r1);
         o_r2_str = $sformatf("%h", o_r2);
         `uvmx_metadata_field("i_rdy", i_rdy_str)
         `uvmx_metadata_field("o_r0", o_r0_str)
         `uvmx_metadata_field("o_r1", o_r1_str)
         `uvmx_metadata_field("o_r2", o_r2_str)
      end
   endfunction

endclass : uvma_mapu_dpo_seq_item_c


`endif // __UVMA_MAPU_DPO_SEQ_ITEM_SV__
