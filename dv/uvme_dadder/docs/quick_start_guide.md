@page quick_start_guide Quick Start Guide
@htmlonly
<div class="autonumbering">
@endhtmlonly



@tableofcontents



@section quick_start_license_agreement License Agreement
© Copyright 2022 Contributors

SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1



@section quick_start_guide_id Document Information
ID | Name | Version
-- | ---- | -------
001 | Quick Start Guide | v.1.0


@subsection quick_start_guide_description Description
This document is a short guide to running the Decimal adder/subtracter Block-Level UVM Environment in its own Test Bench.

![uvme_dadder_env_c Block Diagram](env_block_diagram.svg)



@section quick_start_guide_revision_history Revision History
Revision  | Date | Description
--------- | ---- | -----------
1.0 | 2022/01/01 | Initial Version



@section quick_start_guide_definitions Definitions
Symbol | Definition
------ | ----------
 'ABC' | Always Be Closing



@section quick_start_guide_prerequisites Pre-Requisites
The Moore.io Client CLI, used throughout this tutorial is available via "pipx":
@code{.sh}pipx install mio-client@endcode



@section quick_start_guide_introduction Introduction
The Decimal adder/subtracter UVM Environment has a Test Bench used to verify the Decimal adder/subtracter Block thoroughly.
This guide will walk you through running a Test from this Test Bench.



@section quick_start_guide_installation Installation
1. Install the Decimal adder/subtracter Block-Level Control Plane UVM Agent: @code{.sh}mio install uvma_dadder_cp@endcode
2. Install the Decimal adder/subtracter Block-Level Data Plane Input UVM Agent: @code{.sh}mio install uvma_dadder_dp_in@endcode
3. Install the Decimal adder/subtracter Block-Level Data Plane Output UVM Agent: @code{.sh}mio install uvma_dadder_dp_out@endcode
4. Install the Decimal adder/subtracter Block-Level UVM Environment: @code{.sh}mio install uvme_dadder@endcode
5. Install the Decimal adder/subtracter Block-Level UVM Test Bench: @code{.sh}mio install uvmt_dadder@endcode


@section quick_start_guide_compile_elaborate Compile and Elaborate
1. Compile the Decimal adder/subtracter Block-Level UVM Test Bench: @code{.sh}mio sim uvmt_dadder -C@endcode
2. Elaborate the Decimal adder/subtracter Block-Level UVM Test Bench with wave capture enabled: @code{.sh}mio sim uvmt_dadder -E -w@endcode


@section quick_start_guide_simulate Simulate
Launch Decimal adder/subtracter Block-Level UVM Test "rand_stim" with seed "1":
@code{.sh}mio sim uvmt_dadder -S -t rand_stim -s 1@endcode



@section quick_start_guide_results Results
The Moore.io CLI will printout the commands to view both the simulation logs (don't forget to check out the "trn_log"
directory for transaction logs) and waveforms.



@section quick_start_guide_conclusion Conclusion
That's all for this short guide.  For more information, including integration, have a look at the @subpage user_guide "User Guide".



@htmlonly
</div>
@endhtmlonly