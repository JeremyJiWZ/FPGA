.text                           # code segment
main:
 addi $2, $0, 0x00f0
 lui $3, 0xd000 # cram space: d0000000
 lui $4, 0xd000 # i/o space: a0000000 - bfffffff
read_kbd:
 lw $5, 0($4) # read kbd: {0,ready,byte}
 andi $6, $5, 0x100 # check if ready (i/o polling)
 beq $6, $0, read_kbd # if no key pressed, wait
 andi $6, $5, 0xff # ready, get data
 beq $6, $2, read2 # if not F0, again
 j read_kbd
read2:
 lw $5, 0($4) # read kbd: {0,ready,byte}
 andi $6, $5, 0x100 # check if ready (i/o polling)
 beq $6, $0, read2 # if no key pressed, wait
 andi $6, $5, 0xff # ready, get data
 addi $1, $0, 0x1c #a
 beq $6, $1, a
 addi $1, $0, 0x32 #b
 beq $6, $1, b
 addi $1, $0, 0x21 #c
 beq $6, $1, c
 addi $1, $0, 0x23 #d
 beq $6, $1, d
 addi $1, $0, 0x24 #e
 beq $6, $1, e
 addi $1, $0, 0x2b #f
 beq $6, $1, f
 addi $1, $0, 0x34 #g
 beq $6, $1, g
 addi $1, $0, 0x33 #h
 beq $6, $1, h
 addi $1, $0, 0x43 #i
 beq $6, $1, i
 addi $1, $0, 0x3b #j
 beq $6, $1, j
 addi $1, $0, 0x42 #k
 beq $6, $1, k
 addi $1, $0, 0x4b #l
 beq $6, $1, l
 addi $1, $0, 0x3a #m
 beq $6, $1, m
 addi $1, $0, 0x31 #n
 beq $6, $1, n
 addi $1, $0, 0x44 #o
 beq $6, $1, o
 addi $1, $0, 0x4d #p
 beq $6, $1, p
 addi $1, $0, 0x15 #q
 beq $6, $1, q
 addi $1, $0, 0x2d #r
 beq $6, $1, r
 addi $1, $0, 0x1b #s
 beq $6, $1, s
 addi $1, $0, 0x2c #t
 beq $6, $1, t
 addi $1, $0, 0x3c #u
 beq $6, $1, u
 addi $1, $0, 0x2a #v
 beq $6, $1, v
 addi $1, $0, 0x1d #w
 beq $6, $1, w
 addi $1, $0, 0x22 #x
 beq $6, $1, x
 addi $1, $0, 0x35 #y
 beq $6, $1, y
 addi $1, $0, 0x1a #z
 beq $6, $1, z
 addi $1, $0, 0x16 #1
 beq $6, $1, n1
 addi $1, $0, 0x1e #2
 beq $6, $1, n2
 addi $1, $0, 0x26 #3
 beq $6, $1, n3
 addi $1, $0, 0x25 #4
 beq $6, $1, n4
 addi $1, $0, 0x2e #5
 beq $6, $1, n5
 addi $1, $0, 0x36 #6
 beq $6, $1, n6
 addi $1, $0, 0x3d #7
 beq $6, $1, n7
 addi $1, $0, 0x3e #8
 beq $6, $1, n8
 addi $1, $0, 0x46 #9
 beq $6, $1, n9
 addi $1, $0, 0x45 #0
 beq $6, $1, n0
 addi $1, $0, 0x29 #space
 beq $6, $1, space
 addi $1, $0, 0x5a #enter
 beq $6, $1, enter
 addi $1, $0, 0x66 #backspace
 beq $6, $1, back_space
 addi $1, $0, 0x0d
 beq $6, $1, toGraph #tab
 addi $1, $0, 0x76
 beq $6, $1, clr #clear screen
 j a
a:
 addi $5, $0, 0x41
 jal display
 j read_kbd
b:
 addi $5, $0, 0x42
 jal display
 j read_kbd
c:
 addi $5, $0, 0x43
 jal display
 j read_kbd
d:
 addi $5, $0, 0x44
 jal display
 j read_kbd
e:
 addi $5, $0, 0x45
 jal display
 j read_kbd
f:
 addi $5, $0, 0x46
 jal display
 j read_kbd
g:
 addi $5, $0, 0x47
 jal display
 j read_kbd
h:
 addi $5, $0, 0x48
 jal display
 j read_kbd
i:
 addi $5, $0, 0x49
 jal display
 j read_kbd
j:
 addi $5, $0, 0x4a
 jal display
 j read_kbd
k:
 addi $5, $0, 0x4b
 jal display
 j read_kbd
l:
 addi $5, $0, 0x4c
 jal display
 j read_kbd
m:
 addi $5, $0, 0x4d
 jal display
 j read_kbd
n:
 addi $5, $0, 0x4e
 jal display
 j read_kbd
o:
 addi $5, $0, 0x4f
 jal display
 j read_kbd
p:
 addi $5, $0, 0x50
 jal display
 j read_kbd
q:
 addi $5, $0, 0x51
 jal display
 j read_kbd
r:
 addi $5, $0, 0x52
 jal display
 j read_kbd
s:
 addi $5, $0, 0x53
 jal display
 j read_kbd
t:
 addi $5, $0, 0x54
 jal display
 j read_kbd
u:
 addi $5, $0, 0x55
 jal display
 j read_kbd
v:
 addi $5, $0, 0x56
 jal display
 j read_kbd
w:
 addi $5, $0, 0x57
 jal display
 j read_kbd
x:
 addi $5, $0, 0x58
 jal display
 j read_kbd
y:
 addi $5, $0, 0x59
 jal display
 j read_kbd
z:
 addi $5, $0, 0x5a
 jal display
 j read_kbd
n0:
 addi $5, $0, 0x30
 jal display
 j read_kbd 
n1:
 addi $5, $0, 0x31
 jal display
 j read_kbd
n2:
 addi $5, $0, 0x32
 jal display
 j read_kbd 
n3:
 addi $5, $0, 0x33
 jal display
 j read_kbd 
n4:
 addi $5, $0, 0x34
 jal display
 j read_kbd 
n5:
 addi $5, $0, 0x35
 jal display
 j read_kbd 
n6:
 addi $5, $0, 0x36
 jal display
 j read_kbd 
n7:
 addi $5, $0, 0x37
 jal display
 j read_kbd 
n8:
 addi $5, $0, 0x38
 jal display
 j read_kbd 
n9:
 addi $5, $0, 0x39
 jal display
 j read_kbd 
space:
 add $5, $0, $0
 jal display
 j read_kbd
enter:
 add $5, $0, $0
 jal display
 lui $7, 0xd000
 sub $7, $3, $7
 addi $8, $zero, 320
 Loop2:
 sub $7, $7, $8
 beq $7, $zero, read_kbd
 slt $9, $7, $zero # $9 = $7<0?1:0
 bne $9, $zero, enter
 j Loop2
back_space:
 sw $0, 0($3) #clear this cur
 addi $3, $3, -4
 addi $5, $zero, 0x5f
 sw $5, 0($3)
 j read_kbd

clr:
 sw $0, 0($3)
 beq $3, $zero, main
 addi $3, $3, -4
 slt $6, $3, $zero
 bne $6, $0, main
 j clr

 
display:
 sw $5, 0($3) # to display
 addi $3, $3, 4
 addi $5, $zero, 0x5f #cur
 sw $5, 0($3) #display cur
 jr $ra


tank_war:
lui $v0, 0xc000
lui $v1, 0xd000
lui $s0, 0xc000 #tank1¡¯s initial status
lui $s1, 0x8006
addi $s1, $s1, 0x7E3F #tank2¡¯s initial status
lui $s2, 0x0002
addi $s2, $s2, 0x101c #bullet1¡¯s initial status
lui $s3, 0x0006
addi $s4, $zero, 0x0e23
add $s4, $s4, $s4
add $s4, $s4, $s4
add $s4, $s4, $s4
add $s3, $s4, $s4 #bullet2¡¯s initial status
lui $t9, 0xfff0
addi $t9, $t9, 0x03ff #t9 get y
j PS2

PS2: #read keyboard
lw $t0, 0($v1)
andi $t1, $t0, 0x100 #get ps2_ready
beq $t1, $zero, PS2
andi $t1, $t0, 0xff 
addi $t2, $zero, 0x76 #esc
beq $t1, $t2, toText #text mode
addi $t2, $zero, 0x1d 
beq $t1, $t2, TANK1UP #t1=t2 move up
addi $t2, $zero, 0x1b
beq $t1, $t2, TANK1DOWN #move down
addi $t2, $zero, 0x1c
beq $t1, $t2, TANK1LEFT #move left
addi $t2, $zero, 0x23
beq $t1, $t2, TANK1RIGHT #move right
addi $t2, $zero, 0x43
beq $t1, $t2, TANK2UP #key i
addi $t2, $zero, 0x3b
beq $t1, $t2, TANK2LEFT #key j 
addi $t2, $zero, 0x42
beq $t1, $t2, TANK2DOWN #key k
addi $t2, $zero, 0x4b
beq $t1, $t2, TANK2RIGHT #key l
j PS2

TANK1UP: #move tank1 up
srl $t3, $s0, 10 #t3 = y of tank1
andi $t3, $t3, 0x3ff #$t3 for y coordinate of tank1
addi $t4, $t3, -16 #$t4= t3-16
slt $t5, $t4, $zero #t5= t4<0?1:0
bne $t5, $zero, PS2 #upmost
add $t4, $t4, $t4 # t4 =y<<1
add $t4, $t4, $t4 # t4 =y<<2
add $t4, $t4, $t4 # <<3
add $t4, $t4, $t4 # <<4
add $t4, $t4, $t4 # <<5
add $t4, $t4, $t4 # <<6
add $t4, $t4, $t4 # <<7
add $t4, $t4, $t4 # <<8
add $t4, $t4, $t4 # <<9
add $t4, $t4, $t4 # <<10
and $s0, $t9, $s0 #reset y
or $s0, $s0, $t4 #set y
add $s0, $s0, $s0 #set dir
add $s0, $s0, $s0 #set dir
srl $s0, $s0, 2 #set dir
sw $s0, 0($v0) #display new tank 
sw $s1, 4($v0)
j PS2

TANK1DOWN: #move tank1 down
srl $t3, $s0, 10
andi $t3, $t3, 0x3ff #t3 = vy(tank1)
addi $t4, $t3, 16 #t4= t3+16
slti $t5, $t4, 416 #t5= t4<416?1:0
beq $t5, $zero, PS2 #downmost
add $t4, $t4, $t4 # t4 =y<<1
add $t4, $t4, $t4 # t4 =y<<2
add $t4, $t4, $t4 # <<3
add $t4, $t4, $t4 # <<4
add $t4, $t4, $t4 # <<5
add $t4, $t4, $t4 # <<6
add $t4, $t4, $t4 # <<7
add $t4, $t4, $t4 # <<8
add $t4, $t4, $t4 # <<9
add $t4, $t4, $t4 # <<10
and $s0, $s0, $t9 #reset y
or $s0, $s0, $t4 #set y
add $s0, $s0, $s0 #set dir
lui $t0, 0x8000 #set dir
or $s0, $s0, $t0 #set dir
srl $s0, $s0, 1 #set dir
sw $s0, 0($v0)
sw $s1, 4($v0)
j PS2

TANK1LEFT: #move tank1 left
andi $t3, $s0, 0x3ff #t3 = vx(tank1)
addi $t4, $t3, -16 #t4=t3-16
slt $t5, $t4, $zero #t5= t4<0?1:0
bne $t5, $zero, PS2 #leftmost
andi $s0, $s0, 0xfc00 #sety
or $s0, $s0, $t4  #set x
add $s0, $s0, $s0 #set dir
add $s0, $s0, $s0 #set dir
srl $s0, $s0, 2 #set dir
lui $t0, 0x8000 #set dir
add $s0, $s0, $t0 #set dir
sw $s0, 0($v0)
sw $s1, 4($v0)
j PS2

TANK1RIGHT: #move tank1 right
andi $t3, $s0, 0x3ff #t3 = vx(tank1)
addi $t4, $t3, 16 #t4= t3+16
slti $t5, $t4, 576 #t5=t4<576?1:0
beq $t5, $zero, PS2 #rightmost
andi $s0, $s0, 0xfc00 #set y
or $s0, $s0, $t4 #set x
add $s0, $s0, $s0 #set dir
add $s0, $s0, $s0 #set dir
srl $s0, $s0, 2 #set dir
lui $t0, 0xc000 #set dir
or $s0, $s0, $t0 #set dir
sw $s0, 0($v0)
sw $s1, 4($v0)
j PS2

TANK2UP: #move tank2 up
srl $t3, $s1, 10
andi $t3, $t3, 0x3ff #$t3 for y coordinate of tank2
addi $t4, $t3, -16 #$t4= t3-16
slt $t5, $t4, $zero #t5= t4<0?1:0
bne $t5, $zero, PS2 #upmost
add $t4, $t4, $t4 # t4 =y<<1
add $t4, $t4, $t4 # t4 =y<<2
add $t4, $t4, $t4 # <<3
add $t4, $t4, $t4 # <<4
add $t4, $t4, $t4 # <<5
add $t4, $t4, $t4 # <<6
add $t4, $t4, $t4 # <<7
add $t4, $t4, $t4 # <<8
add $t4, $t4, $t4 # <<9
add $t4, $t4, $t4 # <<10
and $s1, $t9, $s1 #reset y
or $s1, $s1, $t4 #set y
add $s1, $s1, $s1 #set dir
add $s1, $s1, $s1 #set dir
srl $s1, $s1, 2 #set dir
sw $s1, 4($v0) #display new tank 
j PS2

TANK2DOWN: #move tank2 down
srl $t3, $s1, 10
andi $t3, $t3, 0x3ff #t3 = vy(tank2)
addi $t4, $t3, 16 #t4= t3+16
slti $t5, $t4, 416 #t5= t4<416?1:0
beq $t5, $zero, PS2 #downmost
add $t4, $t4, $t4 # t4 =y<<1
add $t4, $t4, $t4 # t4 =y<<2
add $t4, $t4, $t4 # <<3
add $t4, $t4, $t4 # <<4
add $t4, $t4, $t4 # <<5
add $t4, $t4, $t4 # <<6
add $t4, $t4, $t4 # <<7
add $t4, $t4, $t4 # <<8
add $t4, $t4, $t4 # <<9
add $t4, $t4, $t4 # <<10
and $s1, $s1, $t9 #reset y
or $s1, $s1, $t4 #set y
add $s1, $s1, $s1 #set dir
lui $t0, 0x8000 #set dir
or $s1, $s1, $t0 #set dir
srl $s1, $s1, 1 #set dir
sw $s1, 4($v0)
j PS2

TANK2LEFT: #move tank2 left
andi $t3, $s1, 0x3ff #t3 = vx(tank2)
addi $t4, $t3, -16 #t4=t3-16
slt $t5, $t4, $zero #t5= t4<0?1:0
bne $t5, $zero, PS2 #leftmost
andi $s1, $s1, 0xfc00
or $s1, $s1, $t4 #set x
add $s1, $s1, $s1 #set dir
add $s1, $s1, $s1 #set dir
srl $s1, $s1, 2 #set dir
lui $t0, 0x8000 #set dir
add $s1, $s1, $t0 #set dir
sw $s1, 4($v0)
j PS2

TANK2RIGHT: #move tank2 right
andi $t3, $s1, 0x3ff #t3 = vx(tank1)
addi $t4, $t3, 16 #t4= t3+16
slti $t5, $t4, 576 #t5=t4<576?1:0
beq $t5, $zero, PS2 #rightmost
andi $s1, $s1, 0xfc00
or $s1, $s1, $t4
add $s1, $s1, $s1 #set dir
add $s1, $s1, $s1 #set dir
srl $s1, $s1, 2 #set dir
lui $t0, 0xc000 #set dir
or $s1, $s1, $t0 #set dir
sw $s1, 4($v0)
j PS2

toText:
lui $a0, 0xa000
sw $0, 0($a0) #set textmode
j main

toGraph:
lui $a0, 0xa000
addi $a1, $zero, 1
sw $a1, 0($a0) #set graph mode
j tank_war

.end