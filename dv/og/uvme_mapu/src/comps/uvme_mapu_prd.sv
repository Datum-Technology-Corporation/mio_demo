// Copyright 2023 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_MAPU_PRD_SV__
`define __UVME_MAPU_PRD_SV__


/**
 * Component implementing transaction-based model of Matrix APU Block.
 * @ingroup uvme_mapu_comps
 */
class uvme_mapu_prd_c extends uvmx_prd_c #(
   .T_CFG  (uvme_mapu_cfg_c  ),
   .T_CNTXT(uvme_mapu_cntxt_c)
);
   /// @name TLM
   /// @{
   uvm_tlm_analysis_fifo #(uvma_mapu_mon_trn_c)  in_fifo; ///< Queue of control plane monitor transactions
   uvm_analysis_port     #(uvma_mapu_mon_trn_c)  out_ap ; ///< Port producing predicted data plane output transactions
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
    * Creates Analysis Ports.
    */
   virtual function void create_ports();
      out_ap = new("out_ap", this);
   endfunction

   /**
    *
    */
   virtual task predict();
      uvma_mapu_mon_trn_c  in_a_trn, in_b_trn, out_trn;
      bit drop = 0;
      in_fifo.get(in_a_trn);
      in_fifo.get(in_b_trn);
      out_trn = uvma_mapu_mon_trn_c::type_id::create("out_trn");
      out_trn.from(in_a_trn);
      out_trn.from(in_b_trn);
      out_trn.op = in_b_trn.op;
      case (in_b_trn.op)
         UVMA_MAPU_OP_ADD : out_trn.matrix = in_a_trn.matrix.add     (in_b_trn.matrix);
         UVMA_MAPU_OP_MULT: out_trn.matrix = in_a_trn.matrix.multiply(in_b_trn.matrix);
         default: begin
            `uvm_error("MAPU_PRD", $sformatf("Invalid op ''. Dropping:\n%s", in_b_trn.op.name(), in_b_trn.sprint()))
            drop = 1;
         end
      endcase
      if (!drop) begin
         foreach (out_trn.matrix.mi[ii]) begin
            foreach (out_trn.matrix.mi[ii][jj]) begin
               if (out_trn.matrix.mi[ii][jj] < 0) begin
                  out_trn.overflow = 1;
                  break;
               end
            end
         end
         out_ap.write(out_trn);
      end
   endtask

endclass : uvme_mapu_prd_c


`endif // __UVME_MAPU_PRD_SV__
