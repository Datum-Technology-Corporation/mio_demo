// Copyright 2023 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_MAPU_CHKR_SV__
`define __UVME_MAPU_CHKR_SV__


/**
 * Encapsulates assertions targeting uvme_mapu interfaces.
 * This module must be bound to interfaces in a test bench.
 * @ingroup uvme_mapu_misc
 */
module uvme_mapu_chkr (
   uvma_mapu_if        agent_if, ///< Control plane interface
   uvme_mapu_probe_if  probe_if  ///< Misc. signals interface
);

   // TODO Add assertions to uvme_mapu_chkr

endmodule : uvme_mapu_chkr


`endif // __UVME_MAPU_CHKR_SV__