
%define sys_read 0
%define sys_write 1
%define sys_open 2
%define sys_close 3


section .data
    route db 'Desktop/Encryption/keys.txt',0
    exit_msg db "Exiting",8

section .bss
    buffer resb 1024

section .text
global _start
_start:
    
    ; Open file
    mov rax,sys_open    ; Rax holds file descriptor
    mov rdi,route       ; PWD to locate the file
    mov rsi,0           ; Read only
    mov rdx,0           ; Read pnly
    syscall

    mov r12,rax         ; r12 = FD

    loop:

        ; read
        mov rax,sys_read
        mov rdi,r12
        mov rsi,buffer
        mov rdx,1024
        syscall

        ; compare rax (bytes to read) to 0, if equal jump
        cmp rax,0
        je exit

        mov r13,rax

        ; write
        mov rax,sys_write
        mov rdi,1
        mov rsi,buffer
        mov rdx,r13
        syscall
        jmp loop

exit:

    mov rax,sys_close
    syscall

    mov rax,60 
    mov rdi,0
    syscall

