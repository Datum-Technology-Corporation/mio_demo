// Copyright 2022 Contributors
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_DADDER_CP_SEQ_ITEM_SV__
`define __UVMA_DADDER_CP_SEQ_ITEM_SV__


/**
 * Object created by Decimal adder/subtracter Block Control Plane agent sequences running on uvma_dadder_cp_sqr_c and used by uvma_dadder_cp_drv_c.
 * @ingroup uvma_dadder_cp_seq
 */
class uvma_dadder_cp_seq_item_c extends uvml_seq_item_c;

   /// @name Data
   /// @{
   rand bit                     en; ///< Block enable
   rand uvma_dadder_cp_op_enum  op; ///< Operation to be performed
   /// @}

   /// @name Metadata
   /// @{
   uvma_dadder_cp_cfg_c  cfg; ///< Agent configuration handle
   /// @}


   `uvm_object_utils_begin(uvma_dadder_cp_seq_item_c)
      `uvm_field_int(en, UVM_DEFAULT)
      `uvm_field_enum(uvma_dadder_cp_op_enum, op, UVM_DEFAULT)
   `uvm_object_utils_end


   /**
    * Default constructor.
    */
   extern function new(string name="uvma_dadder_cp_seq_item");

   /**
    * Describes transaction as metadata for uvml_logs_metadata_logger_c.
    */
   extern function uvml_metadata_t get_metadata();

endclass : uvma_dadder_cp_seq_item_c


function uvma_dadder_cp_seq_item_c::new(string name="uvma_dadder_cp_seq_item");

   super.new(name);

endfunction : new


function uvml_metadata_t uvma_dadder_cp_seq_item_c::get_metadata();

   string  en_str, op_str;

   en_str = $sformatf("%h", en);
   get_metadata.push_back('{
      index     : 1,
      value     : en_str,
      col_name  : "en",
      col_width : en_str.len(),
      col_align : UVML_TEXT_ALIGN_RIGHT,
      data_type : UVML_FIELD_INT
   });

   case (op)
      UVMA_DADDER_CP_OP_ADD     : op_str = "ADD";
      UVMA_DADDER_CP_OP_SUBTRACT: op_str = "SUB";
      default                   : op_str = "???";
   endcase
   get_metadata.push_back('{
      index     : 0,
      value     : op_str,
      col_name  : "op",
      col_width : op_str.len(),
      col_align : UVML_TEXT_ALIGN_RIGHT,
      data_type : UVML_FIELD_INT
   });

endfunction : get_metadata


`endif // __UVMA_DADDER_CP_SEQ_ITEM_SV__