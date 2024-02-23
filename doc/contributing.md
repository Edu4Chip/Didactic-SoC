# Contributing

This file will contain some instructions how to contribute to this project.

## Branches

When merging branches, branch should always sync itself to main branch before accepting merge. This protects XML files from being faultily merged. Sometimes default merge rules work with them just fine, but sometimes the merges behave erraticly.

E.G. Require merge of main to branch before accepting any requests.

## IPXACT 

IPXACT models are preliminarily "okay". but as the work continues, new additions and improvements should regurarly be done. This also mandates need to run regeneration of the RTL, as any update in IPXACT, might cause change in generated results.

HW diagrams are XML files and git is not very great at handling those merges correctly. It should be taken care manually that XML is always in sane state, and that only fully correct versions are merged.

## RTL

While reused RTL has been behaviorally proven in previous projects, some tweaks were done to interfaces. This results in requirement to run reverification to them. It is sufficent to run them as part of the top level simulations.

Some compilation errors are still present as the xbar logic for example is largely unfinished.

## verification flow

TBD

## synthesis flow

TBD