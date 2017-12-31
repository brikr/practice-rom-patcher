// Centisecond
origin 0x9DAB8
addiu at, r0, 0x0A
origin 0x9DAF0
mult t9, at
mflo t1
addiu at, r0, 0x03
div t1, at
mflo t2
sh t2, 0x24 (sp)
origin 0x9DB50
addiu a2, a2, 0x71D4
