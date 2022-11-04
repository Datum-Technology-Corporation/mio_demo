// Copyright 2022 Contributors
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_DADDER_PRD_SV__
`define __UVME_DADDER_PRD_SV__


/**
 * Component implementing transaction-based model of Decimal adder/subtracter Block.
 * @ingroup uvme_dadder_comps
 */
class uvme_dadder_prd_c extends uvm_component;

   /// @name Objects
   /// @{
   uvme_dadder_cfg_c    cfg  ; ///< Environment configuration handle
   uvme_dadder_cntxt_c  cntxt; ///< Environment context handle
   /// @}

   /// @name TLM
   /// @{
   uvm_tlm_analysis_fifo #(uvma_clk_mon_trn_c  )  clk_fifo    ; ///< Queue of clk monitor transactions
   uvm_analysis_export   #(uvma_clk_mon_trn_c  )  clk_export  ; ///< Port taking in clk monitor transactions
   uvm_tlm_analysis_fifo #(uvma_reset_mon_trn_c)  reset_fifo  ; ///< Queue of reset monitor transactions
   uvm_analysis_export   #(uvma_reset_mon_trn_c)  reset_export; ///< Port taking in reset monitor transactions
   uvm_tlm_analysis_fifo #(uvma_dadder_cp_mon_trn_c    )  cp_fifo     ; ///< Queue of control plane monitor transactions
   uvm_analysis_export   #(uvma_dadder_cp_mon_trn_c    )  cp_export   ; ///< Port taking in control plane monitor transactions
   uvm_tlm_analysis_fifo #(uvma_dadder_dp_in_mon_trn_c )  dp_in_fifo  ; ///< Queue of data plane input monitor transactions
   uvm_analysis_export   #(uvma_dadder_dp_in_mon_trn_c )  dp_in_export; ///< Port taking in data plane input monitor transactions
   uvm_analysis_port     #(uvma_dadder_dp_out_mon_trn_c)  dp_out_ap   ; ///< Port producing predicted data plane output transactions
   /// @}


   `uvm_component_utils_begin(uvme_dadder_prd_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end


   /**
    * Default constructor.
    */
   extern function new(string name="uvme_dadder_prd", uvm_component parent=null);

   /**
    * 1. Ensures #cfg & #cntxt handles are not null
    * 2. Creates TLM objects
    */
   extern virtual function void build_phase(uvm_phase phase);

   /**
    * Connects exports to fifos.
    */
   extern virtual function void connect_phase(uvm_phase phase);

   /**
    * Takes in transactions from fifos and processes them.
    */
   extern virtual task run_phase(uvm_phase phase);

   /**
    * Uses uvm_config_db to retrieve cfg.
    */
   extern function void get_cfg();

   /**
    * Uses uvm_config_db to retrieve cntxt.
    */
   extern function void get_cntxt();

   /**
    * Creates TLM FIFOs and Analysis Ports.
    */
   extern function void create_tlm_objects();

   /**
    * Connects Exports to FIFOs.
    */
   extern function void connect_ports();

   /**
    * Processes input clk monitor transactions.
    */
   extern task process_clk();

   /**
    * Processes input reset monitor transactions.
    */
   extern task process_reset();

   /**
    * Processes input control & data plane input monitor transactions.
    */
   extern task process_cp_dp_in();

   /**
    * Data output prediction handler.
    */
   extern virtual task predict_dp_out(ref uvma_dadder_cp_mon_trn_c cp_trn, ref uvma_dadder_dp_in_mon_trn_c in_trn);

endclass : uvme_dadder_prd_c


function uvme_dadder_prd_c::new(string name="uvme_dadder_prd", uvm_component parent=null);

   super.new(name, parent);

endfunction : new


function void uvme_dadder_prd_c::build_phase(uvm_phase phase);

   super.build_phase(phase);
   get_cfg           ();
   get_cntxt         ();
   create_tlm_objects();

endfunction : build_phase


function void uvme_dadder_prd_c::connect_phase(uvm_phase phase);

   super.connect_phase(phase);
   connect_ports();

endfunction: connect_phase


task uvme_dadder_prd_c::run_phase(uvm_phase phase);

   super.run_phase(phase);
   fork
      process_clk     ();
      process_reset   ();
      process_cp_dp_in();
   join_none

endtask: run_phase


function void uvme_dadder_prd_c::get_cfg();

   void'(uvm_config_db#(uvme_dadder_cfg_c)::get(this, "", "cfg", cfg));
   if (!cfg) begin
      `uvm_fatal("DADDER_PRD", "Configuration handle is null")
   end

endfunction : get_cfg


function void uvme_dadder_prd_c::get_cntxt();

   void'(uvm_config_db#(uvme_dadder_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (!cntxt) begin
      `uvm_fatal("DADDER_PRD", "Context handle is null")
   end

endfunction : get_cntxt


function void uvme_dadder_prd_c::create_tlm_objects();

   clk_fifo     = new("clk_fifo"    , this);
   clk_export   = new("clk_export"  , this);
   reset_fifo   = new("reset_fifo"  , this);
   reset_export = new("reset_export", this);
   cp_fifo      = new("cp_fifo"     , this);
   cp_export    = new("cp_export"   , this);
   dp_in_fifo   = new("dp_in_fifo"  , this);
   dp_in_export = new("dp_in_export", this);
   dp_out_ap    = new("dp_out_ap"   , this);

endfunction : create_tlm_objects


function void uvme_dadder_prd_c::connect_ports();

   clk_export  .connect(clk_fifo  .analysis_export);
   reset_export.connect(reset_fifo.analysis_export);
   cp_export   .connect(cp_fifo   .analysis_export);
   dp_in_export.connect(dp_in_fifo.analysis_export);

endfunction : connect_ports


task uvme_dadder_prd_c::process_clk();

   uvma_clk_mon_trn_c  trn;
   forever begin
      clk_fifo.get(trn);
   end

endtask : process_clk


task uvme_dadder_prd_c::process_reset();

   uvma_reset_mon_trn_c  trn;
   forever begin
      reset_fifo.get(trn);
      case (trn.transition)
         UVML_EDGE_ASSERTED: begin
            cntxt.reset_state = UVML_RESET_STATE_IN_RESET;
            cntxt.reset();
         end
         UVML_EDGE_DEASSERTED: begin
            cntxt.reset_state = UVML_RESET_STATE_POST_RESET;
         end
      endcase
   end

endtask : process_reset


task uvme_dadder_prd_c::process_cp_dp_in();

   uvma_dadder_cp_mon_trn_c     cp_trn ;
   uvma_dadder_dp_in_mon_trn_c  in_trn ;
   uvma_dadder_dp_out_mon_trn_c out_trn;
   forever begin
      wait (cntxt.reset_state == UVML_RESET_STATE_POST_RESET) begin
         fork
            cp_fifo   .get(cp_trn);
            dp_in_fifo.get(in_trn);
         join
         predict_dp_out(cp_trn, in_trn);
      end
   end

endtask : process_cp_dp_in


task uvme_dadder_prd_c::predict_dp_out(ref uvma_dadder_cp_mon_trn_c cp_trn, ref uvma_dadder_dp_in_mon_trn_c in_trn);

   uvma_dadder_dp_out_mon_trn_c  out_trn;

   if (cp_trn.en === 1) begin
      out_trn = uvma_dadder_dp_out_mon_trn_c::type_id::create("out_trn");

      case (cp_trn.op)
         UVMA_DADDER_CP_OP_ADD: begin
            out_trn.data_out = in_trn.op_a + in_trn.op_b + in_trn.carry_in;
            out_trn.of_out   = ((in_trn.op_a + in_trn.op_b + in_trn.carry_in) >= (2**(cfg.data_width)));
            for (int unsigned ii=cfg.data_width; ii<`UVME_DADDER_MAX_DATA_WIDTH; ii++) begin
               out_trn.data_out[ii] = 0;
            end
            dp_out_ap.write(out_trn);
         end

         UVMA_DADDER_CP_OP_SUBTRACT: begin
            if (in_trn.op_a < in_trn.op_b) begin
               out_trn.data_out  = -(in_trn.op_a - in_trn.op_b);
               out_trn.of_out = 1;
            end
            else begin
               out_trn.data_out  = in_trn.op_a - in_trn.op_b;
               out_trn.of_out = 0;
            end
            dp_out_ap.write(out_trn);
         end

         default: begin
            `uvm_error("DADDER_PRD", $sformatf("Invalid op: %h", cp_trn.op))
         end
      endcase
   end

endtask : predict_dp_out


`endif // __UVME_DADDER_PRD_SV__