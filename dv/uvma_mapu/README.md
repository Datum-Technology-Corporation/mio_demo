# Hello from your Code Generator!
Thank you for using the Moore.io Block-Level UVM Agents+Environment+TB Code Template v1.0!

Your parameters are:
* Name: 'mapu'
* Full Name: 'Matrix APU'
* DUT IP Vendor: 'Acme'
* DUT IP Name: 'mapu'
* DUT IP Type: 'mio'

If this is incorrect, it is recommended to delete the generated IP and re-generate with the correct parameters.

What follows is a short guide for developers of this new UVM Agent. You may also use `grep -nr TODO .` for a full list.


## 1. - Physical interface
 1. - [ ] Checker - `src/uvma_mapu_if_chkr.sv` - Add assertions (if needed) to the Interface Checker Module.
 2. - [ ] Control Plane Sequence Item - `src/seq/uvma_mapu_cp_seq_item.sv` - Format transaction logger data to suit your debugging needs
 3. - [ ] Control Plane Monitor Transaction - `src/obj/uvma_cp_mon_trn.sv` - Format transaction logger data to suit your debugging needs
 4. - [ ] Data Plane Input Sequence Item - `src/seq/uvma_mapu_dpi_seq_item.sv` - Format transaction logger data to suit your debugging needs
 5. - [ ] Data Plane Input Monitor Transaction - `src/obj/uvma_dpi_mon_trn.sv` - Format transaction logger data to suit your debugging needs
 6. - [ ] Data Plane Output Sequence Item - `src/seq/uvma_mapu_dpo_seq_item.sv` - Format transaction logger data to suit your debugging needs
 7. - [ ] Data Plane Output Monitor Transaction - `src/obj/uvma_dpo_mon_trn.sv` - Format transaction logger data to suit your debugging needs
 
## 2. - Logical Transaction Model
 1. - [ ] Sequence Item - `src/seq/uvma_mapu_seq_item.sv` - Modify the sequence item to match your protocol model.
 2. - [ ] Monitor Transaction - `src/obj/uvma_mapu_mon_trn.sv` - Modify the transaction to match your protocol model.

## 3. - Protocol Implementation
 1. - [ ] Configuration - `src/obj/uvma_mapu_cfg.sv` - Add parameters if needed for block parameters.
 2. - [ ] Context - `src/obj/uvma_mapu_cntxt.sv` - Add state variables if needed for block interface protocol.
 3. - [ ] Driver Input Virtual Sequence - `src/seq/uvma_mapu_in_drv_vseq.sv` - Implement the Sequence driving the input interface.
 4. - [ ] Driver Output Virtual Sequence - `src/seq/uvma_mapu_out_drv_vseq.sv` - Implement the Sequence driving the output interface.
 5. - [ ] Monitor Virtual Sequence - `src/seq/uvma_mapu_mon_vseq.sv` - Implement the Sequence rebuilding Monitor Transactions from the interface.


## Have fun!
Make sure to check out the other IP generated along with this test bench.




# Acme Matrix APU Block UVM Agent


## About
This package contains the Acme Matrix APU Block UVM Agent.
TODO Describe Matrix APU


## Block Diagram
![alt text](./docs/agent_block_diagram.svg "Matrix APU UBlock VM Agent Block Diagram")

## Directory Structure
* `bin` - Scripts, metadata and other miscellaneous files
* `docs` - Reference documentation
* `examples` - Code samples for using and extending this agent
* `src` - Source code


## Dependencies
It is dependent on the following IP:

* [uvmx](https://www.mooreio.com/catalog/1152)