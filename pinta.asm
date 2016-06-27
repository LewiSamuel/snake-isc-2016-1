.data 
.text

	li $t4,0xFF012C00
	li $s3,0xFF000000
	li $s1,0x07070707
LOOP: 	beq $s3,$t4,FORA
	sw $s1,0($s3)
	addi $s3,$s3,4
	j LOOP
FORA: 	
	li $t3,0xFF007378
	li $s2,0xFF007360
	li $s1,0xb2b2b2b2
	move $t7,$s2 
	move $a1,$t3 	#salva em $a1 o fim do endere?o que sera printado
	move $a2,$t7  #salva em $a2 o inicio do endere?o que sera printado
	addi $a2,$a2,0xc
	li $t6,10
ficaa2:	addi $t6,$t6,-1
	add $t3,$t3,0x00000140
	add $t7,$t7,0x00000140
	move $s2,$t7
LOOP3a2: beq $s2,$t3,FORA3a2
	sw $s1,0($s2)
	addi $s2,$s2,4
	j LOOP3a2
FORA3a2: bne $t6,$zero,ficaa2
FIM:	# Leitura do teclado e echo na tela
	la $t1,0xFF100000
	li $t0,2
	sw $t0,0($t1)   # Habilita interrup??o do teclado
	li $s0,0
CONTA:	j CONTA


.ktext
ECHO: 	la $t1,0xFF100000
   	lw $t2,4($t1)  # Tecla lida
	sw $t2,12($t1)
	beq $t2,0x64,direita
	beq $t2,0x73,baixo
	beq $t2,0x61,esquerda
	beq $t2,0x77,cima
fim:	eret
direita:addi $a1,$a1,0xc
	addi $a2,$a2,0xc
	move $t3,$a1
	move $t7,$a2
	li $t6,10
	li $s1,0xb2b2b2b2 #parte dos 4 cria um novo quadrado azul
fica4:	addi $t6,$t6,-1
	add $t3,$t3,0x00000140
	add $t7,$t7,0x00000140
	move $s2,$t7
LOOP4: 	beq $s2,$t3,FORA4
	sw $s1,0($s2)
	addi $s2,$s2,4
	j LOOP4
FORA4:	bne $t6,$zero,fica4
	j fim #volta pra ler outra tecla, os pra esquerda, cima e baixo sao parecidos
baixo:	addi $a1,$a1,0xc80
	addi $a2,$a2,0xc80
	move $t3,$a1
	move $t7,$a2
	li $t6,10
	li $s1,0xb2b2b2b2
fica8:	addi $t6,$t6,-1
	add $t3,$t3,0x00000140
	add $t7,$t7,0x00000140
	move $s2,$t7
LOOP8: 	beq $s2,$t3,FORA8
	sw $s1,0($s2)
	addi $s2,$s2,4
	j LOOP8
FORA8:	bne $t6,$zero,fica8
	j fim
cima:	addi $a1,$a1,-0xc80
	addi $a2,$a2,-0xc80
	move $t3,$a1
	move $t7,$a2
	li $t6,10
	li $s1,0xb2b2b2b2
fica18:	addi $t6,$t6,-1
	add $t3,$t3,0x00000140
	add $t7,$t7,0x00000140
	move $s2,$t7
LOOP18: beq $s2,$t3,FORA18
	sw $s1,0($s2)
	addi $s2,$s2,4
	j LOOP18
FORA18:	bne $t6,$zero,fica18
	j fim
esquerda:addi $a1,$a1,-0xc
	addi $a2,$a2,-0xc
	move $t3,$a1
	move $t7,$a2
	li $t6,10
	li $s1,0xb2b2b2b2
fica14:	addi $t6,$t6,-1
	add $t3,$t3,0x00000140
	add $t7,$t7,0x00000140
	move $s2,$t7
LOOP14:	beq $s2,$t3,FORA14
	sw $s1,0($s2)
	addi $s2,$s2,4
	j LOOP14
FORA14:	bne $t6,$zero,fica14
	j fim
