// Timer

origin 0x004658
base 0x80249658
sb k1, 0x9EEE (at) // 81249658 A03B

origin 0x004660
base 0x80249660
nop // 81249660 2400

// Slide Timer Fix

origin 0x00B55C
base 0x8025055C
lh t6, 0x9EFC (t6) // 8125055E 9EFC
slti t7, t6, 0x0006 // 81250560 29CF & 81250562 0006

// Prevent Timer Reset at the Start of Koopa Races and Slide

origin 0x00460C
base 0x8024960C
nop // 8124960C 2400

// Prevent Timer Stop at the End of Koopa Races and Slide

origin 0x004630
base 0x80249630
nop // 81249630 2400

// Remove Time Text

origin 0x0F21C8
base 0x803371C8
dw 0x00000000
