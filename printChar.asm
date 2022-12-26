section .data
buff: resb 0x1

section .text
global printChar

printChar:
    push rax
    push rbx
    push rcx
    push rdx

    mov [buff], al

    mov rax, 4 ; Linux syscall to print string
    mov rbx, 1 ; Tell the syscall to print to stdout
    mov rcx, buff ; Store address of string for syscall
    mov rdx, 1 ; Store length of string for syscall
    int 0x80

    pop rdx
    pop rcx
    pop rbx
    pop rax

    ret