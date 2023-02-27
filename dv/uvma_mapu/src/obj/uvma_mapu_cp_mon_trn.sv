// Copyright 2023 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_MAPU_CP_MON_TRN_SV__
`define __UVMA_MAPU_CP_MON_TRN_SV__


/**
 * Control Plane Monitor Transaction sampled by uvma_mapu_cp_mon_c.
 * Analog of uvma_mapu_cp_seq_item_c.
 * @ingroup uvma_mapu_obj
 */
class uvma_mapu_cp_mon_trn_c extends uvmx_mon_trn_c #(
   .T_CFG  (uvma_mapu_cfg_c  ),
   .T_CNTXT(uvma_mapu_cntxt_c)
);

   /// @name Data
   /// @{
   logic  i_en; ///< Block enable
   logic  i_op; ///< Matrix operation to be performed
   logic  o_of; ///< Overflow indicator
   /// @}


   `uvm_object_utils_begin(uvma_mapu_cp_mon_trn_c)
      `uvm_field_int(i_en, UVM_DEFAULT)
      `uvm_field_int(i_op, UVM_DEFAULT)
      `uvm_field_int(o_of, UVM_DEFAULT)
   `uvm_object_utils_end


   /**
    * Default constructor.
    */
   function new(string name="uvma_mapu_cp_mon_trn");
      super.new(name);
   endfunction

   /**
    * Describes transaction for logger.
    */
   virtual function uvmx_metadata_t get_metadata();
      string i_op_str;
      string o_of_str;
      if (i_en === 1) begin
         i_op_str = (i_op === 1) ? "MULT" : "ADD";
         o_of_str = (o_of === 1) ? "OF"   :    "";
         `uvmx_metadata_field("i_op", i_op_str)
         `uvmx_metadata_field("o_of", o_of_str)
      end
   endfunction

endclass : uvma_mapu_cp_mon_trn_c


`endif // __UVMA_MAPU_CP_MON_TRN_SV__