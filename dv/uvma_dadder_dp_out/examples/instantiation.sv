// Copyright 2022 Contributors
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// This file contains sample code that demonstrates how to add an instance of the Decimal adder/subtracter Block Data Plane Output UVM Agent to a
// a UVM environment.  NOTE: It is recommended to split up class member declaration and definition.  These classes are
// all inline to keep the example short.


`ifndef __MY_ENV_CFG_SV__
`define __MY_ENV_CFG_SV__


/**
 * Object encapsulating all configuration information for my_env.
 */
class my_env_cfg_c extends uvm_object;

   rand uvma_dadder_dp_out_cfg_c  dadder_dp_out_cfg; ///< Handle to dadder_dp_out agent configuration

   `uvm_object_utils_begin(my_env_cfg_c)
      `uvm_field_object(dadder_dp_out_cfg, UVM_DEFAULT)
   `uvm_object_utils_end

   /**
    * Rules for safe default options
    */
   constraint defaults_cons {
      soft dadder_dp_out_cfg.enabled == 1;
   }

   /**
    * Creates sub-configuration objects
    */
   function new(uvm_component parent=null, string name="my_env");
      super.new(parent, name);
      cfg = uvma_dadder_dp_out_cfg_c::type_id::create("dadder_dp_out_cfg");
   endfunction : new

endclass : my_env_cfg_c


`endif // __MY_ENV_CFG_SV__


`ifndef __MY_ENV_CNTXT_SV__
`define __MY_ENV_CNTXT_SV__


/**
 * Object encapsulating all state variables for my_env.
 */
class my_env_cntxt_c extends uvm_object;

   uvma_dadder_dp_out_cntxt_c  dadder_dp_out_cntxt; ///< Handle to dadder_dp_out agent context

   `uvm_object_utils_begin(my_env_cntxt_c)
      `uvm_field_object(dadder_dp_out_cntxt, UVM_DEFAULT)
   `uvm_object_utils_end

   /**
    * Creates sub-context objects
    */
   function new(uvm_component parent=null, string name="my_env");
      super.new(parent, name);
      cntxt = uvma_dadder_dp_out_cntxt_c::type_id::create("dadder_dp_out_cntxt");
   endfunction : new

endclass : my_env_cntxt_c


`endif // __MY_ENV_CNTXT_SV__


`ifndef __MY_ENV_SV__
`define __MY_ENV_SV__


/**
 * Component encapsulating the environment.
 */
class my_env_c extends uvm_env;

   my_env_cfg_c    cfg  ; ///< Configuration handle. Must be provided by component instantiating this environment.
   my_env_cntxt_c  cntxt; ///< Context handle.  Can be provided by component instantiating this environment.
   uvma_dadder_dp_out_agent_c  dadder_dp_out_agent; ///< Decimal adder/subtracter Block Data Plane Output agent instance.

   `uvm_component_utils_begin(my_env_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end

   /**
    * Default constructor.
    */
   function new(uvm_component parent=null, string name="my_env");
      super.new(parent, name);
   endfunction : new

   /**
    * 1. Ensures #cfg & #cntxt handles are not null
    * 2. Assigns #cfg and #cntxt handles
    * 3. Creates #dadder_dp_out_agent
    */
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);

      void'(uvm_config_db#(my_env_cfg_c)::get(this, "", "cfg", cfg));
      if (!cfg) begin
         `uvm_fatal("MY_ENV", "Configuration handle is null")
      end
      else begin
         `uvm_info("MY_ENV", $sformatf("Found configuration handle:\n%s", cfg.sprint()), UVM_DEBUG)
         void'(uvm_config_db#(my_env_cntxt_c)::get(this, "", "cntxt", cntxt));
         if (!cntxt) begin
            `uvm_info("MY_ENV", "Context handle is null; creating.", UVM_DEBUG)
            cntxt = my_env_cntxt_c::type_id::create("cntxt");
         end
         uvm_config_db#(my_env_cfg_c  )::set(this, "*", "cfg"  , cfg  );
         uvm_config_db#(my_env_cntxt_c)::set(this, "*", "cntxt", cntxt);
         uvm_config_db#(uvma_dadder_dp_out_cfg_c  )::set(this, "dadder_dp_out_agent", "cfg"  , cfg  .dadder_dp_out_cfg  );
         uvm_config_db#(uvma_dadder_dp_out_cntxt_c)::set(this, "dadder_dp_out_agent", "cntxt", cntxt.dadder_dp_out_cntxt);
         dadder_dp_out_agent = uvma_dadder_dp_out_agent_c::type_id::create("dadder_dp_out_agent", this);
         end
      end
   endfunction : build_phase

endclass : my_env_c


`endif // __MY_ENV_SV__