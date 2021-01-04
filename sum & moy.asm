.data
# declaration d'un tableau stocke en memoire, qu'on peut editer a la main sous Mars pour tester les fonctions 
tab:	.word 10:21 # 21 = nombre de cases
size:	.word 80 # 80=4x20, nombre d'octets entre la premiere et la derniere case du tableau
	
.text
	la $a0,tab
	la $t0,size
	lw $t1,0($t0)
	add $a1,$a0,$t1 # $a0 contient l'adresse de la premiere case, $a1 l'adresse de la derniere case
# appel fonction
	jal moy
	add $a0,$v0,$zero # on recopie le resultat dans $a0 pour l'affichage
	jal affiche
	li $v0,10
	syscall # exit
	
# debut fonction sum
sum:	lui $v0,0 # somme initialisee a zero
	add $t0,$a0,$zero
boucle:	lw $t1,0($t0)
	add $v0,$v0,$t1
	addi $t0,$t0,4
	bge $a1,$t0,boucle # on s'arrete si on a depasse la derniere case
	jr $ra
# fin fonction sum
	
# debut fonction moy
moy:	sub $t0,$a1,$a0
	div $s1,$t0,4
	addi $s1,$s1,1 # calcul nombre de cases
	# sauvegarde registres
	sw $ra,0($sp)
	sw $s1,-4($sp)
	addi $sp,$sp,-8
	# appel
	jal sum
	# restauration registres
	lw $s1,4($sp)
	lw $ra,8($sp)
	addi $sp,$sp,8
	#  calcul moyenne
	div $v0,$v0,$s1
	jr $ra
# fin fonction moy
affiche:li $v0,1
	syscall
	jr $ra
