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
   uvma_mapu_if  agent_if, ///< Block signals
   uvma_clk_if    clk_if  , ///< Clock generating interface
   uvma_reset_if  reset_if  ///< Reset assertion interface
);

   /**
    * Matrix APU Device Under Test from IP 'acme/mapu'.
    */
   mapu_top #(
      .DATA_WIDTH(`UVMT_MAPU_DATA_WIDTH)
   )  dut (
      // Control Plane
      .i_en  (agent_if.i_en ),
      .i_op  (agent_if.i_op ),
      .o_of  (agent_if.o_of ),
      // Data Plane Input
      .i_vld (agent_if.i_vld),
      .i_r0  (agent_if.i_r0 ),
      .i_r1  (agent_if.i_r1 ),
      .i_r2  (agent_if.i_r2 ),
      .o_rdy (agent_if.o_rdy),
      // Data Plane Output
      .i_rdy (agent_if.i_rdy),
      .o_vld (agent_if.o_vld),
      .o_r0  (agent_if.o_r0 ),
      .o_r1  (agent_if.o_r1 ),
      .o_r2  (agent_if.o_r2 ),
      // Clock & Reset
      .clk     (clk_if  .clk    ),
      .reset_n (reset_if.reset_n)
   );

endmodule : uvmt_mapu_dut_wrap


`endif // __UVMT_MAPU_DUT_WRAP_SV__