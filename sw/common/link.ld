/*
 * Project: Edu4chip
 * Description: 
 *   - Didactic linkerscript
 *   - Adapted from SoC-HUB work
 * Contributors:
 *   - Antti Nurmi        (antti.nurmi@tuni.fi)
 *   - Henri Lunnikivi    (henri.lunnikivi@tuni.fi)
 *   - Abdelkadir Chantar (abdelkadir.chantar@tuni.fi)
 *   - Abdesattar Kalache (abdesattar.kalache@tuni.fi)
 *   - Matti Käyrä        (matti.kayra@tuni.fi)
 * Notes:
 *   - This linker needs to be adapted to correct locations and sizes of memory
 */

OUTPUT_ARCH(riscv)
SEARCH_DIR(.)
__DYNAMIC = 0;

MEMORY
{
  IMEM (rx ) : ORIGIN = 0x01000000, LENGTH = 0x1000
  DMEM (rwx) : ORIGIN = 0x01010140, LENGTH = 0x1000
}

STACK_SIZE = 0xC00; 

SECTIONS
{
  .text : ALIGN(4)
  {
    KEEP(*(.vectors .vectors.*))
    _stext = .;
    *(.text*)
    _etext = .;
    *(.rodata*)
  } > IMEM

  .data : ALIGN(4)
  {
    *(.data*);
  } > DMEM

  .sdata : ALIGN(4)
  {
    *(.sdata*);
  } > DMEM

  .bss (NOLOAD) :
  {
    *(.bss*)
    *(COMMON)
  } > DMEM
 
  .stack (NOLOAD) : 
  {
    . = ALIGN(4);
    stack = . + STACK_SIZE;
  } > DMEM

  _end = . ;
}
