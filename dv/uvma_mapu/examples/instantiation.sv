// Copyright 2022 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// This file contains sample code that demonstrates how to add an instance of the Matrix APU UVM Agent to an example UVM environment.
// NOTE: It is recommended to split up class member declaration and definition.  These classes are all inline to keep the example short.


`ifndef __UVME_EXAMPLE_CFG_SV__
`define __UVME_EXAMPLE_CFG_SV__


/**
 * Object encapsulating all configuration information for uvme_example_env_c.
 */
class uvme_example_cfg_c extends uvml_cfg_c;

   rand uvma_mapu_cfg_c  mapu_cfg; ///< Handle to mapu agent configuration

   `uvm_object_utils_begin(uvme_example_cfg_c)
      `uvm_field_object(mapu_cfg, UVM_DEFAULT)
   `uvm_object_utils_end

   /**
    * mapu_cfg in active mode.
    */
   constraint defaults_cons {
      mapu_cfg.enabled         == 1;
      mapu_cfg.is_active       == UVM_ACTIVE;
      mapu_cfg.reset_type      == UVML_RESET_TYPE_SYNCHRONOUS;
      mapu_cfg.trn_log_enabled == 1;
   }

   /**
    * Creates sub-configuration objects
    */
   function new(string name="uvme_example_cfg");
      super.new(name);
      mapu_cfg = uvma_mapu_cfg_c::type_id::create("mapu_cfg");
   endfunction : new

endclass : uvme_example_cfg_c


`endif // __UVME_EXAMPLE_CFG_SV__


`ifndef __UVME_EXAMPLE_CNTXT_SV__
`define __UVME_EXAMPLE_CNTXT_SV__


/**
 * Object encapsulating all state variables for uvme_example_env_c.
 */
class uvme_example_cntxt_c extends uvml_cntxt_c;

   uvma_mapu_cntxt_c  mapu_cntxt; ///< Handle to mapu agent context

   `uvm_object_utils_begin(uvme_example_cntxt_c)
      `uvm_field_object(mapu_cntxt, UVM_DEFAULT)
   `uvm_object_utils_end

   /**
    * Creates sub-context objects
    */
   function new(string name="uvme_example_cntxt");
      super.new(name);
      mapu_cntxt = uvma_mapu_cntxt_c::type_id::create("mapu_cntxt");
   endfunction : new

endclass : uvme_example_cntxt_c


`endif // __UVME_EXAMPLE_CNTXT_SV__


`ifndef __UVME_EXAMPLE_ENV_SV__
`define __UVME_EXAMPLE_ENV_SV__


/**
 * Component encapsulating the example environment.
 */
class uvme_example_env_c extends uvml_env_c;

   uvme_example_cfg_c    cfg  ; ///< Configuration handle. Must be provided by component instantiating this environment.
   uvme_example_cntxt_c  cntxt; ///< Context handle.  Can be provided by component instantiating this environment.
   uvma_mapu_agent_c  mapu_agent; ///< Matrix APU agent instance.

   `uvm_component_utils_begin(uvme_example_env_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end

   /**
    * Default constructor.
    */
   function new(uvm_component parent=null, string name="uvme_example_env");
      super.new(parent, name);
   endfunction : new

   /**
    * 1. Ensures #cfg & #cntxt handles are not null
    * 2. Assigns #cfg and #cntxt handles
    * 3. Creates #mapu_agent
    */
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);

      void'(uvm_config_db#(uvme_example_cfg_c)::get(this, "", "cfg", cfg));
      if (!cfg) begin
         `uvm_fatal("EXAMPLE_ENV", "Configuration handle is null")
      end
      else begin
         `uvm_info("EXAMPLE_ENV", $sformatf("Found configuration handle:\n%s", cfg.sprint()), UVM_DEBUG)
         void'(uvm_config_db#(uvme_example_cntxt_c)::get(this, "", "cntxt", cntxt));
         if (!cntxt) begin
            `uvm_info("EXAMPLE_ENV", "Context handle is null; creating.", UVM_DEBUG)
            cntxt = uvme_example_cntxt_c::type_id::create("cntxt");
         end
         uvm_config_db#(uvme_example_cfg_c  )::set(this, "*", "cfg"  , cfg  );
         uvm_config_db#(uvme_example_cntxt_c)::set(this, "*", "cntxt", cntxt);
         uvm_config_db#(uvma_mapu_cfg_c  )::set(this, "mapu_agent", "cfg"  , cfg  .mapu_cfg  );
         uvm_config_db#(uvma_mapu_cntxt_c)::set(this, "mapu_agent", "cntxt", cntxt.mapu_cntxt);
         mapu_agent = uvma_mapu_agent_c::type_id::create("mapu_agent", this);
         end
      end
   endfunction : build_phase

endclass : uvme_example_env_c


`endif // __UVME_EXAMPLE_ENV_SV__