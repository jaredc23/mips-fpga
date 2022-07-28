addi $0, $0, 5 //Set the two numbers to 5 and 5
addi $1, $1, 5
addi $2, $2, 0 //Set the $2 register to 0

sra $3, $0, 7 
andi $3, $3, 0x1 
beq $2, $3, positive //Check if number in $0 positive and branch

clr $3
inv $0, $0
addi $0, $0, 1 //$0 register is now positive since it will be used as the counter


beq $2, $0, flipsign //If the sign was flipped, the answer's sign will also need to be flipped
negloop:
add $3, $3, $1
addi $2, $2, 1
bne $2, $0, negloop

flipsign:
inv $3, $3
addi $3, $3, 1 //Change sign of answer
beq $0, $0, done


positive:
clr $3
beq $2, $0, done
posloop:
add $3, $3, $1
addi $2, $2, 1
bne $2, $0, posloop



done: