.data
tab1:.word   12 : 10
var1: .word  0
.text
	la $a0, tab1		# Adresse du début du tableau
	la $a1, var1		# Adresse après le tableau
	addi $a1, $a1, -4	# Adresse de la dernière case du tableau
	sub $t2, $a1, $a0
	addi $t2, $t2, 4
	div $t2, $t2, 4
	move $t0, $a0		# Copie de $a0

main:	
	jal sum
	jal moy	
	li $v0, 10		# On met $v0 à 10
	syscall		# Fin du programme

sum:
	lw $t1, 0($t0)		# Chargement de la valeur de $t0
	add $v0, $v0, $t1	# Ajout de $t1 à la somme $v0
	addi $t0, $t0, 4	# On incrémente $t0
	ble $t0, $a1, sum	# Tant que $a1 <= $t0 on relance la boucle sum
	jr $ra

moy :
	jal sum
	div $v0, $v0, $t2
