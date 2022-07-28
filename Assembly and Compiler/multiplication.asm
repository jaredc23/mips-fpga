addi $0, $0, 0x5
addi $1, $1, 0x5
addi $2, $2, 0x0
sra $3, $0, 0x7
andi $3, $3, 0x1
beq $2, $3, positive
clr $3
inv $0, $0
addi $0, $0, 0x1
beq $2, $0, flipsign
negloop:
add $3, $3, $1
addi $2, $2, 0x1
bne $2, $0, negloop
flipsign:
inv $3, $3
addi $3, $3, 0x1
beq $0, $0, done
positive:
clr $3
beq $2, $0, done
posloop:
add $3, $3, $1
addi $2, $2, 0x1
bne $2, $0, posloop
done: