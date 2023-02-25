// Copyright 2023 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_MAPU_SEQ_ITEM_SV__
`define __UVMA_MAPU_SEQ_ITEM_SV__


/**
 * Sequence Item created by Matrix APU Agent Sequences.  Analog of uvma_mapu_mon_trn_c
 * @ingroup uvma_mapu_seq
 */
class uvma_mapu_seq_item_c extends uvmx_seq_item_c #(
   .T_CFG  (uvma_mapu_cfg_c  ),
   .T_CNTXT(uvma_mapu_cntxt_c)
);

   /// @name Data
   /// @{
   // TODO Add uvma_mapu_seq_item_c data fields
   //      Ex: rand bit [7:0]  abc; ///< Describe me!
   /// @}

   /// @name Metadata
   /// @{
   // TODO Add uvma_mapu_seq_item_c metadata fields
   //      Ex: logic [7:0]  def; ///< Describe me!
   /// @}


   `uvm_object_utils_begin(uvma_mapu_seq_item_c)
      // TODO Add uvma_mapu_seq_item_c UVM field utils
      //      Ex: `uvm_field_int(abc, UVM_DEFAULT)
   `uvm_object_utils_end


   // TODO Add uvma_mapu_seq_item_c constraints
   //      Ex: /**
   //           * Describe me!
   //           */
   //          constraint limits_cons {
   //             abc inside {0,2,4,8,16,32};
   //          }


   /**
    * Default constructor.
    */
   function new(string name="uvma_mapu_seq_item");
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

endclass : uvma_mapu_seq_item_c


`endif // __UVMA_MAPU_SEQ_ITEM_SV__