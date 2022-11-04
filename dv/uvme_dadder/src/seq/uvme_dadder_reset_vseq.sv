// Copyright 2022 Contributors
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_DADDER_RESET_VSEQ_SV__
`define __UVME_DADDER_RESET_VSEQ_SV__


/**
 * Virtual sequence responsible for asserting reset for the Decimal adder/subtracter Block environment.
 * @ingroup uvme_dadder_seq
 */
class uvme_dadder_reset_vseq_c extends uvme_dadder_base_vseq_c;

   /// @name Knobs
   /// @{
   rand int unsigned  duration_min; ///< Lower bound for reset pulse duration
   rand int unsigned  duration_max; ///< Upper bound for reset pulse duration
   /// @}


   `uvm_object_utils_begin(uvme_dadder_reset_vseq_c)
      `uvm_field_int(duration_min, UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(duration_max, UVM_DEFAULT + UVM_DEC)
   `uvm_object_utils_end


   /**
    * Sets safe defaults for knobs.
    */
   constraint defaults_cons {
      soft duration_min ==  10;
      soft duration_max == 100;
   }


   /**
    * Default constructor.
    */
   extern function new(string name="uvme_dadder_reset_vseq_c");

   /**
    * Sends single reset pulse.
    */
   extern virtual task body();

endclass : uvme_dadder_reset_vseq_c


function uvme_dadder_reset_vseq_c::new(string name="uvme_dadder_reset_vseq_c");

   super.new(name);

endfunction : new


task uvme_dadder_reset_vseq_c::body();

   uvma_reset_seq_item_c  reset_req;
   `uvm_do_on_with(reset_req, p_sequencer.reset_sequencer, {
      duration >= duration_min;
      duration <= duration_max;
   })

endtask : body


`endif // __UVME_DADDER_RESET_VSEQ_SV__