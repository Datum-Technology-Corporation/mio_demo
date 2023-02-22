// Copyright 2023 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_MAPU_FIX_STIM_VSEQ_SV__
`define __UVME_MAPU_FIX_STIM_VSEQ_SV__


/**
 * Sequence that always generates the same (i.e. reference) stimulus for the DUT.
 * @ingroup uvme_mapu_seq
 */
class uvme_mapu_fix_stim_vseq_c extends uvme_mapu_base_vseq_c;

   `uvm_object_utils(uvme_mapu_fix_stim_vseq_c)

   /**
    * Default constructor.
    */
   function new(string name="uvme_mapu_fix_stim_vseq");
      super.new(name);
   endfunction

   /**
    * TODO Describe uvme_mapu_fix_stim_vseq_c::body()
    */
   virtual task body();
      add ();
      mult();
   endtask

   /**
    * TODO Describe uvme_mapu_fix_stim_vseq_c::add()
    */
   virtual task add();
      uvma_mapu_seq_item_c  seq_item;
      `uvm_create_on(seq_item, p_sequencer.agent_vsequencer)
      seq_item.ton = 100;
      seq_item.op  = UVMA_MAPU_OP_ADD;
      seq_item.ma.load('{
         '{1,0,2},
         '{3,2,1},
         '{2,1,0}
      });
      seq_item.mb.load('{
         '{1,0,2},
         '{3,2,1},
         '{2,1,0}
      });
      `uvm_send(seq_item)

      `uvm_create_on(seq_item, p_sequencer.agent_vsequencer)
      seq_item.ton = 100;
      seq_item.op  = UVMA_MAPU_OP_ADD;
      seq_item.ma.load('{
         '{2,1,0},
         '{1,0,2},
         '{2,1,0}
      });
      seq_item.mb.load('{
         '{2,1,0},
         '{1,0,2},
         '{2,1,0}
      });
      `uvm_send(seq_item)
   endtask

   /**
    * TODO Describe uvme_mapu_fix_stim_vseq_c::mult()
    */
   virtual task mult();
      uvma_mapu_seq_item_c  seq_item;
      `uvm_create_on(seq_item, p_sequencer.agent_vsequencer)
      seq_item.ton = 100;
      seq_item.op  = UVMA_MAPU_OP_MULT;
      seq_item.ma.load('{
         '{1,0,2},
         '{3,2,1},
         '{2,1,0}
      });
      seq_item.mb.load('{
         '{1,0,2},
         '{3,2,1},
         '{2,1,0}
      });
      `uvm_send(seq_item)

      `uvm_create_on(seq_item, p_sequencer.agent_vsequencer)
      seq_item.ton = 100;
      seq_item.op  = UVMA_MAPU_OP_MULT;
      seq_item.ma.load('{
         '{2,1,0},
         '{1,0,2},
         '{2,1,0}
      });
      seq_item.mb.load('{
         '{2,1,0},
         '{1,0,2},
         '{2,1,0}
      });
      `uvm_send(seq_item)
   endtask

endclass : uvme_mapu_fix_stim_vseq_c


`endif // __UVME_MAPU_FIX_STIM_VSEQ_SV__
