lui $v0, 0xc000
lui $v1, 0xd000
lui $s0, 0xc000 #tank1’s initial status
lui $s1, 0x8006
addi $s1, $s1, 0x7E3F #tank2’s initial status
lui $s2, 0x6006
addi $s2, $s2, 0x6016 #bullet1’s initial status
lui $s3, 0x1606
addi $s4, $zero, 0x6f18
add $s4, $s4, $s4
add $s3, $s3, $s4 #bullet2’s initial status
lui $t9, 0xfff0
addi $t9, $t9, 0x03ff #t9 get y
j PS2

PS2:
jal BULLET1_RUN
jal BULLET1_RUN
lw $t0, 0($v1)
andi $t1, $t0, 0x100 #get ps2_ready
beq $t1, $zero, PS2
andi $t1, $t0, 0xff 
addi $t2, $zero, 0x2b
beq $t1, $t2, BULLET1_SHOT
addi $t2, $zero, 0x33
beq $t1, $t2, BULLET2_SHOT
j PS2 



BULLET1_RUN:
srl $t1, $s2, 31
beq $t1, $zero, EXIT #Not shot yet
add $t2, $s2, $s2 #<<1
srl $t2, $t2, 30 #get dir
addi $t3, $zero, 0 #UP
addi $t4, $zero, 1 #DOWN
addi $t5, $zero, 2 #LEFT
addi $t6, $zero, 3 #RIGHT
beq $t2, $t3, BULLET1_UP
beq $t2, $t4, BULLET1_DOWN
beq $t2, $t5, BULLET1_LEFT
beq $t2, $t6, BULLET1_RIGHT
jr $ra

BULLET1_LEFT:
andi $t0, $s2, 0x03ff
addi $t1, $t0, -16 #t1= x-16
slt $t2, $t1, $zero #t2= t1<0?1:0
bne $t2, $zero, BULLET1_BACK #touch wall
andi $s2, $s2, 0xfc00 #go on
or $s2, $s2, $t1
sw $s2, 8($v0)
jr $ra

BULLET1_RIGHT:
andi $t0, $s2, 0x03ff #get x
addi $t1, $t0, 16 #t1= x+16
slti $t2, $t1, 576 #t2= t1<576?1:0
beq $t2, $zero, BULLET1_BACK #touch wall
andi $s2, $s2, 0xfc00 #go on
or $s2, $s2, $t1
sw $s2, 8($v0)
jr $ra


BULLET1_UP:
srl $t0, $s2, 10
andi $t0, $t0, 0x03ff #get y
addi $t1, $t0, -16 #t1= y-16
slt $t2, $t1, $zero #t2= y<0?1:0
bne $t2, $zero, BULLET1_BACK
add $t1, $t1, $t1 #<<1
add $t1, $t1, $t1 #<<2
add $t1, $t1, $t1 #<<3
add $t1, $t1, $t1 #<<4
add $t1, $t1, $t1 #<<5
add $t1, $t1, $t1 #<<6
add $t1, $t1, $t1 #<<7
add $t1, $t1, $t1 #<<8
add $t1, $t1, $t1 #<<9
add $t1, $t1, $t1 #<<10
and $s2, $s2, $t9 #reset y
or $s2, $s2, $t1
sw $s2, 8($v0)
jr $ra


BULLET1_DOWN:
srl $t0, $s2, 10
andi $t0, $t0, 0x03ff #get y
addi $t1, $t0, 16 #t1= y+16
slti $t2, $t1, 416 #t2= y<416?1:0
beq $t2, $zero, BULLET1_BACK
add $t1, $t1, $t1 #<<1
add $t1, $t1, $t1 #<<2
add $t1, $t1, $t1 #<<3
add $t1, $t1, $t1 #<<4
add $t1, $t1, $t1 #<<5
add $t1, $t1, $t1 #<<6
add $t1, $t1, $t1 #<<7
add $t1, $t1, $t1 #<<8
add $t1, $t1, $t1 #<<9
add $t1, $t1, $t1 #<<10
and $s2, $s2, $t9 #reset y
or $s2, $s2, $t1
sw $s2, 8($v0)
jr $ra



EXIT:
jr $ra

BULLET1_BACK:
add $s2, $zero, $zero #reset
andi $t3, $s0, 0x03ff	#t3 for x
srl $t4, $s0, 10
andi $t4, $t4, 0x03ff 	#t4 for y 
srl $t5, $s0, 30 		#t5 for dir
lui $t1, 0xc000
and $t1, $t1, $s0 #shifted dir 
srl $t1, $t1, 1
addi $t6, $zero, 0 #UP
addi $t7, $zero, 1 #DOWN
addi $t8, $zero, 2 #LEFT
addi $t0, $zero, 3 #RIGHT
beq $t5, $t6, BULLET1_BACK_UP
beq $t5, $t7, BULLET1_BACK_DOWN
beq $t5, $t8, BULLET1_BACK_LEFT
beq $t5, $t0, BULLET1_BACK_RIGHT
BULLET1_BACK_UP:
addi $t3, $t3, 24
addi $t4, $t4, -16
j DATA_M

BULLET1_BACK_DOWN:
addi $t3, $t3, 24
addi $t4, $t4, 64
j DATA_M

BULLET1_BACK_LEFT:
addi $t3, $t3, -16
addi $t4, $t4, 24
j DATA_M

BULLET1_BACK_RIGHT:
addi $t3, $t3, 64
addi $t4, $t4, 24
j DATA_M

DATA_M:
add $t4, $t4, $t4 #<<1
add $t4, $t4, $t4 #<<2
add $t4, $t4, $t4 #<<3
add $t4, $t4, $t4 #<<4
add $t4, $t4, $t4 #<<5
add $t4, $t4, $t4 #<<6
add $t4, $t4, $t4 #<<7
add $t4, $t4, $t4 #<<8
add $t4, $t4, $t4 #<<9
add $t4, $t4, $t4 #<<10
or $s2, $s2, $t3
or $s2, $s2, $t4
or $s2, $s2, $t1
sw $s2, 8($v0)
jr $ra

BULLET2_RUN:
srl $t1, $s3, 31
beq $t1, $zero, EXIT #Not shot yet
add $t2, $s3, $s3 #<<1
srl $t2, $t2, 30 #get dir
addi $t3, $zero, 0 #UP
addi $t4, $zero, 1 #DOWN
addi $t5, $zero, 2 #LEFT
addi $t6, $zero, 3 #RIGHT
beq $t2, $t3, BULLET2_UP
beq $t2, $t4, BULLET2_DOWN
beq $t2, $t5, BULLET2_LEFT
beq $t2, $t6, BULLET2_RIGHT
jr $ra

BULLET2_LEFT:
andi $t0, $s3, 0x03ff
addi $t1, $t0, -40 #t1= x-40
slt $t2, $t1, $zero #t2= t1<0?1:0
bne $t2, $zero, BULLET2_BACK #touch wall
andi $s3, $s3, 0xfc00 #go on
or $s3, $s3, $t1
sw $s3, 12($v0) 
sw $s0, 0($v0) 
sw $s1, 4($v0) 
sw $s2, 8($v0)
jr $ra

BULLET2_RIGHT:
andi $t0, $s3, 0x03ff #get x
addi $t1, $t0, 40 #t1= x+40
slti $t2, $t1, 576 #t2= t1<576?1:0
beq $t2, $zero, BULLET2_BACK #touch wall
andi $s3, $s3, 0xfc00 #go on
or $s3, $s3, $t1
sw $s3, 12($v0) 
sw $s0, 0($v0) 
sw $s1, 4($v0) 
sw $s2, 8($v0)
jr $ra


BULLET2_UP:
srl $t0, $s3, 10
andi $t0, $t0, 0x03ff #get y
addi $t1, $t0, -40 #t1= y-40
slt $t2, $t1, $zero #t2= y<0?1:0
bne $t2, $zero, BULLET2_BACK
add $t1, $t1, $t1 #<<1
add $t1, $t1, $t1 #<<2
add $t1, $t1, $t1 #<<3
add $t1, $t1, $t1 #<<4
add $t1, $t1, $t1 #<<5
add $t1, $t1, $t1 #<<6
add $t1, $t1, $t1 #<<7
add $t1, $t1, $t1 #<<8
add $t1, $t1, $t1 #<<9
add $t1, $t1, $t1 #<<10
and $s3, $s3, $t9 #reset y
or $s3, $s3, $t1
sw $s3, 12($v0) 
sw $s0, 0($v0) 
sw $s1, 4($v0) 
sw $s2, 8($v0)
jr $ra


BULLET2_DOWN:
srl $t0, $s3, 10
andi $t0, $t0, 0x03ff #get y
addi $t1, $t0, 40 #t1= y+40
slti $t2, $t1, 416 #t2= y<416?1:0
beq $t2, $zero, BULLET2_BACK
add $t1, $t1, $t1 #<<1
add $t1, $t1, $t1 #<<2
add $t1, $t1, $t1 #<<3
add $t1, $t1, $t1 #<<4
add $t1, $t1, $t1 #<<5
add $t1, $t1, $t1 #<<6
add $t1, $t1, $t1 #<<7
add $t1, $t1, $t1 #<<8
add $t1, $t1, $t1 #<<9
add $t1, $t1, $t1 #<<10
and $s3, $s3, $t9 #reset y
or $s3, $s3, $t1
sw $s3, 12($v0) 
sw $s0, 0($v0) 
sw $s1, 4($v0) 
sw $s2, 8($v0)
jr $ra


BULLET2_BACK:
add $s3, $zero, $zero #reset
andi $t3, $s0, 0x03ff	#t3 for x
srl $t4, $s0, 10
andi $t4, $t4, 0x03ff 	#t4 for y 
srl $t5, $s0, 30 		#t5 for dir
lui $t1, 0xc000
and $t1, $t1, $s1
srl $t1, $t1, 1
addi $t6, $zero, 0 #UP
addi $t7, $zero, 1 #DOWN
addi $t8, $zero, 2 #LEFT
addi $t0, $zero, 3 #RIGHT
beq $t5, $t6, BULLET2_BACK_UP
beq $t5, $t7, BULLET2_BACK_DOWN
beq $t5, $t8, BULLET2_BACK_LEFT
beq $t5, $t0, BULLET2_BACK_RIGHT
BULLET2_BACK_UP:
addi $t3, $t3, 24
addi $t4, $t4, -16
j DATA_M2

BULLET2_BACK_DOWN:
addi $t3, $t3, 24
addi $t4, $t4, 64
j DATA_M2

BULLET2_BACK_LEFT:
addi $t3, $t3, -16
addi $t4, $t4, 24
j DATA_M2

BULLET2_BACK_RIGHT:
addi $t3, $t3, 64
addi $t4, $t4, 24
j DATA_M2

DATA_M2:
add $t4, $t4, $t4 #<<1
add $t4, $t4, $t4 #<<2
add $t4, $t4, $t4 #<<3
add $t4, $t4, $t4 #<<4
add $t4, $t4, $t4 #<<5
add $t4, $t4, $t4 #<<6
add $t4, $t4, $t4 #<<7
add $t4, $t4, $t4 #<<8
add $t4, $t4, $t4 #<<9
add $t4, $t4, $t4 #<<10
or $s3, $s3, $t3
or $s3, $s3, $t4
or $s3, $s3, $t1
sw $s3, 12($v0) 
sw $s0, 0($v0) 
sw $s1, 4($v0) 
sw $s2, 8($v0)
jr $ra

BULLET1_SHOT:
srl $t0, $s2, 31
bne $t0, $zero, PS2 #already shot
jal BULLET1_BACK
lui $t1, 0x8000
or $s2, $t1, $s2
sw $s2, 8($v0) 
sw $s0, 0($v0) 
sw $s1, 4($v0) 
sw $s3, 12($v0)
j PS2


BULLET2_SHOT:
srl $t0, $s3, 31
bne $t0, $zero, PS2 #already shot
jal BULLET2_BACK
lui $t1, 0x8000
or $s3, $t1, $s2
sw $s2, 8($v0) 
sw $s0, 0($v0) 
sw $s1, 4($v0) 
sw $s3, 12($v0)
j PS2