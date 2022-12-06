// Copyright 2022 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_MAPU_AGENT_SV__
`define __UVMA_MAPU_AGENT_SV__


/**
 * Top-level component that encapsulates, builds and connects all others to implement the Matrix APU UVM Agent.
 * Capable of driving/monitoring Matrix APU virtual interface.
 * @ingroup uvma_mapu_comps
 */
class uvma_mapu_agent_c extends uvmx_agent_c #(
   .T_VIF      (virtual uvma_mapu_if ),
   .T_CFG      (uvma_mapu_cfg_c      ),
   .T_CNTXT    (uvma_mapu_cntxt_c    ),
   .T_SEQ_ITEM (uvma_mapu_seq_item_c ),
   .T_VSQR     (uvma_mapu_vsqr_c     ),
   .T_DRV      (uvma_mapu_drv_c      ),
   .T_MON      (uvma_mapu_mon_c      ),
   .T_LOGGER   (uvma_mapu_logger_c   ),
   .T_COV_MODEL(uvma_mapu_cov_model_c)
);

   /// @name Ports
   /// @{
   uvm_analysis_port #(uvma_mapu_mon_trn_c     )  in_mon_trn_ap  ; ///<
   uvm_analysis_port #(uvma_mapu_mon_trn_c     )  out_mon_trn_ap ; ///<
   uvm_analysis_port #(uvma_mapu_cp_seq_item_c )  cp_seq_item_ap ; ///<
   uvm_analysis_port #(uvma_mapu_dpi_seq_item_c)  dpi_seq_item_ap; ///<
   uvm_analysis_port #(uvma_mapu_dpo_seq_item_c)  dpo_seq_item_ap; ///<
   uvm_analysis_port #(uvma_mapu_cp_mon_trn_c  )  cp_mon_trn_ap  ; ///<
   uvm_analysis_port #(uvma_mapu_dpi_mon_trn_c )  dpi_mon_trn_ap ; ///<
   uvm_analysis_port #(uvma_mapu_dpo_mon_trn_c )  dpo_mon_trn_ap ; ///<
   /// @}


   `uvm_component_utils(uvma_mapu_agent_c)


   /**
    * Default constructor.
    */
   function new(string name="uvma_mapu_agent", uvm_component parent=null);
      super.new(name, parent);
   endfunction

   /**
    * Connects sequencer to monitor and driver's TLM ports.
    */
   virtual function void connect_drivers_sequencers();
      driver.cp_driver .seq_item_port.connect(vsequencer.cp_sequencer .seq_item_export);
      driver.dpi_driver.seq_item_port.connect(vsequencer.dpi_sequencer.seq_item_export);
      driver.dpo_driver.seq_item_port.connect(vsequencer.dpo_sequencer.seq_item_export);
   endfunction

   /**
    * Connects sequencer to monitor and driver's TLM ports.
    */
   virtual function void connect_monitor_vsequencer();
      monitor.cp_monitor .ap.connect(vsequencer.cp_mon_trn_fifo .analysis_export);
      monitor.dpi_monitor.ap.connect(vsequencer.dpi_mon_trn_fifo.analysis_export);
      monitor.dpo_monitor.ap.connect(vsequencer.dpo_mon_trn_fifo.analysis_export);
   endfunction

   /**
    *
    */
   virtual function void connect_ports();
      in_mon_trn_ap   = vsequencer.in_mon_trn_ap ;
      out_mon_trn_ap  = vsequencer.out_mon_trn_ap;
      cp_seq_item_ap  = driver .cp_driver  .ap;
      dpi_seq_item_ap = driver .dpi_driver .ap;
      dpo_seq_item_ap = driver .dpo_driver .ap;
      cp_mon_trn_ap   = monitor.cp_monitor .ap;
      dpi_mon_trn_ap  = monitor.dpi_monitor.ap;
      dpo_mon_trn_ap  = monitor.dpo_monitor.ap;
   endfunction

   /**
    *
    */
   virtual function void connect_logger();
      in_mon_trn_ap  .connect(logger.in_mon_trn_logger  .analysis_export);
      out_mon_trn_ap .connect(logger.out_mon_trn_logger .analysis_export);
      cp_seq_item_ap .connect(logger.cp_seq_item_logger .analysis_export);
      dpi_seq_item_ap.connect(logger.dpi_seq_item_logger.analysis_export);
      dpo_seq_item_ap.connect(logger.dpo_seq_item_logger.analysis_export);
      cp_mon_trn_ap  .connect(logger.cp_mon_trn_logger  .analysis_export);
      dpi_mon_trn_ap .connect(logger.dpi_mon_trn_logger .analysis_export);
      dpo_mon_trn_ap .connect(logger.dpo_mon_trn_logger .analysis_export);
   endfunction

   /**
    *
    */
   virtual task start_sequences();
      if (cfg.is_active) begin
         start_sequence(cfg.drv_in_vseq_type , cntxt.drv_in_vseq );
         start_sequence(cfg.drv_out_vseq_type, cntxt.drv_out_vseq);
      end
   endtask

endclass : uvma_mapu_agent_c


`endif // __UVMA_MAPU_AGENT_SV__
