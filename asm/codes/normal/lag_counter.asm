// Lag Frame Counter

origin 0x0E1A2C
base 0x80326A2C
jal 0x8027EF18 // ROM 0x39F18

origin 0x003BB0 // Hijack BUF display
base 0x80248BB0
lui t8, 0x8034
lw t7, 0x9F20 (t8) // Read current value
lw t6, 0x9F24 (t8) // Read previous value
sw t7, 0x9F24 (t8) // Copy current value to previous value
subu t5, t7, t6 // Calculate difference between previous and current
lw a3, 0x9F28 (t8) // Load sum
addu a3, a3, t5 // Expect 2 frames difference
addiu a3, a3, 0xFFFE

origin 0x003BE4
base 0x80248BE4
sw a3, 0x9F28 (t8) // Save sum

origin 0x039F18 // RAM 0x8027EF18
base 0x8027EF18
lui t2, 0x8034
lw t3, 0x9F20 (t2)
addiu t3, t3, 0x0001
sw t3, 0x9F20 (t2) // Add 1 to the video interrupt counter
j 0x80326C18 // Return to normal exception handling path
nop
