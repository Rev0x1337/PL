; EAX -> PEB
mov eax, [fs:0x30]
; EAX -> PEB_LDR_DATA
mov eax, [eax+0x0C]
; EBX -> ININITIALIZATIONORDERMODULELIST
mov ebx, [eax+0x1C]
invoke getstdhandle, STD_OUTPUT_HANDLE
