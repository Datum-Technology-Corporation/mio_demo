// Copyright 2022 Contributors
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_DADDER_CHKR_SV__
`define __UVME_DADDER_CHKR_SV__


/**
 * Encapsulates assertions targeting uvme_dadder interfaces.
 * This module must be bound to interfaces in a test bench.
 * @ingroup uvme_dadder_misc
 */
module uvme_dadder_chkr (
   uvma_dadder_cp_if      cp_if    , ///< Control plane interface
   uvma_dadder_dp_in_if   dp_in_if , ///< Data plane input interface
   uvma_dadder_dp_out_if  dp_out_if  ///< Data plane output interface
);

   // TODO Add assertions to uvme_$[name}_chkr

endmodule : uvme_dadder_chkr


`endif // __UVME_DADDER_CHKR_SV__