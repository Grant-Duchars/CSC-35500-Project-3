; Author: Grant Duchars
section .data
prompt: db "Enter a number: "
buff: resb 25

section .text
global promptAndParse

promptAndParse:
    push rbx
    push rcx
    push rdx

    ; print prompt
    mov rdx, buff-prompt
    mov rcx, prompt
    mov rbx, 1
    mov rax, 4
    int 0x80

    ; read input
    mov rax, 3
    mov rbx, 0
    mov rcx, buff
    mov rdx, 25
    int 0x80

    ; parse input
    xor rax, rax ; Storing integer
    xor rbx, rbx ; String index
    xor rcx, rcx

    extractNextDigit:
    mov cl, [buff+rbx] ; Get next character
    cmp rcx, 0xA ; Check for new line
    je done ; if next equals \n
    
    imul rax, 10
    sub rcx, 0x30
    add rax, rcx
    inc rbx
    jmp extractNextDigit

    done:
    pop rdx
    pop rcx
    pop rbx
    ; return value is in rax

    ret