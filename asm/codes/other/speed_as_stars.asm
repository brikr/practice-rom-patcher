// Display Speed as Star Count

scope DisplaySpeedasStarCount: {
  lui t0, 0x8034
  lwc1 f4, 0x9E54 (t0)
  trunc.w.s f8, f4
  jr ra
  mfc1 a3, f8
}
