.data 
    myArray: .space 400 #Número 400 porque se va almacenar una cantidad de 100 números de tipo entero y cada entero equivale a 4 bytes
    space: .asciiz " , "
    enter: .asciiz "\n"
    stringOld: .asciiz "Array sin organizar\n"
    stringNew: .asciiz "\nArray organizado\n"
.text
    j main #Start the program
    printArray:                         #procedimiento que imprimira un array
        addi      $v0, $0, 4            #Servicio de imprimir
        la        $a0, stringNew
        syscall
        addi      $t0, $0, 0            #Reinicio el valor del t0 en 0...t0 = 0
    loop:
        beq       $t0, 400, exit
        lw        $t2, myArray($t0)     #Sacar todos los valores del array para imprimir
	addi      $v0, $0, 1            #Servicion de imprimir números enteros
        addi      $a0, $t2, 0
	syscall
        addi      $v0, $0, 4            #Service to print de string
        la        $a0, space            #String ","
        syscall
        addi      $t0, $t0, 4 	
        j loop
    generateRandomNumber:               #Etiqueta que va generar el número aleatorio
        addi      $a1, $0, 100          #Numero entre el 1 al 100
        addi      $v0, $0,42            # Service 42, random int   
        syscall                         # Generate random int (returns in $a0)
        move      $t1, $a0              #Movemos el numero random a un registro temporal 
        addi      $v0, $0, 1            # Servicio 1, print int 
        addi      $a0, $t1,0
        syscall                         # Print previously generated random int  
        addi      $v0, $0, 4            #Service to print de string
        la        $a0, space            #String ","
        syscall
        jr        $ra
    main:                               #Funcion principal del programa
        addi      $t0, $zero, 0         #Counter t0 = 0 
        addi      $v0, $0, 4            #Imprimir string
        la        $a0, stringOld
        syscall
    while:
        beq       $t0, 400, bubbleSort  # t0 == 400     
        jal       generateRandomNumber  #Call generateRandonNumber
	sw        $t1, myArray($t0)     #Almacenamos los numeros aleatorios en el a
	addi      $t0, $t0, 4           # t0 += 4 porque se suma cada 4 bytes que se usa para almacenar los enteros	
	j         while
    bubbleSort:
        addi      $t0, $0, 0            #Iniciamos el contador de los arrays en 0 (ciclo1)
    ciclo1: 
        beq       $t0, 396, printArray  #Si el t0 es igual
        addi      $t1, $0, 396          #Inciamos un segundo contador para recorrer cada vez menos el arreglo(ciclo2)
        addi      $t2, $0, 0            #Inciamos el contador en 0 (ciclo2)
        addi      $t3, $0, 0            #t3 es para comparar desde el primer punto del array es decir 0
        addi      $t4, $0, 4            #t4 es para comparar desde n+1 en el array 
    ciclo2:
        beq       $t2, $t1, continuarCiclo1  #if t2 == t1 va a continuarCiclo1     
        lw        $t5, myArray($t3)     #Cargar el valor en la pos n
        lw        $t6, myArray($t4)     #Cargar el valor en la pos n+1
        slt       $t7, $t6, $t5         #Compara si el valor que esta en la pos n+1 es menor que el que esta en la pos n
        beq       $t7, 1, comparacion
        addi      $t2, $t2, 4           #Aumentamos el contador del segundo ciclo
        addi      $t3, $t3, 4           #Aumentamos la pos n
        addi      $t4, $t4, 4           #Aumentamos la pos n+1
        j         ciclo2                #Salto al ciclo2  
    comparacion:
        sw        $t6, myArray($t3)
        sw        $t5, myArray($t4)        
        addi      $t2, $t2, 4           #Aumentamos el contador del segundo ciclo
        addi      $t3, $t3, 4           #Aumentamos la pos n
        addi      $t4, $t4, 4           #Aumentamos la pos n+1
        j         ciclo2                #Segundo salto para llegar al ciclo 2   
    continuarCiclo1:                    #Continua el ciclo principal del bubble                 
        addi      $t0, $t0, 4           #Aumento de contador t0 += 4
        sub       $t1, $t1, 4           #Resto el contador t1 4 para disminuir las comparaciones del array t1 -= 4
        j         ciclo1                #Salto para el ciclo1   
    exit:
        addi      $v0, $0, 10
        syscall
