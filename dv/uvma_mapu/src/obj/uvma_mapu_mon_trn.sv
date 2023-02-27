// Copyright 2023 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_MAPU_MON_TRN_SV__
`define __UVMA_MAPU_MON_TRN_SV__


/**
 * Monitor Transaction rebuilt by the Monitor Virtual Sequence (uvma_mapu_mon_vseq_c).
 * Analog of uvma_mapu_seq_item_c.
 * @ingroup uvma_mapu_obj
 */
class uvma_mapu_mon_trn_c extends uvmx_mon_trn_c #(
   .T_CFG  (uvma_mapu_cfg_c  ),
   .T_CNTXT(uvma_mapu_cntxt_c)
);

   /// @name Data
   /// @{
   uvma_mapu_op_enum  op    ; ///< Operation to be performed (only valid for dir_in=1)
   uvml_math_mtx_c    matrix; ///< Matrix observed.
   /// @}

   /// @name Metadata
   /// @{
   bit  dir_in  ; ///< Specifies which side of the Data Plane this transaction was monitored (1=Output,0=Input).
   bit  overflow; ///< '1' when matrix has values outside the configured bit width.
   /// @}


   `uvm_object_utils_begin(uvma_mapu_mon_trn_c)
      `uvm_field_object(matrix, UVM_DEFAULT + UVM_NOCOMPARE)
      `uvm_field_int(overflow, UVM_DEFAULT)
      `uvm_field_enum(uvma_mapu_op_enum, op, UVM_DEFAULT + UVM_NOCOMPARE)
   `uvm_object_utils_end


   /**
    * Default constructor.
    */
   function new(string name="uvma_mapu_mon_trn");
      super.new(name);
   endfunction

   /**
    * Create sub-objects.
    */
   virtual function void create_objects();
      matrix = uvml_math_mtx_c::type_id::create("matrix");
      matrix.build(3, 3);
   endfunction

   /**
    * Does not attempt to compare matrices if overflow condition.
    */
   virtual function bit do_compare(uvm_object rhs, uvm_comparer comparer);
      uvma_mapu_mon_trn_c  rhs_t;
      if (!$cast(rhs_t, rhs)) begin
         `uvm_fatal("MAPU_MON_TRN", $sformatf("Could not cast 'rhs' (%s) to 'rhs_t' (%s)", $typename(rhs), $typename(rhs_t)))
      end
      do_compare = super.do_compare(rhs, comparer);
      if (overflow === 0) begin
         do_compare &= comparer.compare_object("matrix", matrix, rhs_t.matrix);
      end
   endfunction

   /**
    * Describes transaction for logger.
    */
   virtual function uvmx_metadata_t get_metadata();
      string           overflow_str, op_str;
      uvmx_metadata_t  mm;
      if (!dir_in) begin
         overflow_str = (overflow === 1) ? "OF" : "  ";
         `uvmx_metadata_field("of", overflow_str)
      end
      else begin
         op_str = (op === 0) ? "ADD " : "MULT";
         `uvmx_metadata_field("op", op_str)
      end
      mm = matrix.get_metadata();
      foreach (mm[ii]) begin
         `uvmx_metadata_add(mm[ii])
      end
   endfunction

endclass : uvma_mapu_mon_trn_c


`endif // __UVMA_MAPU_MON_TRN_SV__