// Lag Frame Counter
lb at, 0x9C31 (t3)
addiu v0, r0, 0x0020
bne at, v0, Skip14 // D0339C31 0020
nop
sw r0, 0x9F28 (t3) // 81339F28 0000 & 81339F2A 0000
Skip14:

// Automatically Reset Counter at Star Select
lb at, 0x9EC9 (t3)
addiu v0, r0, 0x0004
bne at, v0, Skip15 // D0339EC9 0004
nop
sw r0, 0x9F28 (t3) // 81339F28 0000 & 81339F2A 0000
Skip15:

// Hide BUF Text
lui t0, 0x8033
addiu v0, r0, 0x2564
sh v0, 0x4A70 (t0) // 81334A70 2564
sb r0, 0x4A72 (t0) // 80334A72 0000
