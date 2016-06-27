# w == 119; W == 87
# a == 97; A == 65
# s == 115; S == 83
# d == 100; D == 68

###############################################	78778874
#  Programa de exemplo para bitmap display    #	99999999
#  ISC Jun 2016				      #	70707070 VERDE-BONITO
#  Marcus Vinicius			      #	12C00	<- Para preencher a tela toda
###############################################	77777777 <- amarelo
.data 
FILE: .asciiz "snake.bin"
jogardenovo: .asciiz "Pressione '1' para jogar novamente,'2' para sair do game ou 3 para alterar a dificuldade e iniciar um novo jogo.\n"
dificuldade: .asciiz "Digite a dificuldade, de 1 a 5.\n"
ranking: .asciiz "Tecle 'x' para acessar o ranking.\n"
sair_ranking: .asciiz "Tecle 'x' para sair do ranking.\n"
byebye: .asciiz "Bye-Bye...\n"
.text

# 0xFF012C00 - 0x140 == um dos endereços que devem ser printados como borda (bordas LATERAIS)
# 0xFF000000 + 0x140 == primeiro dos elementos a fazer parte da borda lateral DIREITA



JOGAR:
	li $s0,0xFF000000
	li $t0,0xFF000000	#Endereços da memória de vídeo
	li $t1,0xFF012C00
	li $s2,0xFF000000
	li $s1,0x88888888	# AZUL
	li $s3,0x70707070

pre_LOOP:
	li $t3, 0
	
LOOP: 	beq $s2,$t1, pre_loop1
	sw $s3,0($s2)
	addi $s2,$s2,4
	j LOOP
##########################################################	
pre_loop1:
	li $t3, 0
	li $t2, 320
loop1:								#
	beq $t2, $t3, armazena_endereco1			#
	sw $s1, 0($t0)						#	PINTOU A BORDA SUPERIOR	
	addi $t0,$t0,4						#		
	addi $t3, $t3, 1	#Incrementa a flag		#
	j loop1							#
	
# Acima foi imprimida a primeira linha da matriz	
armazena_endereco1:
	add $t1, $t0, $zero			#Criou uma copia de '$t0' em '$t1'.  Usado para prntas as bordas laterais.
	add $t4, $t0, $zero
pre_loop3:
	li $t3, 0						#
	li $t2, 236						#
						#
loop3:								#	Printou a coluna da DIREITA
	beq $t3, $t2, linha_borda2				#
	sw $s1, 0($t0)						#
	addi $t0, $t0, 320					#	
	addi $t3, $t3, 1					#
	j loop3							#
				
linha_borda2:
	li $t0,0xFF012C00
	li $t2, 321
	li $t3, 0	
loop2:								#
	beq $t2, $t3, pre_loop4					#
	sw $s1, 0($t0)						#	pintou a borda inferior
	addi $t0,$t0,-4						#
	addi $t3, $t3, 1	#Incrementta a flag		#
	j loop2							#
pre_loop4:
	li $t3, 0						#
	li $t2, 236						#
	addi $t4, $t4, -4					#
loop4:								#	Printou a coluna da DIREITA
	beq $t3, $t2, menu					#
	sw $s1, 0($t4)						#
	addi $t4, $t4, 320					#	
	addi $t3, $t3, 1					#
	j loop4							#
				
####################################################################
#				ACIMA				   #
#			PRINTA O FUNDO DA TELA			   #							
####################################################################							
####################################################################							
####################################################################							

menu:
	li $v0, 5			#Lê a dificuldade do jogador
	syscall
	
	li $v0, 1			#
	move $a0, $t0			# Codigo para printar um inteiro
	syscall				#
	
move_right:
	jr $ra
move_left:
	jr $ra
move_up:
	jr $ra
move_down:
	jr $ra
	
.ktext
ECHO: 	la $t8,0xFF100000
   	lw $t9,4($t8)  # Tecla lida
	sw $t9,12($t8)
	
	la $a0, dificuldade		# Codigo para printar string
	li $v0, 4			# 
	syscall				#
	
	eret
	
