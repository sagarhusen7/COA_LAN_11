 ORG 100h

.DATA
    result dw 1
    msg_prompt db 'Enter a single-digit number (0-9): $'
    msg_result db 0Dh, 0Ah, 'Factorial is: $'
    error_msg db 0Dh, 0Ah, 'Error: Enter a single-digit number.$'

.CODE
start:
    mov ah, 09h
    lea dx, msg_prompt
    int 21h

    mov ah, 01h
    int 21h
    sub al, '0'

    cmp al, 9
    ja error
    cmp al, 0
    jl error
    jmp calculate

error:
    mov ah, 09h
    lea dx, error_msg
    int 21h
    jmp exit

calculate:
    mov bl, al
    mov ax, 1

factorial_loop:
    cmp bl, 1
    jbe end_factorial

    mul bl
    dec bl
    jmp factorial_loop

end_factorial:
    mov result, ax

    mov ah, 09h
    lea dx, msg_result
    int 21h

    mov ax, result
    call display_number

exit:
    mov ah, 4Ch
    int 21h

display_number proc
    mov bx, 10
    xor cx, cx

next_digit:
    xor dx, dx
    div bx
    add dl, '0'
    push dx
    inc cx
    test ax, ax
    jnz next_digit

display_loop:
    pop dx
    mov ah, 02h
    int 21h
    loop display_loop
    ret
display_number endp