// Automatically Reset Timer at Star Select
lb at, 0x9EC9 (t3)
addiu v0, r0, 0x0004
bne at, v0, Skip01 // D0339EC9 0004
nop
sh r0, 0x9EFC (t3) // 81339EFC 0000
Skip01:

// Manual Timer
lb at, 0x9C31 (t3)
addiu v0, r0, 0x0020
bne at, v0, Skip05 // D0339C31 0020
nop
sh r0, 0x9EFC (t3) // 81339EFC 0000
Skip05:
