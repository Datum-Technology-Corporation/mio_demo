// Copyright 2023 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_MAPU_DPI_SEQ_ITEM_SV__
`define __UVMA_MAPU_DPI_SEQ_ITEM_SV__


/**
 * Sequence Item providing stimulus for the Data Plane Input Driver (uvma_mapu_dpi_drv_c).
 * @ingroup uvma_mapu_seq
 */
class uvma_mapu_dpi_seq_item_c extends uvmx_seq_item_c #(
   .T_CFG  (uvma_mapu_cfg_c  ),
   .T_CNTXT(uvma_mapu_cntxt_c)
);

   /// @name Data
   /// @{
   rand bit                 i_vld; ///< Indicates data input lines are valid
   rand uvma_mapu_data_b_t  i_r0 ; ///< Input row element 0
   rand uvma_mapu_data_b_t  i_r1 ; ///< Input row element 1
   rand uvma_mapu_data_b_t  i_r2 ; ///< Input row element 2
   /// @}

   /// @name Metadata
   /// @{
   logic  o_rdy; ///< Flow control for upstream block
   /// @}


   `uvm_object_utils_begin(uvma_mapu_dpi_seq_item_c)
      `uvm_field_int(i_vld, UVM_DEFAULT)
      `uvm_field_int(i_r0 , UVM_DEFAULT)
      `uvm_field_int(i_r1 , UVM_DEFAULT)
      `uvm_field_int(i_r2 , UVM_DEFAULT)
      `uvm_field_int(o_rdy, UVM_DEFAULT)
   `uvm_object_utils_end


   /**
    * Default constructor.
    */
   function new(string name="uvma_mapu_dpi_seq_item");
      super.new(name);
   endfunction

   /**
    * Describes transaction for logger.
    */
   virtual function uvmx_metadata_t get_metadata();
      string i_vld_str;
      string i_r0_str;
      string i_r1_str;
      string i_r2_str;
      string o_rdy_str;
      i_vld_str = $sformatf("%h", i_vld);
      i_r0_str = $sformatf("%h", i_r0);
      i_r1_str = $sformatf("%h", i_r1);
      i_r2_str = $sformatf("%h", i_r2);
      o_rdy_str = $sformatf("%h", o_rdy);
      `uvmx_metadata_field("i_vld", i_vld_str)
      `uvmx_metadata_field("i_r0", i_r0_str)
      `uvmx_metadata_field("i_r1", i_r1_str)
      `uvmx_metadata_field("i_r2", i_r2_str)
      `uvmx_metadata_field("o_rdy", o_rdy_str)
   endfunction

endclass : uvma_mapu_dpi_seq_item_c


`endif // __UVMA_MAPU_DPI_SEQ_ITEM_SV__
