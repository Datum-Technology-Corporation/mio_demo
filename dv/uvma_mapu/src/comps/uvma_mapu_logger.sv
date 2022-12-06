// Copyright 2022 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_MAPU_LOGGER_SV__
`define __UVMA_MAPU_LOGGER_SV__


/**
 * Component which logs to disk information of the transactions generated and monitored by uvma_mapu_agent_c.
 * @ingroup uvma_mapu_comps
 */
class uvma_mapu_logger_c extends uvmx_agent_logger_c #(
   .T_CFG     (uvma_mapu_cfg_c     ),
   .T_CNTXT   (uvma_mapu_cntxt_c   ),
   .T_SEQ_ITEM(uvma_mapu_seq_item_c)
);

   /// @name Loggers
   /// @{
   uvmx_logger_c #(uvma_mapu_mon_trn_c     )  in_mon_trn_logger  ; ///<
   uvmx_logger_c #(uvma_mapu_mon_trn_c     )  out_mon_trn_logger ; ///<
   uvmx_logger_c #(uvma_mapu_cp_seq_item_c )  cp_seq_item_logger ; ///<
   uvmx_logger_c #(uvma_mapu_dpi_seq_item_c)  dpi_seq_item_logger; ///<
   uvmx_logger_c #(uvma_mapu_dpo_seq_item_c)  dpo_seq_item_logger; ///<
   uvmx_logger_c #(uvma_mapu_cp_mon_trn_c  )  cp_mon_trn_logger  ; ///<
   uvmx_logger_c #(uvma_mapu_dpi_mon_trn_c )  dpi_mon_trn_logger ; ///<
   uvmx_logger_c #(uvma_mapu_dpo_mon_trn_c )  dpo_mon_trn_logger ; ///<
   /// @}


   `uvm_component_utils(uvma_mapu_logger_c)


   /**
    * Default constructor.
    */
   function new(string name="uvma_mapu_logger", uvm_component parent=null);
      super.new(name, parent);
   endfunction

   /**
    * Creates logger components.
    */
   virtual function void create_loggers();
      in_mon_trn_logger   = uvmx_logger_c #(uvma_mapu_mon_trn_c     )::type_id::create("in_mon_trn_logger"  , this);
      out_mon_trn_logger  = uvmx_logger_c #(uvma_mapu_mon_trn_c     )::type_id::create("out_mon_trn_logger" , this);
      cp_seq_item_logger  = uvmx_logger_c #(uvma_mapu_cp_seq_item_c )::type_id::create("cp_seq_item_logger" , this);
      dpi_seq_item_logger = uvmx_logger_c #(uvma_mapu_dpi_seq_item_c)::type_id::create("dpi_seq_item_logger", this);
      dpo_seq_item_logger = uvmx_logger_c #(uvma_mapu_dpo_seq_item_c)::type_id::create("dpo_seq_item_logger", this);
      cp_mon_trn_logger   = uvmx_logger_c #(uvma_mapu_cp_mon_trn_c  )::type_id::create("cp_mon_trn_logger"  , this);
      dpi_mon_trn_logger  = uvmx_logger_c #(uvma_mapu_dpi_mon_trn_c )::type_id::create("dpi_mon_trn_logger" , this);
      dpo_mon_trn_logger  = uvmx_logger_c #(uvma_mapu_dpo_mon_trn_c )::type_id::create("dpo_mon_trn_logger" , this);
   endfunction

   /**
    * Sets filenames for logger components.
    */
   virtual function void configure_loggers();
      in_mon_trn_logger  .set_filename("in_mon_trn"  );
      out_mon_trn_logger .set_filename("out_mon_trn" );
      cp_seq_item_logger .set_filename("cp_seq_item" );
      dpi_seq_item_logger.set_filename("dpi_seq_item");
      dpo_seq_item_logger.set_filename("dpo_seq_item");
      cp_mon_trn_logger  .set_filename("cp_mon_trn"  );
      dpi_mon_trn_logger .set_filename("dpi_mon_trn" );
      dpo_mon_trn_logger .set_filename("dpo_mon_trn" );
   endfunction

endclass : uvma_mapu_logger_c


`endif // __UVMA_MAPU_LOGGER_SV__