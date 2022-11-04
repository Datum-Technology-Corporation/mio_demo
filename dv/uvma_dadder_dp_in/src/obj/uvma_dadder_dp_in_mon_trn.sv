// Copyright 2022 Contributors
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_DADDER_DP_IN_MON_TRN_SV__
`define __UVMA_DADDER_DP_IN_MON_TRN_SV__


/**
 * Object rebuilt by monitor (uvma_dadder_dp_in_mon_c).  Analog of uvma_dadder_dp_in_seq_item_c.
 * @ingroup uvma_dadder_dp_in_obj
 */
class uvma_dadder_dp_in_mon_trn_c extends uvml_mon_trn_c;

   /// @name Data
   /// @{
   uvma_dadder_dp_in_data_l_t  op_a    ; ///< Operand A
   uvma_dadder_dp_in_data_l_t  op_b    ; ///< Operand B
   logic                       carry_in; ///< Carry in for additions
   /// @}

   /// @name Metadata
   /// @{
   uvma_dadder_dp_in_cfg_c  cfg; ///< Agent configuration handle
   /// @}


   `uvm_object_utils_begin(uvma_dadder_dp_in_mon_trn_c)
      `uvm_field_int(carry_in, UVM_DEFAULT          )
      `uvm_field_int(op_a    , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(op_b    , UVM_DEFAULT + UVM_DEC)
   `uvm_object_utils_end


   /**
    * Default constructor.
    */
   extern function new(string name="uvma_dadder_dp_in_mon_trn");

   /**
    * Describes transaction as metadata for uvml_logs_metadata_logger_c.
    */
   extern function uvml_metadata_t get_metadata();

endclass : uvma_dadder_dp_in_mon_trn_c


function uvma_dadder_dp_in_mon_trn_c::new(string name="uvma_dadder_dp_in_mon_trn");

   super.new(name);

endfunction : new


function uvml_metadata_t uvma_dadder_dp_in_mon_trn_c::get_metadata();

   string  carry_in_str, op_a_str, op_b_str;

   carry_in_str = $sformatf("%h", carry_in);
   get_metadata.push_back('{
      index     : 0,
      value     : carry_in_str,
      col_name  : "carry",
      col_width : carry_in_str.len(),
      col_align : UVML_TEXT_ALIGN_RIGHT,
      data_type : UVML_FIELD_INT
   });

   op_a_str = $sformatf("%d", op_a);
   get_metadata.push_back('{
      index     : 1,
      value     : op_a_str,
      col_name  : "op_a",
      col_width : op_a_str.len(),
      col_align : UVML_TEXT_ALIGN_RIGHT,
      data_type : UVML_FIELD_INT
   });

   op_b_str = $sformatf("%d", op_b);
   get_metadata.push_back('{
      index     : 2,
      value     : op_b_str,
      col_name  : "op_b",
      col_width : op_b_str.len(),
      col_align : UVML_TEXT_ALIGN_RIGHT,
      data_type : UVML_FIELD_INT
   });

endfunction : get_metadata


`endif // __UVMA_DADDER_DP_IN_MON_TRN_SV__