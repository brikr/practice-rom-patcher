// Level Select
lui t0, 0x8034
lui t1, 0x8028
addiu t1, t1, 0xEECC // ROM 0x39ECC
ArrayLoop:
  lb t2, 0x0000 (t1) // Load first byte of D1 value from array
  sll t2, t2, 0x8 // Shift first byte left
  lb t3, 0x0001 (t1) // Load second byte of D1 value from array
  or t2, t2, t3 // Combine D1 bytes
  beq t2, r0, Skip00 // Skip if no more values
  nop
  lb t4, 0x0002 (t1) // Load 80 value from array
  lh t5, 0x9C30 (t0) // Check buttons
  bne t5, t2, ArrayLoop // Check if D1 value matches current buttons, loop back if it doesn't
  addiu t1, t1, 0x0003 // Increment loop
  sb t4, 0x9ED9 (t0) // Store the level byte to 0x80339ED9
Skip00:

// Level Select Array
origin 0x39ECC // RAM 0x8027EECC
dl 0x080809
dl 0x080118
dl 0x08040C
dl 0x080205
dl 0x88001D
dl 0x48001C
dl 0x010804
dl 0x010107
dl 0x010416
dl 0x010208
dl 0x810012
dl 0x410014
dl 0x040817
dl 0x04010A
dl 0x04040B
dl 0x040224
dl 0x84001F
dl 0x44001B
dl 0x02080D
dl 0x02010E
dl 0x02040F
dl 0x020211
dl 0x820013
dl 0x420015
dw 0x0000
