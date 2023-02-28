// Copyright 2023 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_MAPU_CP_SEQ_ITEM_SV__
`define __UVMA_MAPU_CP_SEQ_ITEM_SV__


/**
 * Sequence Item providing stimulus for the Control Plane Driver (uvma_mapu_cp_drv_c).
 * @ingroup uvma_mapu_seq
 */
class uvma_mapu_cp_seq_item_c extends uvmx_seq_item_c #(
   .T_CFG  (uvma_mapu_cfg_c  ),
   .T_CNTXT(uvma_mapu_cntxt_c)
);

   /// @name Data
   /// @{
   rand bit        i_en; ///< Block enable
   rand bit [1:0]  i_op; ///< Matrix operation to be performed
   /// @}

   /// @name Metadata
   /// @{
   logic  o_of; ///< Overflow indicator
   /// @}


   `uvm_object_utils_begin(uvma_mapu_cp_seq_item_c)
      `uvm_field_int(i_en, UVM_DEFAULT)
      `uvm_field_int(i_op, UVM_DEFAULT)
      `uvm_field_int(o_of, UVM_DEFAULT)
   `uvm_object_utils_end


   /**
    * Default constructor.
    */
   function new(string name="uvma_mapu_cp_seq_item");
      super.new(name);
   endfunction

   /**
    * Describes transaction for logger.
    */
   virtual function uvmx_metadata_t get_metadata();
      string i_en_str;
      string i_op_str;
      i_en_str = (i_en === 1) ? "Y " : "N ";
      case (i_op)
            2'b00  : i_op_str = "ADD ";
            2'b01  : i_op_str = "MULT";
            default: i_op_str = "????";
         endcase
      `uvmx_metadata_field("i_en", i_en_str)
      `uvmx_metadata_field("i_op", i_op_str)
   endfunction

endclass : uvma_mapu_cp_seq_item_c


`endif // __UVMA_MAPU_CP_SEQ_ITEM_SV__
