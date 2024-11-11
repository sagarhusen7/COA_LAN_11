 ORG 100h
.DATA
    num1 DB 15
    num2 DB 10
    gcd_res DB 0
    lcm_res DW 0
    resultMsg DB 'The LCM is: $'
.CODE
main:
    MOV AL, num1
    MOV BL, num2
    CALL gcd
    MOV gcd_res, AL
    MOV AL, num1
    MOV AH, 0
    MOV DL, num2
    MUL DL
    MOV CL, gcd_res
    DIV CL
    MOV lcm_res, AX
    LEA DX, resultMsg
    MOV AH, 09h
    INT 21h
    MOV AX, lcm_res
    CALL PrintDecimal
    MOV AH, 4Ch
    INT 21h
gcd PROC
    CMP BL, 0
    JE end_gcd
gcd_loop:
    MOV AH, 0
    DIV BL
    MOV AL, BL
    MOV BL, AH
    CMP BL, 0
    JNE gcd_loop
end_gcd:
    RET
gcd ENDP
PrintDecimal PROC
    MOV CX, 10
    MOV BX, 0
decimal_loop:
    XOR DX, DX
    DIV CX
    PUSH DX
    INC BX
    CMP AX, 0
    JNE decimal_loop
print_digits:
    POP DX
    ADD DL, '0'
    MOV AH, 02h
    INT 21h
    DEC BX
    JNZ print_digits
    RET