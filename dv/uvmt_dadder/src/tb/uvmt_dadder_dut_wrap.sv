// Copyright 2022 Contributors
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_DADDER_DUT_WRAP_SV__
`define __UVMT_DADDER_DUT_WRAP_SV__


/**
 * Module wrapper for Decimal adder/subtracter Block DUT.  All ports are SV interfaces.
 * @ingroup uvmt_dadder_tb
 */
module uvmt_dadder_dut_wrap (
   uvme_dadder_probe_if   probe_if , ///< Misc. signals
   uvma_dadder_cp_if      cp_if    , ///< Control plane interface
   uvma_dadder_dp_in_if   dp_in_if , ///< Data plane input interface
   uvma_dadder_dp_out_if  dp_out_if  ///< Data plane output interface
);

   // \/ CODE BELOW IS RESPONSIBILITY OF DESIGNERS \/

   dadder_top #(
      .DATA_WIDTH (`UVMT_DADDER_DATA_WIDTH)
   ) dut (
      .clk      (cp_if.clk         ),
      .reset_n  (cp_if.reset_n     ),
      .en       (cp_if.en          ),
      .op       (cp_if.op          ),
      .carry_in (dp_in_if.carry_in ),
      .op_a     (dp_in_if.op_a     ),
      .op_b     (dp_in_if.op_b     ),
      .vld_out  (dp_out_if.vld_out ),
      .of_out   (dp_out_if.of_out  ),
      .data_out (dp_out_if.data_out)
   );

   // /\ CODE ABOVE IS RESPONSIBILITY OF DESIGNERS /\

endmodule : uvmt_dadder_dut_wrap


`endif // __UVMT_DADDER_DUT_WRAP_SV__