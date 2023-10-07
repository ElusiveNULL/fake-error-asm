global  _start

section .text
    _start:     
printmsg:
        MOV       RAX, 1
        MOV       RDI, 1
        MOV       RSI, msg
        MOV       RDX, msglen
        SYSCALL

        CMP RSP, 1
        JE exit

        MOV RAX, 2
        MOV RDI, fd
        XOR RSI, RSI
        SYSCALL

        CMP RAX, 0
        JNS printfd
        JMP exit

printfd:
        MOV RDI, RAX
        XOR RAX, RAX
        MOV RSI, buffer
        MOV RDX, 0x1000
        SYSCALL

        MOV RAX, 1
        MOV RDI, 1
        MOV RSI, buffer
        MOV RDX, 0x1000
        SYSCALL

        MOV RSP, 1
        JMP printmsg

exit:
        MOV RAX, 60
        MOV RDI, 1
        SYSCALL
section .bss
    buffer: resb 0x1000

section .rodata
    msg:    db    10, "FATAL: Overflow in /dev/sys/kernel0", 10
    msglen: equ $ - msg
    fd: db "/dev/urandom", 0