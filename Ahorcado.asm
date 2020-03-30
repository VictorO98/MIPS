.data
    entrada: .asciiz "Bienvenido al juego del ahorcado te damos una palabra y tu lo adivinas\n"  
    suerte: .asciiz "SUERTE!!!\n"
    ingreso: .asciiz "\nIngrese su palabra: " 
    malJugador: .asciiz "Que mal jugador eres...PERDISTE!!!"
    buenJugador: .asciiz "GANASTE" 
    espacio: .asciiz "\n"
    juego: .asciiz "_ _ _ _ _ "
    correcto:  .asciiz "Acertaste"
    incorrecto: .asciiz "Fallaste que manco"
    cadena: .space 10 #Espacio del buffer 

    palabras:  #Palabras
         p1: .asciiz "holaa"
         p2: .asciiz "chaoo"
         p3: .asciiz "feliz"
         p4: .asciiz "popoo"
         p5: .asciiz "jason"
         p6: .asciiz "lindo"
         p7: .asciiz "mouse"
         p8: .asciiz "perro"
         p9: .asciiz "media"
         p10: .asciiz "reloj"
         p11: .asciiz "intel"
.text
    NumeroAleatorio:                    #Gennerador de numero aleatorio
        addi      $a1, $0, 10           #Numero entre el 1 al 100
        addi      $v0, $0,42            # Service 42, random int   
        syscall                         # Generate random int (returns in $a0) 
        move      $s0, $a0              #Movemos el numero random a un registro temporal
        addi      $t0, $0, 6            #Almaceno en to = 6
        mul       $s0, $s0, $t0         #Se multiplica por 6 para saber su pos
    PalabrasDeEntrada:                  #Prints de la entrada del juego 
        addi      $v0, $0, 4            #Servicio de imprimir string
        la        $a0, entrada          #Parametro
        syscall  
        addi      $v0, $0, 4            #Servicio de imprimir string
        la        $a0, suerte           #Paramaetro
        syscall
        addi      $v0, $0, 4            #Servicio de imprimir string 
        la        $a0, juego            #Parametro
        syscall
    AlmacenamientoPalabra:  
        la        $s1, palabras($s0)    #Cargamos en s1 la palabra aletoria que vamos a tomar   
        addi      $t0, $0, 0            #Reiniciamos el t0 en 0 para recorrer el dato
    Entradas:
        addi      $t1, $0, 8            #Contador de oportunidades para perder
        addi      $t2, $0, 0            #Puntos acertados para ganar el juego...maximo 5
    while:
        beqz      $t1, Perdiste         #t1 == 0 ... pierde
        beq       $t2, 5, Ganaste       #t2 == 5 ...ganaste
        addi      $v0, $0, 4 #Borrar
        la        $a0, ($s1)#Borrar
        syscall  #Borrar
        addi      $v0, $0, 4            #Servicio de imprimir string
        la        $a0,ingreso           #Parametro
        syscall
        addi      $v0, $0, 8            #Vamo a leer el string
        la        $a0, cadena           #Direccion donde esta el mensaje
        addi      $a1, $0, 10           #El maximo de caracteres que se van a leer
        syscall
        lb        $t3, cadena           #Cargamos en t3 la palabra que fue ingresada por el usuario
        la        $s1, palabras($s0)    #Cargamos en s1 la palabra aletoria que vamos a tomar
        addi      $t4, $0, -2           #Iniciamos un contador en 0 para recorrer la palabra
   whileRecorridoPalabra:
        beq       $t4, 5, Fallaste 
        lb        $s2, 0($s1)           #Cargamos la palabra que estan en s1 en la pos 0  
        addi      $s1, $s1, 1           #Aumentamos la pos de la letra que se va comparar en la palabre generada
        addi      $t4, $t4, 2           #t4++
        beq       $t3, $s2, Acertaste
        j         whileRecorridoPalabra
    Acertaste:
        addi      $v0, $0, 4
        la        $a0, correcto
        syscall
        sb        $t3, juego($t4)
        addi      $v0, $0, 4
        la        $a0, espacio
        syscall                         #Imprimir \n  
        addi      $v0, $0, 4            #Servicio de imprimir string
        la        $a0, juego
        syscall 
        addi      $v0, $0, 4
        la        $a0, espacio
        syscall                         #Imprimir \n  
        addi      $t2, $t2, 1                # t2++ 
        j         while
    Fallaste:    
        addi      $v0, $0, 4
        la        $a0, incorrecto
        syscall 
        subi      $t1, $t1, 1           #t1--
        j         while
    Perdiste:
        addi      $v0, $0, 4
        la        $a0, espacio
        syscall                         #Imprimir \n 
        addi      $v0, $0, 4
        la        $a0, malJugador
        syscall                         #Imprimir el perdiste
        addi      $v0, $0, 10           #Acaba el programa
        syscall
    Ganaste:
        addi      $v0, $0, 4
        la        $a0, espacio
        syscall                         #Imprimir \n 
        addi      $v0, $0, 4
        la        $a0, buenJugador
        syscall                         #Imprimir el perdiste
        addi      $v0, $0, 10           #Acaba el programa
        syscall
                        
