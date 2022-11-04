// Copyright 2022 Contributors
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_DADDER_PROBE_IF_SV__
`define __UVME_DADDER_PROBE_IF_SV__


/**
 * Interface encapsulating all extra signals to/from Decimal adder/subtracter Block design hierarchy.
 * @ingroup uvme_dadder_pkg
 */
interface uvme_dadder_probe_if;

   import uvma_dadder_cp_pkg    ::*;
   import uvma_dadder_dp_in_pkg ::*;
   import uvma_dadder_dp_out_pkg::*;

   // TODO Add signals to uvme_dadder_probe_if
   //      Ex: wire  abc; ///< Describe me!

endinterface : uvme_dadder_probe_if


`endif // __UVME_DADDER_PROBE_IF_SV__