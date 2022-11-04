// Copyright 2022 Contributors
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_DADDER_DP_IN_SQR_SV__
`define __UVMA_DADDER_DP_IN_SQR_SV__


/**
 * Component running Decimal adder/subtracter Block Data Plane Input sequences of uvma_dadder_dp_in_seq_item_c requests (and responses).
 * Provides sequence items for uvma_dadder_dp_in_drv_c.
 * @ingroup uvma_dadder_dp_in_comps
 */
class uvma_dadder_dp_in_sqr_c extends uvml_sqr_c #(
   .REQ(uvma_dadder_dp_in_seq_item_c),
   .RSP(uvma_dadder_dp_in_seq_item_c)
);

   /// @name Objects
   /// @{
   uvma_dadder_dp_in_cfg_c    cfg  ; ///< Agent configuration handle
   uvma_dadder_dp_in_cntxt_c  cntxt; ///< Agent context handle
   /// @}


   `uvm_component_utils_begin(uvma_dadder_dp_in_sqr_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end


   /**
    * Default constructor.
    */
   extern function new(string name="uvma_dadder_dp_in_sqr", uvm_component parent=null);

   /**
    * Ensures #cfg & #cntxt handles are not null
    */
   extern virtual function void build_phase(uvm_phase phase);

   /**
    * Uses uvm_config_db to retrieve cfg.
    */
   extern function void get_cfg();

   /**
    * Uses uvm_config_db to retrieve cntxt.
    */
   extern function void get_cntxt();

endclass : uvma_dadder_dp_in_sqr_c


function uvma_dadder_dp_in_sqr_c::new(string name="uvma_dadder_dp_in_sqr", uvm_component parent=null);

   super.new(name, parent);

endfunction : new


function void uvma_dadder_dp_in_sqr_c::build_phase(uvm_phase phase);

   super.build_phase(phase);
   get_cfg  ();
   get_cntxt();

endfunction : build_phase


function void uvma_dadder_dp_in_sqr_c::get_cfg();

   void'(uvm_config_db#(uvma_dadder_dp_in_cfg_c)::get(this, "", "cfg", cfg));
   if (!cfg) begin
      `uvm_fatal("DADDER_DP_IN_SQR", "Configuration handle is null")
   end

endfunction : get_cfg


function void uvma_dadder_dp_in_sqr_c::get_cntxt();

   void'(uvm_config_db#(uvma_dadder_dp_in_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (!cntxt) begin
      `uvm_fatal("DADDER_DP_IN_SQR", "Context handle is null")
   end

endfunction : get_cntxt


`endif // __UVMA_DADDER_DP_IN_SQR_SV__