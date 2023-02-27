// Copyright 2023 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_MAPU_TB_SV__
`define __UVMT_MAPU_TB_SV__


/**
 * Module encapsulating the Matrix APU Block DUT wrapper, agents and clock generating interfaces.
 * @ingroup uvmt_mapu_tb
 */
module uvmt_mapu_tb;

   import uvm_pkg ::*;
   import uvmx_pkg::*;
   import uvmt_mapu_pkg::*;

   /// @name Clock & Reset
   /// @{
   logic  clk    ; ///< Clock signal
   logic  reset_n; ///< Reset signal
   uvma_clk_if    clk_if                (.*); ///< Clock generating interface
   uvma_reset_if  reset_if(.clk(clk_if.clk)); ///< Reset assertion interface
   assign clk     = clk_if  .clk    ;
   assign reset_n = reset_if.reset_n;
   /// @}

   uvma_mapu_if        agent_if(.*); ///< Block Agent interface
   uvmt_mapu_dut_wrap  dut_wrap(.*); ///< DUT wrapper instance
   bind uvmt_mapu_dut_wrap : dut_wrap  uvma_mapu_if_chkr chkr(.*); ///< Checker instantiation and binding

   /**
    * Test Bench entry point.
    */
   initial begin
      uvm_config_db#(virtual uvma_clk_if  )::set(null, "*.clk_agent"  , "vif", clk_if  );
      uvm_config_db#(virtual uvma_reset_if)::set(null, "*.reset_agent", "vif", reset_if);
      uvm_config_db#(virtual uvma_mapu_if)::set(null, "*.env.agent", "vif", agent_if);
      uvmx_top.run_test();
   end

endmodule : uvmt_mapu_tb


`endif // __UVMT_MAPU_TB_SV__