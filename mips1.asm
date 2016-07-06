.data
    buffer: .word 0:10
    input: .word 0:10 
    nome: .asciiz "abc.txt"
    teste: .asciiz ":D"
    name: .word 0,0,0
    value: .word 12
.text
	la $a0, buffer
	li $a1, 10
	li $v0, 8
	syscall
	
	li   $v0, 13    # abre o arquivo pra ler
	la   $a0, name
	li   $a1, 0
	li   $a2, 0
	syscall
	move $s6, $v0

	li $t1 0
ficaLendo:      #le tudo q tem no arquivo
	li   $v0, 14
	move $a0, $s6
	la   $a1, buffer

	mul $t2, $t1, 10
	add $a1, $a1, $t2
	li   $a2, 10
	syscall
	
	move $a0, $a1
	li $v0, 4
	syscall
	
	li $v0, 14
	la   $a1, input
	
	mul $t2, $t1, 4
	add $a1, $a1, $t2
	li $a2, 4
	syscall
	add $t1, $t1, 1
	bgt $v0, $zero, ficaLendo

	li   $v0, 16
	move $a0, $s6
	syscall         
	
	li   $v0, 13
	la   $a0, nome
	li   $a1, 1
	li   $a2, 0
	syscall
	move $s6, $v0
	
	li $t2, 0
bota:   beq $t1, $t2, depois #bota as parada no arquivo
        mul $t3, $t2, 10
        move $a0, $s6
        la $a1, buffer
        add $a1, $a1, $t3
        li $a2, 10
        li $v0, 15
        syscall
        
        mul $t3, $t2, 4
        move $a0, $s6
        la $a1, input
        add $a1, $a1, $t3
        li $a2, 4
        li $v0, 15
        syscall
        
        add $t2, $t2, 1
        
        j bota
depois: move $a0, $s6
        la $a1, name
        li $a2, 10
        li $v0, 15
        syscall
        
        move $a0, $s6
        la $a1, value
        li $a2, 4
        li $v0, 15
        syscall
	
        li   $v0, 16
	move $a0, $s6
	syscall  
	


