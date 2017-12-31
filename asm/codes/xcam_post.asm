// X-Cam Timer
scope Xcam: {
  lui t1, 0x8034
  lhu t2, 0x9E1A (t1) // animation cycle counter
  ori t3, r0, 0x01
  bne t2, t3, End
  sb r0, 0x9EEE (t1) // ticking
  ori t2, r0, 0x7F
  sh t2, 0x9EFA (t1) // hud
  End:
    j 0x8025D994
    nop
}
