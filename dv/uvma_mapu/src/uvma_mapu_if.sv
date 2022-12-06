// Copyright 2022 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_MAPU_IF_SV__
`define __UVMA_MAPU_IF_SV__


/**
 * Encapsulates all signals and clocking of Matrix APU interface.
 * Assertions must be captured within uvma_mapu_if_chkr.
 * @ingroup uvma_mapu_misc
 */
interface uvma_mapu_if #(
   parameter DATA_WIDTH = `UVMA_MAPU_MAX_DATA_WIDTH
) (
   input  clk    ,
   input  reset_n
);


   /// @name Signals
   /// @{
   wire                     i_en ; ///< Block enable
   wire                     i_op ; ///< Matrix operation to be performed
   wire                     o_of ; ///< Overflow indicator
   wire                     i_vld; ///< Indicates data input lines are valid
   wire                     i_rdy; ///< Flow control from downstream block
   wire [(DATA_WIDTH-1):0]  i_r0 ; ///< Input row element 0
   wire [(DATA_WIDTH-1):0]  i_r1 ; ///< Input row element 1
   wire [(DATA_WIDTH-1):0]  i_r2 ; ///< Input row element 2
   wire [(DATA_WIDTH-1):0]  i_r3 ; ///< Input row element 3
   wire                     o_vld; ///< Indicates data output lines are valid
   wire                     o_rdy; ///< Flow control for upstream block
   wire [(DATA_WIDTH-1):0]  o_r0 ; ///< Output row element 0
   wire [(DATA_WIDTH-1):0]  o_r1 ; ///< Output row element 1
   wire [(DATA_WIDTH-1):0]  o_r2 ; ///< Output row element 2
   wire [(DATA_WIDTH-1):0]  o_r3 ; ///< Output row element 3
   /// @}


   /**
    * Used by Matrix APU DUT.
    */
   clocking dut_cb @(posedge clk);
      input  i_en, i_op, i_vld, i_rdy, i_r0, i_r1, i_r2, i_r3;
      output o_of, o_vld, o_rdy, o_r0, o_r1, o_r2, o_r3;
   endclocking

   /**
    * Used by uvma_mapu_cp_drv_c.
    */
   clocking cp_drv_cb @(posedge clk);
      output  i_en, i_op;
      input   o_of;
   endclocking

   /**
    * Used by uvma_mapu_cp_mon_c.
    */
   clocking cp_mon_cb @(posedge clk);
      input i_en, i_op, o_of;
   endclocking

   /**
    * Used by uvma_mapu_dpi_drv_c.
    */
   clocking dpi_drv_cb @(posedge clk);
      output  i_vld, i_r0, i_r1, i_r2, i_r3;
      input   o_rdy;
   endclocking

   /**
    * Used by uvma_mapu_dpi_mon_c.
    */
   clocking dpi_mon_cb @(posedge clk);
      input  o_rdy, i_vld, i_r0, i_r1, i_r2, i_r3;
   endclocking

   /**
    * Used by uvma_mapu_dpo_drv_c.
    */
   clocking dpo_drv_cb @(posedge clk);
      output  i_rdy;
      input   o_vld, o_r0, o_r1, o_r2, o_r3;
   endclocking

   /**
    * Used by uvma_mapu_dpo_mon_c.
    */
   clocking dpo_mon_cb @(posedge clk);
      input  i_rdy, o_vld, o_r0, o_r1, o_r2, o_r3;
   endclocking


   /**
    * Used by DUT
    */
   modport dut_mp (
      clocking dut_cb ,
      input    clk    ,
      input    reset_n
   );

   /**
    * Used by uvma_mapu_cp_drv_c.
    */
   modport cp_drv_mp (
      clocking cp_drv_cb,
      input    clk      ,
      input    reset_n
   );

   /**
    * Used by uvma_mapu_dpi_drv_c.
    */
   modport dpi_drv_mp (
      clocking dpi_drv_cb,
      input    clk       ,
      input    reset_n
   );

   /**
    * Used by uvma_mapu_dpo_drv_c.
    */
   modport dpo_drv_mp (
      clocking dpo_drv_cb,
      input    clk       ,
      input    reset_n
   );

   /**
    * Used by uvma_mapu_cp_mon_c.
    */
   modport cp_mon_mp (
      clocking cp_mon_cb,
      input    clk      ,
      input    reset_n
   );

   /**
    * Used by uvma_mapu_dpi_mon_c.
    */
   modport dpi_mon_mp (
      clocking dpi_mon_cb,
      input    clk       ,
      input    reset_n
   );

   /**
    * Used by uvma_mapu_dpo_mon_c.
    */
   modport dpo_mon_mp (
      clocking dpo_mon_cb,
      input    clk       ,
      input    reset_n
   );

endinterface : uvma_mapu_if


`endif // __UVMA_MAPU_IF_SV__
