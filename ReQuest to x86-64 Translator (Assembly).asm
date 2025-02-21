section .text
global compile_request_code

compile_request_code:
    ; Save registers
    push rdi
    push rsi
    push rdx

    ; Translate 'lock mem(0x0040, 64)'
    mov rdi, 0x0040
    lock mov qword [rdi], 0

    ; Translate 'thread.start(4)'
    mov ecx, 4
    rep lodsb

    ; Translate 'cycle.sync(pulse:32)'
    rdtscp
    shl rax, 32

    ; Translate 'impeller.flow(x, override: manual)'
    mov eax, 128
    add eax, [rbx]

    ; Translate 'error.check(y)'
    cmp eax, 0
    jz error_handler

    ; Translate 'export state("computed-result", y)'
    mov [computed_result], eax

error_handler:
    mov rax, 60    ; syscall: exit
    xor rdi, rdi   ; status: 0
    syscall

    ; Restore registers
    pop rdx
    pop rsi
    pop rdi
    ret
