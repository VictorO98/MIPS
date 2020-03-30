.data 

msg1: .asciiz "Ingrese su palabra: "
cadena: .space 15 #Espacio que almeceno 

.text

addi $v0, $0, 4 #Guarda el servicio para imprimir el mensaje
la $a0, msg1
syscall

addi $v0, $0, 8 #Vamo a leer el string
la $a0, cadena #Direccion donde esta el mensaje
addi $a1, $0, 10 #El maximo de caracteres que se van a leer
syscall