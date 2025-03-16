.data
    msg_cantidad: .asciiz "Ingrese cu�ntos n�meros desea comparar (Min 3 - Max 5): "  # Pide cu�ntos n�meros va a comparar, entre 3 y 5
    msg_ingreso: .asciiz "Ingrese un n�mero: "  # Pide al usuario que ingrese un n�mero
    msg_menor: .asciiz "El n�mero menor es: "  # Mensaje para mostrar el n�mero menor encontrado
    msg_error: .asciiz "Error: Debe ingresar entre 3 y 5 n�meros.\n"  # Mensaje de error si la cantidad no es v�lida

.text
main:
    # Primero, pedir la cantidad de n�meros que se van a comparar
valida_cantidad:
    li $v0, 4  # Prepara la syscall para imprimir texto
    la $a0, msg_cantidad  # Carga el mensaje de entrada
    syscall  # Muestra el mensaje

    li $v0, 5  # Prepara la syscall para leer un n�mero
    syscall  # Lee el n�mero ingresado
    move $t1, $v0  # Guarda la cantidad en $t1

    # Comprobamos que la cantidad est� entre 3 y 5
    blt $t1, 3, error  # Si es menor que 3, saltamos a 'error'
    bgt $t1, 5, error  # Si es mayor que 5, saltamos a 'error'

    j iniciar_comparacion  # Si est� bien, seguimos con la comparaci�n

error:
    li $v0, 4  # Prepara la syscall para imprimir texto
    la $a0, msg_error  # Carga el mensaje de error
    syscall  # Muestra el mensaje de error
    j valida_cantidad  # Vuelve a pedir la cantidad de n�meros

iniciar_comparacion:
    li $t0, 2147483647  # Inicializa el valor de $t0 con el n�mero m�s grande posible

loop:
    li $v0, 4  # Prepara la syscall para imprimir texto
    la $a0, msg_ingreso  # Carga el mensaje pidiendo un n�mero
    syscall  # Muestra el mensaje

    li $v0, 5  # Prepara la syscall para leer un n�mero
    syscall  # Lee el n�mero ingresado
    move $t2, $v0  # Guarda el n�mero ingresado en $t2

    blt $t2, $t0, update_min  # Si el n�mero es menor que el valor en $t0, actualizamos el m�nimo

    j continue  # Si no es menor, seguimos con la siguiente iteraci�n

update_min:
    move $t0, $t2  # Actualizamos el valor m�nimo con el n�mero ingresado

continue:
    sub $t1, $t1, 1  # Restamos 1 a la cantidad de n�meros restantes
    bnez $t1, loop  # Si a�n hay n�meros por ingresar, seguimos en el bucle

    # Ahora mostramos el n�mero menor que encontramos
    li $v0, 4  # Prepara la syscall para imprimir texto
    la $a0, msg_menor  # Carga el mensaje de "El n�mero menor es:"
    syscall  # Muestra el mensaje

    li $v0, 1  # Prepara la syscall para imprimir un n�mero
    move $a0, $t0  # Coloca el n�mero menor en $a0
    syscall  # Muestra el n�mero menor encontrado

exit:
    li $v0, 10  # Prepara la syscall para terminar el programa
    syscall  # Llama a la syscall para salir
