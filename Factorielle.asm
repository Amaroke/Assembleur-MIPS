.text
	li $a0,5
	jal fact
	add $a0,$v0,$zero
	jal print
	li $v0,10
	syscall
fact:	# $a0 contient n, $v0 contient le resultat recursif
	beq $a0,$zero,ret1
	# sauvegarde des registres
	sw $ra,0($sp)
	sw $a0,-4($sp)
	addi $sp,$sp,-8
	# preparation parametre appel
	addi $a0,$a0,-1  # n-1
	# appel
	jal fact
	# restauration registres
	lw $a0,4($sp)
	lw $ra,8($sp)
	addi $sp,$sp,8
	# calcul principal
	mul $v0,$v0,$a0
	j ret
ret1:	li $v0,1
ret:	jr $ra
# fin fonction fact
print:	li $v0,1
	syscall
	jr $ra
