; nasm -f elf cpuname.asm
; ld -o cpuname cpuname.o

global _start

section .bss
    namestring resb 48

section .text
_start:

    mov eax, 80000000h
    cpuid
    cmp eax, 80000004h
    jb exit
   
    mov edi, namestring

    mov eax, 80000002h
    cpuid
    call savestring

    mov eax, 80000003h
    cpuid
    call savestring

    mov eax, 80000004h
    cpuid
    call savestring

    mov ecx, namestring
    mov edx, 48
    mov ebx, 1
    mov eax, 4
    int 80h

exit:
    mov eax, 1
    int 80h
;----------------

;----------------
savestring:
    stosd
    mov eax, ebx
    stosd
    mov eax, ecx
    stosd
    mov eax, edx
    stosd
    ret
;----------------