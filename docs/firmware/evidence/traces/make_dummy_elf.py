#!/usr/bin/env python3
# Minimal bfin-elf ELF with a .text section so gdbsim will load it.
# Entry 0xFFA00000; .text = 4 bytes at 0x20200000 (overwritten by restore).
import struct, sys

out = sys.argv[1] if len(sys.argv) > 1 else "/tmp/prog.elf"

EM_BLACKFIN = 106
entry = 0xFFA00000
text_vaddr = 0x20200000
payload = b"\x00\x00\x00\x00"

shstr = b"\x00.text\x00.shstrtab\x00"
name_text = 1
name_shstrtab = 7

EHSZ = 52
text_off = EHSZ
shstr_off = text_off + len(payload)
# align shoff to 4
shoff = (shstr_off + len(shstr) + 3) & ~3

ehdr = struct.pack(
    "<16sHHIIIIIHHHHHH",
    b"\x7fELF" + bytes([1, 1, 1]) + b"\x00" * 9,
    2, EM_BLACKFIN, 1,
    entry,
    0,              # phoff (none)
    shoff,
    0,
    EHSZ,
    0, 0,           # phentsize, phnum
    40,             # shentsize
    3,              # shnum: null, .text, .shstrtab
    2,              # shstrndx
)

def sh(name, typ, flags, addr, off, size, link=0, info=0, align=1, entsize=0):
    return struct.pack("<IIIIIIIIII", name, typ, flags, addr, off, size,
                       link, info, align, entsize)

SHT_PROGBITS = 1
SHT_STRTAB = 3
SHF_WRITE = 1
SHF_ALLOC = 2
SHF_EXECINSTR = 4

s_null = b"\x00" * 40
s_text = sh(name_text, SHT_PROGBITS, SHF_ALLOC | SHF_EXECINSTR | SHF_WRITE,
            text_vaddr, text_off, len(payload), align=4)
s_shstr = sh(name_shstrtab, SHT_STRTAB, 0, 0, shstr_off, len(shstr))

blob = bytearray(shoff + 3 * 40)
blob[0:EHSZ] = ehdr
blob[text_off:text_off + len(payload)] = payload
blob[shstr_off:shstr_off + len(shstr)] = shstr
blob[shoff:shoff + 120] = s_null + s_text + s_shstr

with open(out, "wb") as f:
    f.write(bytes(blob))
print(f"wrote {out} ({len(blob)} bytes)")
