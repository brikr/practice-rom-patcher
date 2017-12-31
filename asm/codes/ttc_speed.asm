// TTC Clock Speed
lb at, 0x9C31 (t3)
addiu v0, r0, 0x0028
bne at, v0, Skip08 // D0339C31 0028
nop
addiu v0, r0, 0x0001
sb v0, 0xFEE9 (t4) // 8035FEE9 0001
Skip08:
  addiu v0, r0, 0x0024
  bne at, v0, Skip09 // D0339C31 0024
  nop
  addiu v0, r0, 0x0003
  sb v0, 0xFEE9 (t4) // 8035FEE9 0003
Skip09:
