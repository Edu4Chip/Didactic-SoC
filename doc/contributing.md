# Contributing

This file will contain some instructions how to contribute to this project.

## Branches

When merging branches, branch should always sync itself to main branch before accepting merge. This protects XML files from being faultily merged by automation. Sometimes default merge rules work with them just fine, but sometimes the merges can behave erraticly.

E.G. Require merge of main to branch before accepting any requests.

## IPXACT 

IPXACT models are preliminarily "okay". but as the work continues, new additions and improvements should regurarly be done. This also mandates need to run regeneration of the RTL, as any update in IPXACT, might cause change in generated results.

HW diagrams are XML files and git is not very great at handling those merges correctly. It should be taken care manually that XML is always in sane state, and that only fully correct versions are merged.

## RTL

While reused RTL has been behaviorally proven in previous projects, some tweaks were done to interfaces. This results in requirement to rerun verification to them. It is considered sufficent to run them as part of the top level simulations.

Some compilation errors are still present as the xbar logic for example is largely unfinished.

## verification flow

Verification flow is initially ony for questa but there is also experimental verilator flow. Both are considered as intial versions, improvements could be done.

Additional verification tools could improve the project such as open source verification and formal analysis tools.

## synthesis flow

Open source synthesis tools and their flow could be valuable addition to the project.
