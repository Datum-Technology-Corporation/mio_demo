// Copyright 2022 Contributors
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_DADDER_RAND_STIM_VSEQ_SV__
`define __UVME_DADDER_RAND_STIM_VSEQ_SV__


/**
 * Sample sequence that runs 10 fully random items by default.
 * @ingroup uvme_dadder_seq
 */
class uvme_dadder_rand_stim_vseq_c extends uvme_dadder_base_vseq_c;

   /// @name Knobs
   /// @{
   rand int unsigned  num_items; ///< Number of sequence items to be generated.
   /// @}


   `uvm_object_utils_begin(uvme_dadder_rand_stim_vseq_c)
      `uvm_field_int(num_items, UVM_DEFAULT + UVM_DEC)
   `uvm_object_utils_end


   /**
    * Default values for random fields.
    */
   constraint defaults_cons {
      soft num_items == 10;
   }


   /**
    * Default constructor.
    */
   extern function new(string name="uvme_dadder_rand_stim_vseq");

   /**
    * Generates #num_items of fully random reqs.
    */
   extern virtual task body();

endclass : uvme_dadder_rand_stim_vseq_c


function uvme_dadder_rand_stim_vseq_c::new(string name="uvme_dadder_rand_stim_vseq");

   super.new(name);

endfunction : new


task uvme_dadder_rand_stim_vseq_c::body();

   uvma_dadder_cp_seq_item_c     cp_req;
   uvma_dadder_dp_in_seq_item_c  dp_req;
   fork
      begin
         do begin
            `uvm_do_on(cp_req, p_sequencer.cp_sequencer)
            if (cp_req.en === 1) begin
               num_items--;
               `uvm_info("DADDER_RAND_STIM_VSEQ", $sformatf("%0d items left", num_items), UVM_HIGH)
            end
         end while (num_items > 0);
      end

      begin
         forever begin
            `uvm_do_on(dp_req, p_sequencer.dp_in_sequencer)
         end
      end
   join_any
   disable fork;
   `uvm_do_on_with(cp_req, p_sequencer.cp_sequencer, {
      en == 0;
   })

endtask : body


`endif // __UVME_DADDER_RAND_STIM_VSEQ_SV__