// Copyright 2023 Acme Enterprises Inc.
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
      ton inside {[1:100]};
      if (op == UVMA_MAPU_OP_MULT) {
         ma.max_val == 1_000;
         mb.max_val == 1_000;
      }
      else {
         ma.max_val == 1_000_000;
         mb.max_val == 1_000_000;
      }
      ma.min_val == 0;
      mb.min_val == 0;
      ma.num_rows == 3;
      ma.num_cols == 3;
      mb.num_rows == 3;
      mb.num_cols == 3;
   }


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
      ma = uvml_math_mtx_c::type_id::create("ma");
      mb = uvml_math_mtx_c::type_id::create("mb");
   endfunction

   /**
    * Describes transaction for logger.
    */
   virtual function uvmx_metadata_t get_metadata();
      string  op_str, t_on_str;
      uvmx_metadata_t  mad, mbd;
      uvmx_metadata_field_st  field;
      case (op)
         UVMA_MAPU_OP_ADD : op_str = "ADD ";
         UVMA_MAPU_OP_MULT: op_str = "MULT";
      endcase
      get_metadata.push_back('{
         name : "op",
         width: op_str.len(),
         value: op_str,
         group: -1
      });
      t_on_str = $sformatf("%0d", ton);
      get_metadata.push_back('{
         name : "ton",
         width: t_on_str.len(),
         value: t_on_str,
         group: -1
      });
      mad = ma.get_metadata();
      foreach (mad[ii]) begin
         get_metadata.push_back(mad[ii]);
      end
      mbd = mb.get_metadata();
      foreach (mbd[ii]) begin
         field = mbd[ii];
         field.group += 4;
         get_metadata.push_back(field);
      end
   endfunction

endclass : uvma_mapu_seq_item_c


`endif // __UVMA_MAPU_SEQ_ITEM_SV__
