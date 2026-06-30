# Kactus2 and IP-XACT

This is brief guide on Kactus2 and Kactus2.

## IP-XACT standard

IP-XACT is standard for IPs, their interface, connectivity and memory map. They do not contain any behavioral description. This repository IP-XACT is latest standard (1685-2022, in short, referred as 22 standard). 

## Kactus2 briefly

Kactus2 is SoC design toolset based on IP-XACT stadard. Video guides how to use Kactus2 can be found at [youtube/Kactus2Tutorial](https://www.youtube.com/@Kactus2Tutorial). You can also see the [kactus2dev](https://github.com/kactus2/kactus2dev/) repository for the most recent updates and to get latest version of the tool. IP-XACT 22 version requires Kactus2 to be sufficiently new version. It is highly recommended to have most up-to-date release version.

Main use of Kactus2 in Didactic is integration. IP-XACT packaged modules are placed and connected in hardware diagrams to create full SoCs. Structural RTL is generated based on these diagrams. Hierarchical designs can be further used to generate supportive items such as soc address headers, Renode platform files and documentation. This capability depends on extensivity of the modeled IPs. 
