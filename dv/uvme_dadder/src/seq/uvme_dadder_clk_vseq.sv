// Copyright 2022 Contributors
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_DADDER_CLK_VSEQ_SV__
`define __UVME_DADDER_CLK_VSEQ_SV__


/**
 * Virtual sequence responsible for starting clock(s) for the Decimal adder/subtracter Block environment.
 * @ingroup uvme_dadder_seq
 */
class uvme_dadder_clk_vseq_c extends uvme_dadder_base_vseq_c;

   `uvm_object_utils(uvme_dadder_clk_vseq_c)

   /**
    * Default constructor.
    */
   extern function new(string name="uvme_dadder_clk_vseq_c");

   /**
    * Start clock generation with frequency set in #cfg.
    */
   extern virtual task body();

endclass : uvme_dadder_clk_vseq_c


function uvme_dadder_clk_vseq_c::new(string name="uvme_dadder_clk_vseq_c");

   super.new(name);

endfunction : new


task uvme_dadder_clk_vseq_c::body();

   uvma_clk_seq_item_c  clk_req;
   `uvm_do_on_with(clk_req, p_sequencer.clk_sequencer, {
      action         == UVMA_CLK_SEQ_ITEM_ACTION_START;
      new_frequency  == cfg.clk_frequency;
      new_duty_cycle == 50;
   })

endtask : body


`endif // __UVME_DADDER_CLK_VSEQ_SV__