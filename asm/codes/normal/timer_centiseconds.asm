// Centisecond

origin 0x09DAB8
base 0x802E2AB8
addiu at, r0, 0x0A

origin 0x09DAF0
base 0x802E2AF0
mult t9, at
mflo t1
addiu at, r0, 0x03
div t1, at
mflo t2
sh t2, 0x24 (sp)

origin 0x09DB50
base 0x802E2B50
addiu a2, a2, 0x71D4

// Move Timer Slightly Left
// 
// origin 0x09DB12
// base 0x802E2B12
// dh 0x009E // Time Text X
// 
// origin 0x09DB26
// base 0x802E2B26
// dh 0x00D9 // Minutes X
// 
// origin 0x09DB3E
// base 0x802E2B3E
// dh 0x00ED // Seconds X
// 
// origin 0x09DB56
// base 0x802E2B56
// dh 0x010F // Tenths X
// 
// origin 0x09DB9E
// base 0x802E2B9E
// dh 0x00E3 // ' Separator X
// 
// origin 0x09DBB2
// base 0x802E2BB2
// dh 0x0106 // " Separator X
// 