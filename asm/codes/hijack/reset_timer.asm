// Manual Timer Reset on L

scope ManualTimerReset: {
  lui t0, 0x8034
  lb at, 0x9C31 (t0)
  addiu v0, r0, 0x0020
  bne at, v0, End // D0339C31 0020
  nop
  sh r0, 0x9EFC (t0) // 81339EFC 0000
  End:
}

// Automatically Reset Timer at Star Select

scope ManualTimerAutoReset: {
  lui t0, 0x8034
  lb at, 0x9EC9 (t0)
  addiu v0, r0, 0x0004
  bne at, v0, End // D0339EC9 0004
  nop
  sh r0, 0x9EFC (t0) // 81339EFC 0000
  End:
}
