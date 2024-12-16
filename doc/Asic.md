# Asic synthesis

Asic synthesis is heavily technology dependent process. Few considerations for it is listed in this file. Based on technology, memories likely need to be converted to using macros.

Clock tree components in <code>src/tech_generic/</code> need to be replaced with instances of high speed/ high drive cells.

IO cells are technology dependent cells. the ones present in <code>src/tech_generic/</code> need to be replaced with actual IO cells in synthesis runs.