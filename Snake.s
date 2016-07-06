#########################################################
#  Jogo Snake                                           #
#  ISC Jul 2016				                #
# Luis Felipe Braga Gebrim Silva Matrícula 1 16/0071569 #
# Leonardo Maffei da Silva       Matrícula 2 16/0033811 #
# José Marcos da Silva Leite     Matrícula 3 15/0038810 #
#########################################################
.data 
    pontos: .word -10
    rabo: .byte 0:1200
    comida: .word 0,1
    velocidade: .word 100
    STR: .asciiz " GAMEOVER  GAMEOVER  GAMEOVER  GAMEOVER "
    STR2: .asciiz "Pontuacao: "
    nomedocara: .word 0:30
    botaNome: .asciiz "Bota o nome ae"
    NUM: .word 4
	NOTAS: 54,300,42,300,42,300,57,300

.text
    ########################################################################
    # Colocar SYSTEMV52 no Exception Handler
JOGAR:
	li $t1,0xFF012C00
	li $s2,0xFF000000
	li $s1,0x88888888
ficar: 	beq $s2,$t1,sair
	sw $s1,0($s2)
	addi $s2,$s2,4
	j ficar
sair:
    li $a1 90    # coluna
    li $a2,90   #linha
    la $a0,botaNome   
    li $a3,0x8870   # Frente(70) e fundo(88)
    li $v0,104   
    syscall
    la $a0, nomedocara
    li $a1, 18
    li $v0, 8
    syscall
    li $ra,-1
    li $v0,30
    syscall
    li $v0,40
    syscall
    li $s0,0xFF000000
    li $t0,0xFF000000   #Enderecos da memoria de video
    li $t1,0xFF012C00
    li $s2,0xFF000000
    li $s1,0x88888888   # AZUL
    li $s3,0x70707070

pre_LOOP:
    li $t3, 0

LOOP: 
    beq $s2,$t1, pre_loop1
    sw $s3,0($s2)
    addi $s2,$s2,4
    j LOOP
    ##########################################################  
pre_loop1:
    li $t3, 0
    li $t2, 960
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
    add $t8, $s7, 1200 
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
    move $s6,$t3 #s6=fim do rabo
    move $v1,$t7 #v1=inicio do rabo
    addi $v1,$v1,-8
    addi $s6,$s6,-24
    move $s3,$t3    #salva em $s3 o fim do endereco que sera printado
    move $t9,$t7     #salva em $t9 o inicio do endereo que sera printado
    addi $t9,$t9,16
    li $t6,8
ficaa2: 
    addi $t6,$t6,-1
    add $t3,$t3,0x00000140
    add $t7,$t7,0x00000140
    move $s2,$t7
LOOP3a2:
    beq $s2,$t3,FORA3a2
    sw $s1,0($s2)
    addi $s2,$s2,4
    j LOOP3a2
FORA3a2: 
    bne $t6,$zero,ficaa2
    li $a1,1000
    la $a0,comida
    sw $a1,0($a0)
    li $t2,0x44
    	la $s0,NUM
	lw $s1,0($s0)
	la $s0,NOTAS
	li $t0,0
	li $a2,68	# instrumento
	li $a3,25	# volume

LOOP23:	beq $t0,$s1, FIM23
	lw $a0,0($s0)		# nota
	lw $a1,4($s0)		# duracao
	li $v0,31		# 33 da pausa a mais
	syscall
	move $a0,$a1		#pausa = duracao
	li $v0,32
	syscall
	addi $s0,$s0,8
	addi $t0,$t0,1
	j LOOP23
FIM23:
werl:
	    	la $s0,NUM
	lw $s1,0($s0)
	la $s0,NOTAS
	li $t0,0
	li $a2,68	# instrumento
	li $a3,25	# volume

LOOP22:	beq $t0,$s1, FIM22
	lw $a0,0($s0)		# nota
	lw $a1,4($s0)		# duracao
	li $v0,31		# 33 da pausa a mais
	syscall
	addi $s0,$s0,8
	addi $t0,$t0,1
	j LOOP22
FIM22:
    addi $s0,$s0,8
    addi $t0,$t0,1
 
    li $a1,180    # coluna
    li $a2,4    #linha
    la $a0,nomedocara   
    li $a3,0x8870   # Frente(70) e fundo(88)
    li $v0,104   
    syscall

    li $a1,4    # coluna
    li $a2,4    #linha
    la $a0,STR2   
    li $a3,0x8870   
    li $v0,104     
    syscall
    
    addi $ra,$ra,1
    beq $ra,5,rapidiza
volta:
    la $a0,pontos
    lw $a3,0($a0)
    addi $a3,$a3,10
    sw $a3,0($a0)
    move $a0,$a3
    li $a3,0x8870
    li $v0,101
    syscall
    li $t3,0xff000f04
    move $s4,$t3
    li $s5,0
    li $v0,42
    la $a0,comida
    lw $a1,0($a0)
    addi $a1,$a1,-1
    sw $a1,0($a0)
    li $a0,2
    syscall
alimenta:   
    beq $a0,0,sai
    addi $s5,$s5,1
    beq $s5,39,arruma
    addi $t3,$t3,0x8
    lw $t7,0($t3)
    beq $t7,0x00000000,alimenta
    addi $a0,$a0,-1
    j alimenta
rapidiza:
	la $a0,velocidade
	lw $t7,0($a0)
	addi $t7,$t7,-10
	sw $t7,0($a0)
	addi $ra,$ra,-5
	j volta
arruma:
    addi $s5,$s5,-39
    addi $s4,$s4,2560
    move $t3,$s4
    j alimenta  
sai:

    addi $t3,$t3,-320
    move $s2,$t3
    addi $t3,$t3,8
    move $t7,$s2
    li $s1,0xffffffff
    li $t6,8
ficaa2b:
    addi $t6,$t6,-1
    add $t3,$t3,0x00000140
    add $t7,$t7,0x00000140
    move $s2,$t7
LOOP3a2b: 
    beq $s2,$t3,FORA3a2b
    sw $s1,0($s2)
    addi $s2,$s2,4
    j LOOP3a2b
FORA3a2b:
    bne $t6,$zero,ficaa2b

    li $t6,8
    li $s1,0x70707070
    move $t3,$s6
    move $t7,$v1
ficaa3:
    addi $t6,$t6,-1
    add $t3,$t3,0x00000140
    add $t7,$t7,0x00000140
    move $s2,$t7
LOOP3a3:
    beq $s2,$t3,FORA3a3
    sw $s1,0($s2)
    addi $s2,$s2,4
    j LOOP3a3
FORA3a3: 
    bne $t6,$zero,ficaa3
CONTA:
	li $v0,32
	la $a0,velocidade
	lw $a0,0($a0)
	syscall
#################################	POLILING
    la $t1,0xFF100000
    lw $t0,0($t1)
    andi $t0,$t0,0x0001 
    beq $t0,$zero,PULA          
    lw $t2,4($t1)       # Tecla lida
#################################
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
fim2:
    j PULA
fim3:
    move $t2,$t5
    j birl2
PULA:

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
    beq $t1,0xffffffff,werl
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
    loope:  
    li $s1,0x00000000 #parte dos 4 cria um novo quadrado azul
    li $t6,8
fica4:  
    addi $t6,$t6,-1
    add $t3,$t3,0x00000140
    add $t7,$t7,0x00000140
    move $s2,$t7
LOOP4: 
    beq $s2,$t3,FORA4
    sw $s1,0($s2)
    addi $s2,$s2,4
    j LOOP4
FORA4:  
    bne $t6,$zero,fica4
    j limpa #volta pra ler outra tecla, os pra esquerda, cima e baixo sao parecidos
direita:
    addi $s3,$s3,8
    addi $t9,$t9,8
    move $t3,$s3
    move $t7,$t9
    lw $t1,320($t9)  
    j loope
baixo:
    addi $s3,$s3,2560
    addi $t9,$t9,2560
    move $t3,$s3
    move $t7,$t9
    lw $t1,320($t9)  
    j loope
cima:  
    lw $t1,-324($s3)
    beq $t1,0x88888888,vacilo
    beq $t1,0x00000000,vacilo  
    addi $s3,$s3,-2560
    addi $t9,$t9,-2560
    move $t3,$s3
    move $t7,$t9
    j loope
esquerda:
    addi $s3,$s3,-8
    addi $t9,$t9,-8
    move $t3,$s3
    move $t7,$t9
    lw $t1,316($s3)  
    j loope
    ######################
direitat:
    addi $s6,$s6,8
    addi $v1,$v1,8
    move $t3,$s6
    move $t7,$v1
    j loope2
baixot:
    addi $s6,$s6,2560
    addi $v1,$v1,2560
    move $t3,$s6
    move $t7,$v1
    j loope2
cimat:
    addi $s6,$s6,-2560
    addi $v1,$v1,-2560
    move $t3,$s6
    move $t7,$v1
    j loope2
esquerdat:
    addi $s6,$s6,-8
    addi $v1,$v1,-8
    move $t3,$s6
    move $t7,$v1
    j loope2
loope2:
    li $t6,8
    li $s1,0x70707070 #Cria um novo quadrado verde
    fica4t: addi $t6,$t6,-1
    add $t3,$t3,0x00000140
    add $t7,$t7,0x00000140
    move $s2,$t7
LOOP4t:    
    beq $s2,$t3,FORA4t
    sw $s1,0($s2)
    addi $s2,$s2,4
    j LOOP4t
FORA4t:
    bne $t6,$zero,fica4t
    j fim

reseta:
    addi $t4,$t4,-1200
    j limpa
reseta2:
    addi $s7,$s7,-1200
    j limpa
vacilo:
	li $a0,40
	li $a1,1500
	li $a2,127
	li $a3,127
	li $v0,33
	syscall
    li $t1,0xFF012C00
    li $s2,0xFF000000
    li $s1,0x00000000
game:   beq $s2,$t1,over
    sw $s1,0($s2)
    addi $s2,$s2,4
    j game
over:
li $t0,0
li $t3,0
li $a1,0    # coluna
li $a2,0    #linha
li $s1,0
li,$s2,0
loop:
    la $a0,STR   
    li $a3,0x00ff   # Frente(ff) e fundo(00)
    li $v0,104       
    syscall
    addi $t0,$t0,1
    addi $t3,$t3,1
    beq $t3,30,acabou
    addi $s2,$s2,8
    move $a2,$s2
    addi $s1,$s1,3
    move $a1,$s1
    addi $t0,$t0,-1
    j loop
acabou: li $v0,10
    syscall
