// Copyright 2023 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_MAPU_DUT_WRAP_SV__
`define __UVMT_MAPU_DUT_WRAP_SV__


/**
 * Module wrapper for Matrix APU Block DUT.  All ports are SV interfaces.
 * @ingroup uvmt_mapu_tb
 */
module uvmt_mapu_dut_wrap (
   uvma_clk_if         clk_if  , ///< Clock generating interface
   uvma_reset_if       reset_if, ///< Reset assertion interface
   uvma_mapu_if        agent_if, ///<
   uvme_mapu_probe_if  probe_if  ///< Misc. signals
);

   mapu_top  dut (
      .clk    (clk_if  .clk    ),
      .reset_n(reset_if.reset_n),
      .i_en   (agent_if.i_en   ),
      .i_op   (agent_if.i_op   ),
      .o_of   (agent_if.o_of   ),
      .i_vld  (agent_if.i_vld  ),
      .i_rdy  (agent_if.i_rdy  ),
      .i_r0   (agent_if.i_r0   ),
      .i_r1   (agent_if.i_r1   ),
      .i_r2   (agent_if.i_r2   ),
      .o_vld  (agent_if.o_vld  ),
      .o_rdy  (agent_if.o_rdy  ),
      .o_r0   (agent_if.o_r0   ),
      .o_r1   (agent_if.o_r1   ),
      .o_r2   (agent_if.o_r2   )
   );

endmodule : uvmt_mapu_dut_wrap


`endif // __UVMT_MAPU_DUT_WRAP_SV__
