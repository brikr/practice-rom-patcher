// Soft Reset

scope SoftReset: {
  lui t0, 0x8034
  lui t1, 0x8039
  lh at, 0x9C30 (t0)
  addiu v0, r0, 0xF000
  bne at, v0, End // D1339C30 F000
  nop
  addiu v0, r0, 0x0004
  sh v0, 0x9EC8 (t0) // 81339EC8 0004
  addiu v0, r0, 0x0101
  sh v0, 0x9ED8 (t0) // 81339ED8 0101
  sh r0, 0xEEE0 (t1) // 8138EEE0 0000
  End:
}
