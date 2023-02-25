// Copyright 2023 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_MAPU_PRD_SV__
`define __UVME_MAPU_PRD_SV__


/**
 * Component implementing TLM prediction of Matrix APU Block behavior.
 * @ingroup uvme_mapu_comps
 */
class uvme_mapu_prd_c extends uvmx_prd_c #(
   .T_CFG  (uvme_mapu_cfg_c  ),
   .T_CNTXT(uvme_mapu_cntxt_c)
);

   /// @name FIFOs
   /// @{
   uvm_tlm_analysis_fifo #(uvma_mapu_mon_trn_c)  in_fifo; ///< Queue of control plane monitor transactions
   /// @}

   /// @name Ports
   /// @{
   uvm_analysis_port #(uvma_mapu_mon_trn_c)  out_ap ; ///< Port producing predicted data plane output transactions
   /// @}


   `uvm_component_utils(uvme_mapu_prd_c)


   /**
    * Default constructor.
    */
   function new(string name="uvme_mapu_prd", uvm_component parent=null);
      super.new(name, parent);
   endfunction

   /**
    * Creates TLM FIFOs.
    */
   virtual function void create_fifos();
      in_fifo = new("in_fifo", this);
   endfunction

   /**
    * Creates TLM Ports.
    */
   virtual function void create_ports();
      out_ap = new("out_ap", this);
   endfunction

   /**
    * TODO Describe uvme_mapu_prd_c::predict()
    */
   virtual task predict();
      uvma_mapu_mon_trn_c  in_trn, out_trn;
      in_fifo.get(in_trn);
      // TODO Implement uvme_mapu_prd_c::predict()
      //      Ex: out_trn = uvma_mapu_mon_trn_c::type_id::create("out_trn");
      //          out_trn.dir_in = 0;
      //          out_trn.abc = in_trn.abc*2;
      //          out_ap.write(out_trn);
   endtask

endclass : uvme_mapu_prd_c


`endif // __UVME_MAPU_PRD_SV__