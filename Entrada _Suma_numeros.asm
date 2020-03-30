.data 

msg1: .asciiz "Ingrerse un número: "
msg2: .asciiz "Ingrese otro número: " #n+1 bytes

.text

#dato 1

addi $v0, $0, 4 #Guarda el servicio
la $a0, msg1 #Da la direcccion donde esta guardado el mensaje
syscall #Ejecuta las instrucciones anteriores

addi $v0, $0, 5 #Leer unn numero
syscall
add $t0, $0, $v0 #Crea un temporal donde se va guardar el dato 1

#dato 2

addi $v0, $0, 4 #Guarda el servicio
la $a0, msg2 #Direccion donde esta almacenado el mensaje 2
syscall

addi $v0, $0, 5 #Leer numero
syscall
add $t1, $0, $v0

add $t2, $t0, $t1 #Suma

addi $v0, $0, 1
addi $a0, $t2, 0
syscall
