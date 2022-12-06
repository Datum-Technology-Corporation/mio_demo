// Copyright 2022 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_MAPU_TB_SV__
`define __UVMT_MAPU_TB_SV__


/**
 * Module encapsulating the Matrix APU Block DUT wrapper, agents and clock generating interfaces.
 * @ingroup uvmt_mapu_tb
 */
module uvmt_mapu_tb;

   import uvm_pkg      ::*;
   import uvmx_pkg     ::*;
   import uvmt_mapu_pkg::*;

   logic  clk, reset_n;
   assign clk     = clk_if  .clk    ;
   assign reset_n = reset_if.reset_n;

   uvma_clk_if         clk_if  (.*); ///< Clock generating interface
   uvma_reset_if       reset_if(.*); ///< Reset assertion interface
   uvma_mapu_if        agent_if(.*); ///< Matrix APU Block interface
   uvme_mapu_probe_if  probe_if(.*); ///< Misc. signals interface
   uvmt_mapu_dut_wrap  dut_wrap(.*); ///< DUT instance with interface ports

   bind uvmt_mapu_dut_wrap : dut_wrap  uvme_mapu_chkr chkr(.*); ///< Checker instantiation and binding

   /**
    * Test Bench entry point.
    */
   initial begin
      uvm_config_db#(virtual uvma_clk_if       )::set(null, "*.clk_agent"  , "vif", clk_if  );
      uvm_config_db#(virtual uvma_reset_if     )::set(null, "*.reset_agent", "vif", reset_if);
      uvm_config_db#(virtual uvma_mapu_if      )::set(null, "*.env.agent"  , "vif", agent_if);
      uvm_config_db#(virtual uvme_mapu_probe_if)::set(null, "*.env"        , "vif", probe_if);
      uvmx_top.run_test();
   end

endmodule : uvmt_mapu_tb


`endif // __UVMT_MAPU_TB_SV__
