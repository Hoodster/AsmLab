includelib  kernel32.lib
EXTERN MessageBoxA: PROC
EXTERN WriteConsoleA: PROC
EXTERN SetConsoleTitleA: PROC
EXTERN GetForegroundWindow: PROC
EXTERN GetStdHandle: PROC
EXTERN ExitProcess: PROC

.data
STD_INPUT_HANDLE = -10
STD_OUTPUT_HANDLE = -11

hello_msq db "Hello World", 0
dummy dq 0
stdHandle dq 0
handler dq 0

.code
main PROC
push rbp
mov rbp, rsp
sub rsp, 28h

mov rcx, STD_OUTPUT_HANDLE
call GetStdHandle
mov stdHandle, rax

lea rcx, hello_msq
call SetConsoleTitleA

mov rcx, stdHandle
lea rdx, hello_msq
mov r8, sizeof hello_msq
mov r9, dummy
call WriteConsoleA

call GetForegroundWindow
mov handler, rax

mov rcx, handler
mov rdx, offset hello_msq
mov r8, offset hello_msq
mov r9, 0
and rsp, not 8
call MessageBoxA



mov rsp, rbp
pop rbp
ret
main ENDP
END
