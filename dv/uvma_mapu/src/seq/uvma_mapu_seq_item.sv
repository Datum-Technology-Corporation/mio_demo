// Copyright 2022 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_MAPU_SEQ_ITEM_SV__
`define __UVMA_MAPU_SEQ_ITEM_SV__


/**
 * Object created by Matrix APU agent sequences running on uvma_mapu_sqr_c and used by uvma_mapu_drv_c.
 * @ingroup uvma_mapu_seq
 */
class uvma_mapu_seq_item_c extends uvmx_seq_item_c #(
   .T_CFG  (uvma_mapu_cfg_c  ),
   .T_CNTXT(uvma_mapu_cntxt_c)
);

   /// @name Data
   /// @{
   rand uvma_mapu_op_enum  op; ///< Matrix operation to be performed
   rand uvml_math_mtx_c    ma; ///< Matrix A
   rand uvml_math_mtx_c    mb; ///< Matrix B
   /// @}

   /// @name Metadata
   /// @{
   rand int unsigned ton; ///<
   /// @}


   `uvm_object_utils_begin(uvma_mapu_seq_item_c)
      `uvm_field_enum(uvma_mapu_op_enum, op, UVM_DEFAULT)
      `uvm_field_object(ma, UVM_DEFAULT)
      `uvm_field_object(mb, UVM_DEFAULT)
      `uvm_field_int(ton, UVM_DEFAULT)
   `uvm_object_utils_end


   /**
    * Describe constraint here
    */
   constraint limits_cons {
      ma.num_rows == 4;
      mb.num_rows == 4;
      ton inside {[1:100]};
   }


   /**
    * Default constructor.
    */
   function new(string name="uvma_mapu_seq_item");
      super.new(name);
   endfunction

   /**
    * Describes transaction for logger.
    */
   virtual function uvmx_metadata_t get_metadata();
      string  op_str;
      uvmx_metadata_t  mad, mbd;
      case (op)
         UVMA_MAPU_UP_ADD : op_str = "ADD ";
         UVMA_MAPU_UP_MULT: op_str = "MULT";
      endcase
      get_metadata.push_back('{
         name : "op",
         width: op_str.len(),
         value: op_str
      });
      mad = ma.get_metadata();
      get_metadata.push_back(mad[0]);
      get_metadata.push_back(mad[1]);
      get_metadata.push_back(mad[2]);
      get_metadata.push_back(mad[3]);
      mbd = mb.get_metadata();
      get_metadata.push_back(mbd[0]);
      get_metadata.push_back(mbd[1]);
      get_metadata.push_back(mbd[2]);
      get_metadata.push_back(mbd[3]);
   endfunction

endclass : uvma_mapu_seq_item_c


`endif // __UVMA_MAPU_SEQ_ITEM_SV__
