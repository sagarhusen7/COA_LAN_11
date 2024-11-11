.model small
.stack 100h

.data
    msg db 'Enter the value of n (0-9): $'  ; Prompt message
    fib_res db ?                            ; Variable to store Fibonacci result
    n db ?                                  ; Variable to store user input
    result_msg db 0Dh, 0Ah, 'Fibonacci term: $'  ; Result display message
    result db '00$', 0Dh, 0Ah               ; Placeholder for the result to be displayed

.code
main:
    mov ax, @data
    mov ds, ax

    ; Display the prompt message
    mov ah, 09h
    lea dx, msg
    int 21h

    ; Read a single character input for `n`
    mov ah, 01h
    int 21h
    sub al, '0'                ; Convert ASCII to integer
    mov n, al                  ; Store the input in `n`

    ; Check base cases for Fibonacci
    mov al, n
    cmp al, 0
    je fib_zero                ; If n = 0, jump to fib_zero
    cmp al, 1
    je fib_one                 ; If n = 1, jump to fib_one

    ; Calculate Fibonacci for n > 1
    mov cl, al                 ; Set counter `cl` to n
    mov al, 1                  ; First Fibonacci term
    mov bl, 0                  ; Second Fibonacci term
    dec cl                     ; Decrement counter by 1 (n-1)

fib_loop:
    mov ah, al                 ; Store current term in `ah`
    add al, bl                 ; Next term = current + previous
    mov bl, ah                 ; Update `bl` to previous term
    dec cl                     ; Decrement counter
    jnz fib_loop               ; Loop until `cl` becomes zero

    ; Store the result in `fib_res`
    mov fib_res, al

display_result:
    ; Display result message
    mov ah, 09h
    lea dx, result_msg
    int 21h

    ; Convert the result to ASCII for display
    mov al, fib_res
    aam                        ; Split result into `ah` and `al` (BCD format)
    add ah, '0'
    add al, '0'
    mov result[0], ah          ; Store tens digit in result
    mov result[1], al          ; Store units digit in result

display_final:
    ; Display final result
    lea dx, result
    mov ah, 09h
    int 21h

    ; Exit program
    mov ah, 4Ch
    int 21h

fib_zero:
    ; Fibonacci of 0 is 0
    mov fib_res, 0
    jmp display_result

fib_one:
    ; Fibonacci of 1 is 1
    mov fib_res, 1
    jmp display_result
