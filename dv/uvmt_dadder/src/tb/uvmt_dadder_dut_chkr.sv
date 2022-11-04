// Copyright 2022 Contributors
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_DADDER_DUT_CHKR_SV__
`define __UVMT_DADDER_DUT_CHKR_SV__


/**
 * Module encapsulating assertions for Decimal adder/subtracter Block DUT wrapper.  All ports are SV interfaces.
 * This module must be bound to the design in a test bench.
 * @ingroup uvmt_dadder_tb
 */
module uvmt_dadder_dut_chkr (
   uvma_dadder_cp_if      cp_if    , ///< Control plane interface
   uvma_dadder_dp_in_if   dp_in_if , ///< Data plane input interface
   uvma_dadder_dp_out_if  dp_out_if, ///< Data plane output interface
   uvmt_dadder_probe_if   probe_if   ///< Misc. signals
);

   // TODO Add assertions to uvmt_dadder_dut_chkr

endmodule : uvmt_dadder_dut_chkr


`endif // __UVMT_DADDER_DUT_CHKR_SV__