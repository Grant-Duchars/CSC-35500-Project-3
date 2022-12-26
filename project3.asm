; Author: Grant Duchars
section .data
string_start: db "The GCD of "
string_middle: db " and "
string_end: db " is "

section .text
global _start
extern promptAndParse
extern printRAX
extern printChar

_start:
    
    ; Get A
    call promptAndParse
    push rax

    ; Get B
    call promptAndParse
    push rax

    ; Print "The GCD of "
    mov rdx, 11
    mov rcx, string_start
    mov rbx, 1
    mov rax, 4
    int 0x80

    ; Print A
    pop rbx
    pop rax
    call printRAX
    push rax
    push rbx

    ; Print " and "
    mov rdx, 5
    mov rcx, string_middle
    mov rbx, 1
    mov rax, 4
    int 0x80

    ; Print B
    pop rax
    call printRAX
    push rax

    ; Print " is "
    mov rdx, 4
    mov rcx, string_end
    mov rbx, 1
    mov rax, 4
    int 0x80
    
    ; Calculate gcd
    pop rbx
    pop rax
    gcd:
    cmp rbx, 0
    jne else_if
    jmp done

    else_if:
    cmp rax, rbx
    jge else
    push rax
    mov rax, rbx
    pop rbx
    jmp gcd

    else:
    xor rdx, rdx
    div rbx
    mov rax, rbx
    mov rbx, rdx
    jmp gcd

    done:
    call printRAX

    ; Print new line
    mov rax, 0xA
    call printChar

    ; return to linux
    mov rax, 1
    mov rbx, 0
    int 0x80