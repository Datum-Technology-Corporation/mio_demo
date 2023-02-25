# Hello from your Code Generator!
Thank you for using the Moore.io Block-Level UVM Agents+Environment+TB Code Template v1.0!

Your parameters are:
* Name: 'mapu'
* Full Name: 'Matrix APU'
* DUT IP Vendor: 'Acme'
* DUT IP Name: 'mapu'
* DUT IP Type: 'mio'

If this is incorrect, it is recommended to delete the generated IP and re-generate with the correct parameters.

This code template assumes the DUT has a single datapath (DP) direction.

What follows is a short guide for developers of this new UVM Environment.  You may also use `grep -nr TODO .` for a full list.

## 1. - Prediction and Scoreboarding
 1. - [ ] Configuration - `src/obj/uvme_mapu_cfg.sv` - Add knobs if needed and set up the agent's configurations.  Configure scoreboard logs.
 2. - [ ] Context - `src/obj/uvme_mapu_cntxt.sv` - Add state variables needed by the Predictor and Virtual Sequences.
 3. - [ ] Predictor - `src/comps/uvme_mapu_prd.sv` - Use the sample code as a guide to model input transactions into output transactions.

## 2. - Functional Coverage
 1. - [ ] Functional Coverage Model - `src/comps/uvme_mapu_cov_model.sv` - Use the sample code as a guide to implement the Functional Coverage model for your Design block.

## 3. - Stimulus
 1. - [ ] Fixed Stimulus Virtual Sequence - `src/seq/uvme_mapu_fix_stim_vseq.sv` - Modify the sample stimulus to form valid fixed (i.e. directed) stimulus for your Design Block.
 2. - [ ] Random Stimulus Virtual Sequence - `src/seq/uvme_mapu_rand_stim_vseq.sv` - Modify the sample stimulus if needed to form valid constrained-random stimulus for your Design Block.
 3. - [ ] Fixed Illegal Stimulus Virtual Sequence - `src/seq/uvme_mapu_fix_ill_stim_vseq.sv` - Modify the sample stimulus to form fixed valid/illegal stimulus for your Design Block.
 4. - [ ] Random Illegal Stimulus Virtual Sequence - `src/seq/uvme_mapu_rand_ill_stim_vseq.sv` - Modify the sample stimulus to form constrained-random valid/illegal stimulus for your Design Block.


## Have fun!
Make sure to check out the other IP generated along with this environment:
* `uvma_mapu`
* `uvmt_mapu`




# Acme Matrix APU Block UVM Environment


# About
This IP contains the Acme Matrix APU Block UVM Environment.

TODO Describe Matrix APU


# Block Diagram
![alt text](./docs/env_block_diagram.svg "Matrix APU Block UVM Environment Block Diagram")

# Directory Structure
* `bin` - Scripts, metadata and other miscellaneous files
* `docs` - Reference documentation
* `examples` - Code samples for using and extending this environment
* `src` - Source code


# Dependencies
It is dependent on the following IP:

* [uvmx](https://www.mooreio.com/catalog/1152)
* [uvml_sb](https://www.mooreio.com/catalog/1155)
* uvma_mapu