// Upstairs RTA (74-Star) Practice File (Slot 4)

lui t0, 0x8020
addiu v0, r0, 0x7F7F
sh v0, 0x7C5C (t0) // 80207C5C 007F & 80207C5D 007F
sh v0, 0x7C5E (t0) // 80207C5E 007F & 80207C5F 007F
sh v0, 0x7C60 (t0) // 80207C60 007F & 80207C61 007F
sh v0, 0x7C62 (t0) // 80207C62 007F & 80207C63 007F
sb v0, 0x7C64 (t0) // 80207C64 007F
addiu v0, r0, 0x7F0F
sh v0, 0x7C6E (t0) // 81207C6E 7F0F

// Upstairs RTA (74-Star) Practice File (Slot 4)

scope 74StarFile: {
  lui t0, 0x8020
  lb at, 0x7C5A (t0)
  bne at, r0, End // D0207C5A 0000
  nop
  addiu v0, r0, 0xFF6B
  sh v0, 0x7C5A (t0) // 81207C5A FF6B
  End:
}
