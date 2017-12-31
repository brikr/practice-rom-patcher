// Level Reset
lb at, 0x9C31 (t3)
addiu v0, r0, 0x0020
bne at, v0, Skip02 // D0339C31 0020
nop
addiu v0, r0, 0x0008
sb v0, 0x9EAE (t3) // 80339EAE 0008
sh r0, 0x9EF2 (t3) // 81339EF2 0000
sh r0, 0x9EA8 (t3) // 81339EA8 0000
addiu v0, r0, 0x0002
sb v0, 0x9ED8 (t3) // 80339ED8 0002
addiu v0, r0, 0x0005
sh v0, 0x00A4 (t4) // 813600A4 0005
Skip02:

// Level Reset Camera Fix
lb at, 0x9ED9 (t3)
addiu v0, r0, 0x001D
beq at, v0, Skip03 // D2339ED9 001D
nop
addiu v0, r0, 0x0001
sh v0, 0x6D2A (t1) // 81286D2A 0001
Skip03:
  bne at, v0, Skip04 // D0339ED9 001D
  nop
  sh r0, 0x6D2A (t1) // 81286D2A 0000
Skip04:
