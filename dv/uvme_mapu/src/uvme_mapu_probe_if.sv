// Copyright 2022 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_MAPU_PROBE_IF_SV__
`define __UVME_MAPU_PROBE_IF_SV__


/**
 * Interface encapsulating all extra signals to/from Matrix APU Block design hierarchy.
 * @ingroup uvme_mapu_pkg
 */
interface uvme_mapu_probe_if (
   input  clk    ,
   input  reset_n
);
   import uvma_mapu_pkg::*;

   // TODO Add uvma_mapu_probe_if signals
   //      Ex: wire        locked; ///< Describe me!
   //          wire [7:0]  state ; ///< Describe me!

   clocking cb @(posedge clk);
      // TODO Add signals to uvma_mapu_if::cb()
      //      Ex: input  locked, state;
   endclocking

   modport mp (
      clocking cb     ,
      input    clk    ,
      input    reset_n
   );

endinterface : uvme_mapu_probe_if


`endif // __UVME_MAPU_PROBE_IF_SV__