// Copyright 2022 Contributors
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_DADDER_CP_IF_SV__
`define __UVMA_DADDER_CP_IF_SV__


/**
 * Encapsulates all signals and clocking of Decimal adder/subtracter Block Control Plane interface.
 * Used by monitor (uvma_dadder_cp_mon_c) and driver (uvma_dadder_cp_drv_c).
 * Assertions must be captured within uvma_dadder_cp_if_chkr.
 * @ingroup uvma_dadder_cp_misc
 */
interface uvma_dadder_cp_if #(
   parameter DATA_WIDTH = `UVMA_DADDER_CP_MAX_DATA_WIDTH
) (
   input  clk    ,
   input  reset_n
);

   wire  en; ///< Block enable
   wire  op; ///< Operation to be performed


   /**
    * Used by uvma_dadder_cp_drv_c.
    */
   clocking drv_cb @(posedge clk);
      output en, op;
   endclocking : drv_cb

   /**
    * Used by uvma_dadder_cp_mon_c.
    */
   clocking mon_cb @(posedge clk);
      input en, op;
   endclocking : mon_cb


   /**
    * Used by uvma_dadder_cp_drv_c.
    */
   modport drv_mp (
      clocking drv_cb ,
      input    clk    ,
      input    reset_n
   );

   /**
    * Used by uvma_dadder_cp_mon_c.
    */
   modport mon_mp (
      clocking mon_cb ,
      input    clk    ,
      input    reset_n
   );

endinterface : uvma_dadder_cp_if


`endif // __UVMA_DADDER_CP_IF_SV__