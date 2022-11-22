import uvm_pkg::*;

class hello_world_test_c extends uvm_test;
   
   `uvm_component_utils_begin(hello_world_test_c)
   
   function new(string name="hello_world_test", uvm_component parent=null);
      super.new(name, parent);
   endfunction
   
   virtual task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      #1_000ns;
      `uvm_info("TEST", "Hello, World!", UVM_NONE)
      #1_000ns;
      phase.drop_objection(this);
   endtask
   
endclass
