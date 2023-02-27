// Copyright 2023 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_MAPU_DPI_MON_TRN_SV__
`define __UVMA_MAPU_DPI_MON_TRN_SV__


/**
 * Data Plane Input Monitor Transaction sampled by uvma_mapu_dpi_mon_c.
 * Analog of uvma_mapu_dpi_seq_item_c.
 * @ingroup uvma_mapu_obj
 */
class uvma_mapu_dpi_mon_trn_c extends uvmx_mon_trn_c #(
   .T_CFG  (uvma_mapu_cfg_c  ),
   .T_CNTXT(uvma_mapu_cntxt_c)
);

   /// @name Data
   /// @{
   logic               i_vld; ///< Indicates data input lines are valid
   uvma_mapu_data_l_t  i_r0 ; ///< Input row element 0
   uvma_mapu_data_l_t  i_r1 ; ///< Input row element 1
   uvma_mapu_data_l_t  i_r2 ; ///< Input row element 2
   logic               o_rdy; ///< Flow control for upstream block
   /// @}


   `uvm_object_utils_begin(uvma_mapu_dpi_mon_trn_c)
      `uvm_field_int(i_vld, UVM_DEFAULT)
      `uvm_field_int(i_r0 , UVM_DEFAULT)
      `uvm_field_int(i_r1 , UVM_DEFAULT)
      `uvm_field_int(i_r2 , UVM_DEFAULT)
      `uvm_field_int(o_rdy, UVM_DEFAULT)
   `uvm_object_utils_end


   /**
    * Default constructor.
    */
   function new(string name="uvma_mapu_dpi_mon_trn");
      super.new(name);
   endfunction

   /**
    * Describes transaction for logger.
    */
   virtual function uvmx_metadata_t get_metadata();
      string i_r0_str;
      string i_r1_str;
      string i_r2_str;
      if ((i_vld === 1) && (o_rdy === 1)) begin
         i_r0_str = $sformatf("%h", i_r0);
         i_r1_str = $sformatf("%h", i_r1);
         i_r2_str = $sformatf("%h", i_r2);
         `uvmx_metadata_field("i_r0", i_r0_str)
         `uvmx_metadata_field("i_r1", i_r1_str)
         `uvmx_metadata_field("i_r2", i_r2_str)
      end
   endfunction

endclass : uvma_mapu_dpi_mon_trn_c


`endif // __UVMA_MAPU_DPI_MON_TRN_SV__