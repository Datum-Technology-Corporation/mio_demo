// Copyright 2022 Contributors
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_DADDER_DP_OUT_MON_TRN_SV__
`define __UVMA_DADDER_DP_OUT_MON_TRN_SV__


/**
 * Object rebuilt by monitor (uvma_dadder_dp_out_mon_c).  Analog of uvma_dadder_dp_out_seq_item_c.
 * @ingroup uvma_dadder_dp_out_obj
 */
class uvma_dadder_dp_out_mon_trn_c extends uvml_mon_trn_c;

   /// @name Data
   /// @{
   logic                        of_out  ; ///< Overflow for addition, negative sign for subtraction
   uvma_dadder_dp_out_data_l_t  data_out; ///< Result of operation
   /// @}

   /// @name Metadata
   /// @{
   uvma_dadder_dp_out_cfg_c  cfg; ///< Agent configuration handle
   /// @}


   `uvm_object_utils_begin(uvma_dadder_dp_out_mon_trn_c)
      `uvm_field_int(of_out  , UVM_DEFAULT          )
      `uvm_field_int(data_out, UVM_DEFAULT + UVM_DEC)
   `uvm_object_utils_end


   /**
    * Default constructor.
    */
   extern function new(string name="uvma_dadder_dp_out_mon_trn");

   /**
    * Describes transaction as metadata for uvml_logs_metadata_logger_c.
    */
   extern function uvml_metadata_t get_metadata();

endclass : uvma_dadder_dp_out_mon_trn_c


function uvma_dadder_dp_out_mon_trn_c::new(string name="uvma_dadder_dp_out_mon_trn");

   super.new(name);

endfunction : new


function uvml_metadata_t uvma_dadder_dp_out_mon_trn_c::get_metadata();

   string  of_out_str, data_out_str;

   of_out_str = $sformatf("%h", of_out);
   get_metadata.push_back('{
      index     : 0,
      value     : of_out_str,
      col_name  : "of/neg",
      col_width : of_out_str.len(),
      col_align : UVML_TEXT_ALIGN_RIGHT,
      data_type : UVML_FIELD_INT
   });

   data_out_str = $sformatf("%d", data_out);
   get_metadata.push_back('{
      index     : 1,
      value     : data_out_str,
      col_name  : "data",
      col_width : data_out_str.len(),
      col_align : UVML_TEXT_ALIGN_RIGHT,
      data_type : UVML_FIELD_INT
   });

endfunction : get_metadata


`endif // __UVMA_DADDER_DP_OUT_MON_TRN_SV__