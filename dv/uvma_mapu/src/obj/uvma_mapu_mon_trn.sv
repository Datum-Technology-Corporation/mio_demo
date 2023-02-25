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
   // TODO Add uvma_mapu_mon_trn_c data fields
   //      Ex: logic [7:0]  abc; ///< Describe me!
   /// @}

   /// @name Metadata
   /// @{
   bit dir_in; ///< Specifies which side of the Data Plane this transaction was monitored (1=Output,0=Input).
   /// @}


   `uvm_object_utils_begin(uvma_mapu_mon_trn_c)
      // TODO Add UVM field utils for data fields
      //      Ex: `uvm_field_int(abc, UVM_DEFAULT)
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
      // TODO Create sub-objects or remove
      //      Ex: matrix = uvml_math_mtx_c::type_id::create("matrix");
   endfunction

   /**
    * Describes transaction for logger.
    */
   virtual function uvmx_metadata_t get_metadata();
      // TODO Create metadata for transaction logger
      //      Ex: string  abc_str;
      //          abc_str = $sformatf("%h", abc);
      //          `uvmx_metadata_field("abc", abc_str)
   endfunction

endclass : uvma_mapu_mon_trn_c


`endif // __UVMA_MAPU_MON_TRN_SV__