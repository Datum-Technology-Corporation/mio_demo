// Copyright 2022 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_MAPU_MON_TRN_SV__
`define __UVMA_MAPU_MON_TRN_SV__


/**
 * Object rebuilt by monitor virtual sequence (uvma_mapu_mon_vseq_c).  Analog of uvma_mapu_seq_item_c.
 * @ingroup uvma_mapu_obj
 */
class uvma_mapu_mon_trn_c extends uvmx_mon_trn_c #(
   .T_CFG  (uvma_mapu_cfg_c  ),
   .T_CNTXT(uvma_mapu_cntxt_c)
);

   /// @name Data
   /// @{
   uvma_mapu_op_enum  op    ; ///<
   uvml_math_mtx_c    matrix; ///<
   /// @}

   /// @name Metadata
   /// @{
   bit  overflow; ///<
   bit  dir_in  ; ///<
   /// @}


   `uvm_object_utils_begin(uvma_mapu_mon_trn_c)
      `uvm_field_enum(uvma_mapu_op_enum, op, UVM_DEFAULT)
      `uvm_field_object(matrix, UVM_DEFAULT)
      `uvm_field_int(overflow, UVM_DEFAULT)
   `uvm_object_utils_end


   /**
    * Default constructor.
    */
   function new(string name="uvma_mapu_mon_trn");
      super.new(name);
   endfunction

   /**
    * Describes transaction for logger.
    */
   virtual function uvmx_metadata_t get_metadata();
      string  overflow_str;
      uvmx_metadata_t  md;
      if (!dir_in) begin
         overflow_str = (overflow === 1) ? "OVF" : "   ";
         get_metadata.push_back('{
            name : "OVF",
            width: overflow_str.len(),
            value: overflow_str,
            group: -1
         });
      end
      md = matrix.get_metadata();
      get_metadata.push_back(md[0]);
      get_metadata.push_back(md[1]);
      get_metadata.push_back(md[2]);
      get_metadata.push_back(md[3]);
   endfunction

endclass : uvma_mapu_mon_trn_c


`endif // __UVMA_MAPU_MON_TRN_SV__
