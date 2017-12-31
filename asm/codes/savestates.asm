origin 0x856E0
constant Buttons(0x80349C30)
constant MemoryStart(0x80339E00)
constant MemoryEnd(0x80360928)
constant MarioSlot(0x8036FDE8)
constant CamPointer(0x8033B860)

or v0, ra, r0
lui t0, 0x8033 // Temp register
lui t1, 0x8036 // Temp register
lui t2, 0x8042 // Temp register
lui t3, 0x8034 // Check buttons
lh t8, Buttons (t3) // Check buttons
Save:
  ori t7, r0, 0x1000 // Save button(s)
  and t9, t8, t7 // Save button check
  lui a0, 0x8040 // Memory destination start (Save) 80400000
  ori a1, t2, 0x6B28 // Memory destination end (Save) 80426B28
  beq t9, t7, Copy // Branch to memory copy
  ori a2, t0, MemoryStart // Memory source start (Save)
Load:
  ori t7, r0, 0x000F // Load button(s)
  and t9, t8, t7 // Load button check
  ori a0, t0, MemoryStart // Memory destination start (Load)
  ori a1, t1, MemoryEnd // Memory destination end (Load)
  bne t9, t7, Skip // Branch to end if neither button(s) pressed
  lui a2, 0x8040 // Memory source start (Load) 80400000
Check:
  lw t4, 0x5FE8 (t2) // Mario slot pointer in state 80425FE8
  lw t5, MarioSlot (t1) // Mario slot pointer
  bne t5, t4, Skip // Branch to end if Mario slots don't match
Camera:
  lw t6, CamPointer (t3)
  sb r0, 0x0030 (t6)
Copy:
  lw a3, $0000 (a2) // Memory copy
  sw a3, $0000 (a0)
  addiu a0, a0, 0x0004
  bne a1, a0, Copy
  addiu a2, a2, 0x0004
Skip:
  jr v0
  nop
  