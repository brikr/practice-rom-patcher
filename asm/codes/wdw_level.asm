// WDW Water Level
lh at, 0x9C30 (t3)
addiu v0, r0, 0x0820
bne at, v0, Skip11 // D1339C30 0820
nop
addiu v0, r0, 0x44CB
sh v0, 0xFFDC (t2) // 8132FFDC 44CB
Skip11:
  addiu v0, r0, 0x0120
  bne at, v0, Skip12 // D1339C30 0120
  nop
  addiu v0, r0, 0x44BB
  sh v0, 0xFFDC (t2) // 8132FFDC 44BB
Skip12:
  addiu v0, r0, 0x0420
  bne at, v0, Skip13 // D1339C30 0420
  nop
  addiu v0, r0, 0x44AB
  sh v0, 0xFFDC (t2) // 8132FFDC 44AB
Skip13:
