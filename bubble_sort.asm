


section .data
    arr db 6, 8, 2, 1, 5
    arr_len db 5


section .bss
    buf resb 5


section .text
    global _start
        _start:
            mov r9,0           ;  Holds n index integer
            mov r10,1          ;  Holds n+1 index integer
            mov rcx,0           ; main counter to loop and compare each number 5 times !
           
            jmp while_loop

        while_loop:

            ; clear registers
            xor rax,rax
            xor rbx,rbx

            mov al, [arr + r9]
            mov bl, [arr + r10]
            cmp al,bl
            jg swap_pos
            jng inc_reg

    
        swap_pos:
        
            mov r11b,0
            mov r15b,0

            mov r11b,[arr + r9]
            mov r15b,[arr + r10]
        
            mov byte [arr + r9],0
            mov byte [arr + r10],0

            mov [arr + r9],r15b
            mov [arr + r10],r11b


            jmp inc_reg


        inc_reg:
            inc r9
            inc r10

            ; Clear Registers
            xor rax,rax
            xor rbx,rbx
             
            ; Jump if R10 Register greater than 5
            cmp r10,5
            je counter
            jng while_loop
        

        counter:
        ; Clearing working registers
           ; can either use xor or mov to init the value to zero
            mov r9,0
            mov r10,1
            mov rax,0
            mov rbx,0

            inc rcx
            cmp rcx,5
            je reset
            jne while_loop





        reset:
            ; Clear out registers
            xor rax,rax
            xor rbx,rbx
            xor rcx,rcx
            xor r9,r9
            xor r10,r10
            xor r11b,r11b
            xor r15b,r15b
            xor r12,r12
            xor rdx,rdx

            jmp buffer_res


        buffer_res:
            mov al,[arr + rdx]
            add al,'0'
            mov [buf + rdx],al
            cmp rdx,4
            jne increment_counter
            je print_number
        
        increment_counter:
            inc rdx
            jmp buffer_res
            

        print_number:
            mov rax,1
            mov rdi,1
            lea rsi,[buf + r12]
            xor rdx,rdx
            mov rdx,1
            syscall

            jmp buf_inc

        buf_inc:
            cmp r12,4
            je exit

            inc r12
            jmp print_number
            

        exit:
            mov rax,60
            mov rdi,0
            syscall

    
