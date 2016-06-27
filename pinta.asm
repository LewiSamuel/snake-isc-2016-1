.data 
rabo: .byte 0:640
.text
	la $s7,rabo
	move $t4, $s7
	li $t0, 0x64
	sb $t0, 0($t4)
	add $t4, $t4, 1
	sb $t0, 0($t4)
	add $t4, $t4, 1
	sb $t0, 0($t4)
	add $t4, $t4, 1
	li $t9,0xFF012C00
	li $s3,0xFF000000
	li $s1,0x07070707
LOOP: 	beq $s3,$t9,FORA
	sw $s1,0($s3)
	addi $s3,$s3,4
	j LOOP
FORA: 	
	li $t3,0xFF007384
	li $s2,0xFF007360
	li $s1,0xb2b2b2b2
	move $t7,$s2 
	move $v0,$t3 #v0=fim do rabo
	move $v1,$t7 #v1=inicio do rabo
	addi $v1,$v1,-0xc
	addi $v0,$v0,-0x24
	move $a1,$t3	#salva em $a1 o fim do endereco que sera printado
	move $a2,$t7 	 #salva em $a2 o inicio do endereo que sera printado
	addi $a2,$a2,0x18
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
	li $t6,10
	li $s1,0x07070707
	move $t3,$v0
	move $t7,$v1
ficaa3:	addi $t6,$t6,-1
	add $t3,$t3,0x00000140
	add $t7,$t7,0x00000140
	move $s2,$t7
LOOP3a3: beq $s2,$t3,FORA3a3
	sw $s1,0($s2)
	addi $s2,$s2,4
	j LOOP3a3
FORA3a3: bne $t6,$zero,ficaa3
FIM:	# Leitura do teclado e echo na tela
	la $t1,0xFF100000
	li $t0,2
	sw $t0,0($t1)   # Habilita interrup??o do teclado
	li $s0,0
CONTA:	j CONTA


.ktext
ECHO: 	la $t1,0xFF100000
   	lw $t2,4($t1)  # Tecla lida
	beq $t2,0x64,direita
	beq $t2,0x44,direita
	beq $t2,0x73,baixo
	beq $t2,0x53,baixo
	beq $t2,0x61,esquerda
	beq $t2,0x41,esquerda
	beq $t2,0x77,cima
	beq $t2,0x57,cima
limpa:	sb $t2,0($t4)
	addi $t4,$t4,1
	lb $t2,0($s7)
	addi $s7,$s7,1
	beq $t2,0x64,direitat
	beq $t2,0x44,direitat
	beq $t2,0x73,baixot
	beq $t2,0x53,baixot
	beq $t2,0x61,esquerdat
	beq $t2,0x41,esquerdat
	beq $t2,0x77,cimat
	beq $t2,0x57,cimat
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
	j limpa #volta pra ler outra tecla, os pra esquerda, cima e baixo sao parecidos
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
	j limpa
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
	j limpa
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
	j limpa
	######################
direitat:addi $v0,$v0,0xc
	addi $v1,$v1,0xc
	move $t3,$v0
	move $t7,$v1
	li $t6,10
	li $s1,0x07070707 #parte dos 4 cria um novo quadrado azul
fica4t:	addi $t6,$t6,-1
	add $t3,$t3,0x00000140
	add $t7,$t7,0x00000140
	move $s2,$t7
LOOP4t: 	beq $s2,$t3,FORA4t
	sw $s1,0($s2)
	addi $s2,$s2,4
	j LOOP4t
FORA4t:	bne $t6,$zero,fica4t
	j fim #volta pra ler outra tecla, os pra esquerda, cima e baixo sao parecidos
baixot:	addi $v0,$v0,0xc80
	addi $v1,$v1,0xc80
	move $t3,$v0
	move $t7,$v1
	li $t6,10
	li $s1,0x07070707
fica8t:	addi $t6,$t6,-1
	add $t3,$t3,0x00000140
	add $t7,$t7,0x00000140
	move $s2,$t7
LOOP8t: 	beq $s2,$t3,FORA8t
	sw $s1,0($s2)
	addi $s2,$s2,4
	j LOOP8t
FORA8t:	bne $t6,$zero,fica8t
	j fim
cimat:	addi $v0,$v0,-0xc80
	addi $v1,$v1,-0xc80
	move $t3,$v0
	move $t7,$v1
	li $t6,10
	li $s1,0x07070707
ficv08t:	addi $t6,$t6,-1
	add $t3,$t3,0x00000140
	add $t7,$t7,0x00000140
	move $s2,$t7
LOOP18t: beq $s2,$t3,FORv08t
	sw $s1,0($s2)
	addi $s2,$s2,4
	j LOOP18t
FORv08t:	bne $t6,$zero,ficv08t
	j fim
esquerdat:addi $v0,$v0,-0xc
	addi $v1,$v1,-0xc
	move $t3,$v0
	move $t7,$v1
	li $t6,10
	li $s1,0x07070707
ficv04t:	addi $t6,$t6,-1
	add $t3,$t3,0x00000140
	add $t7,$t7,0x00000140
	move $s2,$t7
LOOP14t:	beq $s2,$t3,FORv04t
	sw $s1,0($s2)
	addi $s2,$s2,4
	j LOOP14t
FORv04t:	bne $t6,$zero,ficv04t
	j fim
