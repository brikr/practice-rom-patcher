// Star-Grab Timer

origin 0x008AD0
base 0x8024DAD0
lb at, 0x00 (t5)
ori t6, r0, 0x7F
beq r0, at, 0x8024DADC

origin 0x008AE4
base 0x8024DAE4
sh t6, 0x00FA (t5)
