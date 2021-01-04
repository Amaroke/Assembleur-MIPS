# Declaration des raccourcis à utiliser dans le programme
.data
enter: .asciiz "\n" 
promptR: .asciiz "\nResultat du factorielle : "
promptB : .asciiz "\nResultat du binomial : "
promptSaisir: .asciiz "Entrer un nombre : "
promptSaisir2: .asciiz "Entrer un deuxieme nombre : "
promptVerif : .asciiz "\nVotre nombre est le : "
promptF : .asciiz "\nReturn : "

# Main
.text
main:
      # Saisit utilisateur
        #Affichage d'un message								
        la   $a0, promptSaisir								
        li   $v0, 4									
        syscall										
        # Lecture de la valeur saisit par l'utilisateur					
        li   $v0, 5									
        syscall										
        # Recupere la valeur saisit par l'utilisateur dans un registre			
        move $t0, $v0									
      
      #Affichage d'un message
        la   $a0, promptSaisir2								
        li   $v0, 4									
        syscall										
        # Lecture de la valeur saisit par l'utilisateur					
        li   $v0, 5									
        syscall										
        # Recupere la valeur saisit par l'utilisateur dans un registre		
        move $t1, $v0									
      
      ##Saut a la ligne
      la $a0, enter									
      li $v0, 4										
      syscall										
	
      #Execute la fonction Binomial
        # Declaration des parametre pour la fonction Binomial				
        move $a0,$t0									
        move $a1,$t1									
        # Lancement de la fonction							
        jal Binomial									
      
      #Affichage du resultat
        # Affiche d'un message
        la $a0, promptB
        li $v0, 4
        syscall
      	# Affichage de la valeur du registre $s0
      	move $a0,$v1
      	li $v0, 1
      	syscall
      
      # Permet de finir le main
      li $v0,10
      syscall

factoriel:														
															
     #Ce que fait la fonction					
     	bgtz $a0, Recursion #si le parametre est superieur a 0								
     															
     	#Return														
     	li $v1, 1 # retourne 1												
     	jr $ra	# retourne au main											
     															
Recursion:														
     # Sauvegarde des differentes variables utiles $ra $s0, $a0 dans la pile						
     addi $sp, $sp, 8 # Taille reservé dans la pile pour stocker les variables						
     sw $ra, 0($sp) # Sauvegarde l'adresse de retour dans la pile							
     sw $a0, 4($sp) # Sauvegarde des parametres										
     															
     addi $a0, $a0, -1 # n-1												
     jal factoriel # appelle a la recursion										
     															
     # Restaure les différentes variables utiles $ra $s0, $a0 de la pile						
     lw $a0, 4($sp) # Recupere un parametre										
     lw $ra, 0($sp) # Recupere l'adresse de retour dans la pile								
     addi $sp, $sp, -8 # Remet la pile a la position ou elle etait avant d'entrer dans la fonction			
     														
     mul $v1, $v1, $a0													
															
     # Retourne a l'adresse juste apres l'appelle a la fonction	( ici a la recursion avant )			
     jr $ra														
     															
Binomial:														
															
     #Ce que fait la fonction					
        beq $a1, $a0, Fin #si $a1 == $a0 ( k == n )									
     	bgtz $a1, RecursionBino #si le premier parametre est superieur a 
     															
     	#Return														
Fin:													
     	li $v1, 1 # retourne 1												
     	jr $ra	# retourne au main										
     															
RecursionBino:														
     # Sauvegarde des differentes variables utiles dans la pile					
     addi $sp, $sp, 16 # Taille reservé dans la pile pour stocker les variables					
     sw $ra, 0($sp) # Sauvegarde l'adresse de retour dans la pile				
     sw $a0, 4($sp) # Sauvegarde des parametres									
     sw $a1, 8($sp) # Sauvegarde des parametres					 				
				
     															
     # C(n-1,k)								
     addi $a0, $a0, -1 # n-1										
     jal Binomial # appelle a la recursion								
     														
     move $t3,$v1 # tmp1 = C(n-1,k)																		
     														
     # Sauvegarde de tmp1									
     sw $t3, 12($sp) # Sauvegarde des parametres 														 				
     															
     # Recupere n-1 -----												
     lw $a0, 4($sp)													
     addi $a0, $a0, -1										
															
     # Recupere k-1 -----												
     lw $a1, 8($sp)													
     addi $a1, $a1, -1											
     
     #C(n-1,k-1)
     jal Binomial

     move $t4, $v1 # tmp2 = C(n-1,k-1)

     
     # Restaure tmp1
     lw $t3, 12($sp)																																																																																																																								#
     
     # C(n-1,k) + C(n-1,k-1)			
     add $v1, $t3, $t4
     # Restaure les différentes variables utiles $ra $s0, $a0 de la pile
     lw $a1, 8($sp) # Recupere un parametre
     lw $a0, 4($sp) # Recupere un parametre
     lw $ra, 0($sp) # Recupere l'adresse de retour dans la pile
     addi $sp, $sp, -16 # Remet la pile a la position ou elle etait avant d'entrer dans la fonction
     
     # Retourne a l'adresse juste apres l'appelle a la fonction	( ici a la recursion avant )
     jr $ra
