// Star Select

scope StarSelect: {
  lui t0, 0x8033
  lui t1, 0x8034
  lb at, 0x9C31 (t1)
  addiu v0, r0, 0x0030
  bne at, v0, End // D0339C31 0030
  nop
  addiu v0, r0, 0x0880
  sh v0, 0x9EAE (t1) // 81339EAE 0880
  addiu v0, r0, 0x0004
  sh v0, 0x9EC8 (t1) // 81339EC8 0004
  addiu v0, r0, 0x0002
  sb v0, 0x9ED8 (t1) // 80339ED8 0002
  sh r0, 0x9EFC (t1) // 81339EFC 0000
  sw r0, 0xFED4 (t0) // 8132FED4 0000 & 8132FED6 0000
  lb at, 0x9ED9 (t1)
  addiu v0, r0, 0x000D
  bne at, v0, Not_THI // D0339ED9 000D
  nop
  THI:
    addiu v0, r0, 0x020A
    sh v0, 0x9EDA (t1) // 81339EDA 020A
    beq r0, r0, End
    nop
  Not_THI:
    addiu v0, r0, 0x010A
    sh v0, 0x9EDA (t1) // 81339EDA 010A
  End:
}
