// TTC Clock Speed

scope TTCClockSpeed: {
  lui t0, 0x8034
  lui t1, 0x8036
  lb at, 0x9C31 (t0)
  addiu v0, r0, 0x0028
  bne at, v0, Stop // D0339C31 0028
  nop
  Fast:
    addiu v0, r0, 0x0001
    sb v0, 0xFEE9 (t1) // 8035FEE9 0001
  Stop:
    addiu v0, r0, 0x0024
    bne at, v0, End // D0339C31 0024
    nop
    addiu v0, r0, 0x0003
    sb v0, 0xFEE9 (t1) // 8035FEE9 0003
  End:
}
