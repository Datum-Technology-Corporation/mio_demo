// Copyright 2022 Contributors
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_DADDER_TB_SV__
`define __UVMT_DADDER_TB_SV__


/**
 * Module encapsulating the Decimal adder/subtracter Block DUT wrapper, agents and clock generating interfaces.
 * @ingroup uvmt_dadder_tb
 */
module uvmt_dadder_tb;

   import uvm_pkg::*;
   import uvmt_dadder_pkg::*;

   uvma_clk_if    clk_if(); ///< Clock generating interface
   uvma_reset_if  reset_if(.clk(clk_if.clk)); ///< Reset assertion interface
   uvme_dadder_probe_if   probe_if(); ///< Misc. signals interface
   uvma_dadder_cp_if      cp_if(.clk(clk_if.clk), .reset_n(reset_if.reset_n)); ///< Control plane interface
   uvma_dadder_dp_in_if   dp_in_if(.clk(clk_if.clk), .reset_n(reset_if.reset_n)); ///< Data plane input interface
   uvma_dadder_dp_out_if  dp_out_if(.clk(clk_if.clk), .reset_n(reset_if.reset_n)); ///< Data plane output interface
   uvmt_dadder_dut_wrap   dut_wrap(.*); ///< DUT instance with interface ports


   /**
    * Test bench entry point.
    */
   initial begin
      // Specify time format for simulation
      $timeformat(
         .units_number       (   -9),
         .precision_number   (    3),
         .suffix_string      (" ns"),
         .minimum_field_width(   18)
      );

      // Add interfaces to uvm_config_db
      uvm_config_db#(virtual uvma_clk_if  )::set(null, "*.env.clk_agent"  , "vif", clk_if  );
      uvm_config_db#(virtual uvma_reset_if)::set(null, "*.env.reset_agent", "vif", reset_if);
      uvm_config_db#(virtual uvme_dadder_probe_if )::set(null, "*.env"             , "vif", probe_if );
      uvm_config_db#(virtual uvma_dadder_cp_if    )::set(null, "*.env.cp_agent"    , "vif", cp_if    );
      uvm_config_db#(virtual uvma_dadder_dp_in_if )::set(null, "*.env.dp_in_agent" , "vif", dp_in_if );
      uvm_config_db#(virtual uvma_dadder_dp_out_if)::set(null, "*.env.dp_out_agent", "vif", dp_out_if);

      // Run test
      uvm_top.enable_print_topology = 0;
      uvm_top.finish_on_completion  = 1;
      uvm_top.run_test();
   end

endmodule : uvmt_dadder_tb


`endif // __UVMT_DADDER_TB_SV__