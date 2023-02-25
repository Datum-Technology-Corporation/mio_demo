// Copyright 2023 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_MAPU_DPO_MON_TRN_SV__
`define __UVMA_MAPU_DPO_MON_TRN_SV__


/**
 * Object rebuilt by Data Plane Output monitor (uvma_mapu_cp_mon_c).  Analog of uvma_mapu_dpo_seq_item_c.
 * @ingroup uvma_mapu_obj
 */
class uvma_mapu_dpo_mon_trn_c extends uvmx_mon_trn_c #(
   .T_CFG  (uvma_mapu_cfg_c  ),
   .T_CNTXT(uvma_mapu_cntxt_c)
);

   /// @name Data
   /// @{
   logic               o_vld; ///< Indicates data input lines are valid
   logic               i_rdy; ///< Flow control for upstream block
   uvma_mapu_data_l_t  o_r0 ; ///< Input row element 0
   uvma_mapu_data_l_t  o_r1 ; ///< Input row element 1
   uvma_mapu_data_l_t  o_r2 ; ///< Input row element 2
   /// @}


   `uvm_object_utils_begin(uvma_mapu_dpo_mon_trn_c)
      `uvm_field_int(o_vld, UVM_DEFAULT)
      `uvm_field_int(i_rdy, UVM_DEFAULT)
      `uvm_field_int(o_r0 , UVM_DEFAULT)
      `uvm_field_int(o_r1 , UVM_DEFAULT)
      `uvm_field_int(o_r2 , UVM_DEFAULT)
   `uvm_object_utils_end


   /**
    * Default constructor.
    */
   function new(string name="uvma_mapu_dpo_mon_trn");
      super.new(name);
   endfunction

   /**
    * Describes transaction for logger.
    */
   virtual function uvmx_metadata_t get_metadata();
      string  r0_str, r1_str, r2_str, r3_str;
      if ((o_vld === 1) && (i_rdy === 1)) begin
         r0_str = $sformatf("%h", o_r0);
         get_metadata.push_back('{
            name : "r0",
            width: r0_str.len(),
            value: r0_str,
            group: -1
         });
         r1_str = $sformatf("%h", o_r1);
         get_metadata.push_back('{
            name : "r1",
            width: r1_str.len(),
            value: r1_str,
            group: -1
         });
         r2_str = $sformatf("%h", o_r2);
         get_metadata.push_back('{
            name : "r2",
            width: r2_str.len(),
            value: r2_str,
            group: -1
         });
      end
   endfunction

endclass : uvma_mapu_dpo_mon_trn_c


`endif // __UVMA_MAPU_DPO_MON_TRN_SV__
