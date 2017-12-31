// WDW Water Level

scope WDWWaterLevel: {
  lui t0, 0x8033
  lui t1, 0x8034
  lh at, 0x9C30 (t1)
  addiu v0, r0, 0x0820
  bne at, v0, Medium // D1339C30 0820
  nop
  High:
    addiu v0, r0, 0x44CB
    sh v0, 0xFFDC (t0) // 8132FFDC 44CB
  Medium:
    addiu v0, r0, 0x0120
    bne at, v0, Low // D1339C30 0120
    nop
    addiu v0, r0, 0x44BB
    sh v0, 0xFFDC (t0) // 8132FFDC 44BB
  Low:
    addiu v0, r0, 0x0420
    bne at, v0, End // D1339C30 0420
    nop
    addiu v0, r0, 0x44AB
    sh v0, 0xFFDC (t0) // 8132FFDC 44AB
  End:
}
