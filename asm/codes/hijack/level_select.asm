// Level Select

scope LevelSelect: {
  lui t0, 0x8034
  lui t1, 0x8028
  addiu t1, t1, 0xEECC // ROM 0x39ECC
  ArrayLoop:
    lb t2, 0x0000 (t1) // Load first byte of D1 value from array
    sll t2, t2, 0x8 // Shift first byte left
    lb t3, 0x0001 (t1) // Load second byte of D1 value from array
    or t2, t2, t3 // Combine D1 bytes
    beq t2, r0, End // Skip if no more values
    nop
    lb t4, 0x0002 (t1) // Load 80 value from array
    lh t5, 0x9C30 (t0) // Check buttons
    bne t5, t2, ArrayLoop // Check if D1 value matches current buttons, loop back if it doesn't
    addiu t1, t1, 0x0003 // Increment loop
    sb t4, 0x9ED9 (t0) // Store the level byte to 0x80339ED9
  End:
}
