section .text
global debug_dump_registers

debug_dump_registers:
    push rax
    push rbx
    push rcx
    push rdx

    mov rax, 1          ; syscall: write
    mov rdi, 1          ; stdout
    lea rsi, reg_dump   ; message pointer
    mov rdx, 64         ; length
    syscall

    pop rdx
    pop rcx
    pop rbx
    pop rax
    ret

section .data
reg_dump db "Register Dump: RAX=%d, RBX=%d, RCX=%d, RDX=%d", 0
