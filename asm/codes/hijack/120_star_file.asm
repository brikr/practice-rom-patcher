// 120 Star File (Slot 3)

lui t0, 0x8020
addiu v0, r0, 0x1F10
sh v0, 0x7BE8 (t0) // 81207BE8 1F10
addiu v0, r0, 0xFFCB
sh v0, 0x7BEA (t0) // 81207BEA FFCB
addiu v0, r0, 0x7FFF
sh v0, 0x7BEC (t0) // 81207BEC 7FFF
sh v0, 0x7BEE (t0) // 81207BEE 7FFF
addiu v0, r0, 0x7F7F
sh v0, 0x7BF0 (t0) // 80207BF0 007F & 80207BF1 007F
sh v0, 0x7BF2 (t0) // 80207BF2 007F & 80207BF3 007F
sh v0, 0x7BF4 (t0) // 80207BF4 007F & 80207BF5 007F
sh v0, 0x7BF6 (t0) // 80207BF6 007F & 80207BF7 007F
sh v0, 0x7BF8 (t0) // 80207BF8 007F & 80207BF9 007F
sb v0, 0x7BFA (t0) // 80207BFA 007F
addiu v0, r0, 0x0081
sb v0, 0x7BFB (t0) // 80207BFB 0081
addiu v0, r0, 0x0101
sh v0, 0x7BFC (t0) // 81207BFC 0101
addiu v0, r0, 0x0301
sh v0, 0x7BFE (t0) // 81207BFE 0301
addiu v0, r0, 0x0101
sh v0, 0x7C00 (t0) // 81207C00 0101
addiu v0, r0, 0x0181
sh v0, 0x7C02 (t0) // 81207C02 0181
