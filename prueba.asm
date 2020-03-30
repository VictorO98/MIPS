.data
    myArray: .space 20
    space: .asciiz " , " 
.text
    addi $s0, $0, 3
    addi $s1, $0, 4
    addi $s2, $0, 5
    
    #index t0
    addi $t0, $zero, 0
    
    sw $s0, myArray($t0)
    addi $t0, $t0, 4
    sw $s1, myArray($t0)
    addi $t0, $t0, 4
    sw $s2, myArray($t0)
    
    #Clear t0
    addi $t0, $0, 0
    
    while:
    
        beq $t0, 20, exit #t0 == 0...va para exit
        lw $t2, myArray($t0) #Carga el valor del array en la pos de t0 y luego lo almacena en t2
        
        addi $v0, $0, 1 #Immprimir el numer
        addi $a0, $t2, 0
        syscall
        
        addi $v0, $0, 4 #Service to print de string
        la $a0, space #String ","
        syscall
        
        addi $t0, $t0, 4
        j while
    
    exit:
        addi $v0, $0, 10
        syscall
