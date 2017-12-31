// Level Reset

scope LevelReset: {
  lui t0, 0x8034
  lui t1, 0x8036
  lb at, 0x9C31 (t0)
  addiu v0, r0, 0x0020
  bne at, v0, End // D0339C31 0020
  nop
  addiu v0, r0, 0x0880
  sh v0, 0x9EAE (t0) // 81339EAE 0880
  sh r0, 0x9EF2 (t0) // 81339EF2 0000
  sh r0, 0x9EA8 (t0) // 81339EA8 0000
  addiu v0, r0, 0x0002
  sb v0, 0x9ED8 (t0) // 80339ED8 0002
  addiu v0, r0, 0x0005
  sh v0, 0x00A4 (t1) // 813600A4 0005
  End:
}

// Level Reset Camera Fix

scope LevelResetCameraFix: {
  lui t0, 0x8028
  lui t1, 0x8034
  lb at, 0x9ED9 (t1)
  addiu v0, r0, 0x001D
  beq at, v0, TotWC // D2339ED9 001D
  nop
  Fix:
    addiu v0, r0, 0x0001
    sh v0, 0x6D2A (t0) // 81286D2A 0001
  TotWC:
    bne at, v0, End // D0339ED9 001D
    nop
    sh r0, 0x6D2A (t0) // 81286D2A 0000
  End:
}
