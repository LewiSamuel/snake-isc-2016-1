.data 
rabo: .byte 0:640
.text
########################################################################
JOGAR:
    li $s0,0xFF000000
    li $t0,0xFF000000   #Endere?os da mem?ria de v?deo
    li $t1,0xFF012C00
    li $s2,0xFF000000
    li $s1,0x88888888   # AZUL
    li $s3,0x70707070

pre_LOOP:
    li $t3, 0
    
LOOP:   beq $s2,$t1, pre_loop1
    sw $s3,0($s2)
    addi $s2,$s2,4
    j LOOP
##########################################################  
pre_loop1:
    li $t3, 0
    li $t2, 320
loop1:                              #
    beq $t2, $t3, armazena_endereco1            #
    sw $s1, 0($t0)                      #   PINTOU A BORDA SUPERIOR 
    addi $t0,$t0,4                      #       
    addi $t3, $t3, 1    #Incrementa a flag      #
    j loop1                         #
    
# Acima foi imprimida a primeira linha da matriz    
armazena_endereco1:
    add $t1, $t0, $zero         #Criou uma copia de '$t0' em '$t1'.  Usado para prntas as bordas laterais.
    add $t4, $t0, $zero
pre_loop3:
    li $t3, 0                       #
    li $t2, 236                     #
                        #
loop3:                              #   Printou a coluna da DIREITA
    beq $t3, $t2, linha_borda2              #
    sw $s1, 0($t0)                      #
    addi $t0, $t0, 320                  #   
    addi $t3, $t3, 1                    #
    j loop3                         #
                
linha_borda2:
    li $t0,0xFF012C00
    li $t2, 320
    li $t3, 0   
loop2:                              #
    beq $t2, $t3, pre_loop4                 #
    sw $s1, 0($t0)                      #   pintou a borda inferior
    addi $t0,$t0,-4                     #
    addi $t3, $t3, 1    #Incrementta a flag     #
    j loop2                         #
pre_loop4:
    li $t3, 0                       #
    li $t2, 236                     #
    addi $t4, $t4, -4                   #
loop4:                              #   Printou a coluna da DIREITA
    beq $t3, $t2, birl                  #
    sw $s1, 0($t4)                      #
    addi $t4, $t4, 320                  #   
    addi $t3, $t3, 1                    #
    j loop4                         #
birl:
############################################################
      la $s7,rabo
    li $t5, 0
    move $t4, $s7
    add $t8, $s7, 640 
    li $t0, 0x64
    sb $t0, 0($t4)
    add $t4, $t4, 1
    sb $t0, 0($t4)
    add $t4, $t4, 1
    sb $t0, 0($t4)
    add $t4, $t4, 1
    li $t3,0xFF007224
    addi $t3,$t3,24
    li $s2,0xFF007224
    li $s1,0x00000000
    move $t7,$s2 
    move $s6,$t3 #v0=fim do rabo
    move $v1,$t7 #v1=inicio do rabo
    addi $v1,$v1,-8
    addi $s6,$s6,-24
    move $a1,$t3    #salva em $a1 o fim do endereco que sera printado
    move $a2,$t7     #salva em $a2 o inicio do endereo que sera printado
    addi $a2,$a2,16
    li $t6,8
ficaa2: addi $t6,$t6,-1
    add $t3,$t3,0x00000140
    add $t7,$t7,0x00000140
    move $s2,$t7
LOOP3a2: beq $s2,$t3,FORA3a2
    sw $s1,0($s2)
    addi $s2,$s2,4
    j LOOP3a2
FORA3a2: bne $t6,$zero,ficaa2

	move $s2,$t3
	addi $t3,$t3,8
    move $t7,$s2
	li $s1,0xffffffff
    li $t6,8
ficaa2b: addi $t6,$t6,-1
    add $t3,$t3,0x00000140
    add $t7,$t7,0x00000140
    move $s2,$t7
LOOP3a2b: beq $s2,$t3,FORA3a2b
    sw $s1,0($s2)
    addi $s2,$s2,4
    j LOOP3a2b
FORA3a2b: bne $t6,$zero,ficaa2b

    li $t6,8
    li $s1,0x70707070
    move $t3,$s6
    move $t7,$v1
ficaa3: addi $t6,$t6,-1
    add $t3,$t3,0x00000140
    add $t7,$t7,0x00000140
    move $s2,$t7
LOOP3a3: beq $s2,$t3,FORA3a3
    sw $s1,0($s2)
    addi $s2,$s2,4
    j LOOP3a3
FORA3a3: bne $t6,$zero,ficaa3
	li $t2,0x44
CONTA:	la $t1,0xFF100000
	lw $t0,0($t1)
	andi $t0,$t0,0x0001		# Le bit de Controle Teclado
   	beq $t0,$zero,PULA   	   	# Se n�o h� tecla pressionada PULA
  	lw $t2,4($t1)  		# Tecla lida
  	    sub $t0, $t5, $t2
    
    beq $t0, -3, fim3
    beq $t0, 3, fim3
    beq $t0, 35, fim3
    beq $t0, -35, fim3
    beq $t0, -29, fim3
    beq $t0, 29, fim3
        
    beq $t0, 4, fim3
    beq $t0, -4, fim3
    beq $t0, 28, fim3
    beq $t0, -28, fim3
    beq $t0, 36, fim3
    beq $t0, -36, fim3
    
birl2:            
    beq $t2,0x64,fim2
    beq $t2,0x44,fim2
    beq $t2,0x73,fim2
    beq $t2,0x53,fim2
    beq $t2,0x61,fim2
    beq $t2,0x41,fim2
    beq $t2,0x77,fim2
	beq $t2,0x57,fim2
    
    j fim3
fim2:   j PULA
fim3:   move $t2,$t5
	j birl2
PULA:

	li $v0,32
	li $a0,100
	syscall
  
    move $t5, $t2
            
    beq $t2,0x64,direita
    beq $t2,0x44,direita
    beq $t2,0x73,baixo
    beq $t2,0x53,baixo
    beq $t2,0x61,esquerda
    beq $t2,0x41,esquerda
    beq $t2,0x77,cima
	beq $t2,0x57,cima
    
    j fim
limpa:
    beq $t4, $t8,reseta
    beq $s7,$t8,reseta2
    sb $t2,0($t4)
    addi $t4,$t4,1
    beq $t1,0xffffffff,fim
    beq $t1,0x88888888,vacilo
    beq $t1,0x00000000,vacilo
    lb $a0,0($s7)
    addi $s7,$s7,1
    beq $a0,0x64,direitat
    beq $a0,0x44,direitat
    beq $a0,0x73,baixot
    beq $a0,0x53,baixot
    beq $a0,0x61,esquerdat
    beq $a0,0x41,esquerdat
    beq $a0,0x77,cimat
    beq $a0,0x57,cimat
fim:    
j CONTA
loope:   li $s1,0x00000000 #parte dos 4 cria um novo quadrado azul
    li $t6,8
fica4:  addi $t6,$t6,-1
    add $t3,$t3,0x00000140
    add $t7,$t7,0x00000140
    move $s2,$t7
LOOP4:  beq $s2,$t3,FORA4
    sw $s1,0($s2)
    addi $s2,$s2,4
    j LOOP4
FORA4:  bne $t6,$zero,fica4
    j limpa #volta pra ler outra tecla, os pra esquerda, cima e baixo sao parecidos
direita:addi $a1,$a1,8
    addi $a2,$a2,8
    move $t3,$a1
    move $t7,$a2
    lw $t1,320($a2)  
    j loope
baixo:  addi $a1,$a1,2560
    addi $a2,$a2,2560
    move $t3,$a1
    move $t7,$a2
    lw $t1,320($a2)  
    j loope
cima:   lw $t1,-324($a1)
	beq $t1,0x88888888,vacilo
    beq $t1,0x00000000,vacilo  
	addi $a1,$a1,-2560
    addi $a2,$a2,-2560
    move $t3,$a1
    move $t7,$a2
    j loope
esquerda:addi $a1,$a1,-8
    addi $a2,$a2,-8
    move $t3,$a1
    move $t7,$a2
    lw $t1,316($a1)  
    j loope
    ######################
direitat:addi $s6,$s6,8
    addi $v1,$v1,8
    move $t3,$s6
    move $t7,$v1
j loope2
baixot: addi $s6,$s6,2560
    addi $v1,$v1,2560
    move $t3,$s6
    move $t7,$v1
j loope2
cimat:  addi $s6,$s6,-2560
    addi $v1,$v1,-2560
    move $t3,$s6
    move $t7,$v1
j loope2
esquerdat:addi $s6,$s6,-8
    addi $v1,$v1,-8
    move $t3,$s6
    move $t7,$v1
j loope2
loope2:       li $t6,8
    li $s1,0x70707070 #parte dos 4 cria um novo quadrado azul
fica4t: addi $t6,$t6,-1
    add $t3,$t3,0x00000140
    add $t7,$t7,0x00000140
    move $s2,$t7
LOOP4t:     beq $s2,$t3,FORA4t
    sw $s1,0($s2)
    addi $s2,$s2,4
    j LOOP4t
FORA4t: bne $t6,$zero,fica4t
j fim

reseta: addi $t4,$t4,-640
    j limpa
reseta2:addi $s7,$s7,-640
    j limpa
vacilo:    li $v0,10
    syscall

    j CONTA
