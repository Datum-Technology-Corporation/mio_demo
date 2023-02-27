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
   rand uvma_mapu_op_enum  op; ///< Matrix operation to be performed
   rand uvml_math_mtx_c    ma; ///< Matrix A
   rand uvml_math_mtx_c    mb; ///< Matrix B
   /// @}

   /// @name Metadata
   /// @{
   rand int unsigned ton_pct; ///< Percentage of active clock cycles.
   /// @}


   `uvm_object_utils_begin(uvma_mapu_seq_item_c)
      `uvm_field_enum(uvma_mapu_op_enum, op, UVM_DEFAULT)
      `uvm_field_object(ma, UVM_DEFAULT)
      `uvm_field_object(mb, UVM_DEFAULT)
      `uvm_field_int(ton_pct, UVM_DEFAULT + UVM_DEC)
   `uvm_object_utils_end


   /**
    * * Ensures ton is a percentage
    * * Sets matrices to be 3x3 unsigned values
    */
   constraint rules_cons {
      ton_pct inside {[1:100]};
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
      string  op_str, ton_pct_str;
      uvmx_metadata_t  mam, mbm;
      case (op)
         UVMA_MAPU_OP_ADD : op_str = "ADD ";
         UVMA_MAPU_OP_MULT: op_str = "MULT";
      endcase
      `uvmx_metadata_field("op", op_str)
      ton_pct_str = $sformatf("%0d", ton_pct);
      `uvmx_metadata_field("ton", ton_pct_str)
      mam = ma.get_metadata();
      foreach (mam[ii]) begin
         if (cfg.data_width == 32) begin
            mam[ii].width = 12;
         end
         else if (cfg.data_width == 32) begin
            mam[ii].width = 18;
         end
         `uvmx_metadata_add(mam[ii])
      end
      mbm = mb.get_metadata();
      foreach (mbm[ii]) begin
         if (cfg.data_width == 32) begin
            mbm[ii].width = 12;
         end
         else if (cfg.data_width == 32) begin
            mbm[ii].width = 18;
         end
         `uvmx_metadata_add(mbm[ii])
      end
   endfunction

endclass : uvma_mapu_seq_item_c


`endif // __UVMA_MAPU_SEQ_ITEM_SV__