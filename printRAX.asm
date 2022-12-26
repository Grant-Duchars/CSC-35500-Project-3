section .text
global printRAX
extern printChar

printRAX:
    ; Protect what is currently in the registers
    push rax
    push rbx
    push rcx
    push rdx

    ; Jump if rax is a positive number
    cmp rax, 0x0
    jge printUnsigned

    ; Print out a minus sign
    push rax
    mov al, "-"
    call printChar
    pop rax

    ; Convert rax to a positive number
    neg rax

    printUnsigned:
    ; Set rcx to zero to use for counting
    xor rcx, rcx

    extractNextDigit:
    ; Divide rax by ten
    mov rbx, 0xA
    xor rdx, rdx
    div rbx
    ; Put extracted digit on the stack (remainder)
    push rdx
    ; Count number of digits we extract
    inc rcx
    ; Loop until we've extracted all digits
    cmp rax, 0x0
    jne extractNextDigit

    printNextDigit:
    ; Collect extracted digit from stack
    pop rax
    ; Convert digit to correct ascii character
    add al, 0x30
    call printChar
    ; Loop for number of times we extracted a digit
    dec rcx
    jnz printNextDigit

    pop rdx
    pop rcx
    pop rbx
    pop rax

    ret