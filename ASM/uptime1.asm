format PE GUI 4.0
entry start

include 'win32a.inc'

section '.data' data readable writeable

struct SYSTEM_TIME_INFORMATION
       liKeBootTime       dq ?
       liKeSystemTime     dq ?
       liExpTimeZoneBias  dq ?
       uCurrentTimeZoneId dd ?
       dwReserved         dw ?
ends

SystemTime   SYSTEM_TIME_INFORMATION
ftSystemBoot FILETIME
stSystemBoot SYSTEMTIME

GET_SYSTEM_TIME_INFORMATION = 3

buff rb 500

section '.code' code readable executable

start:
;       mov eax,
        invoke NtQuerySystemInformation,GET_SYSTEM_TIME_INFORMATION,SystemTime,sizeof.SYSTEM_TIME_INFORMATION,0

       
        mov eax,dword [SystemTime.liKeSystemTime]
        mov edx,dword [SystemTime.liKeSystemTime+4]
        
        sub eax,dword [SystemTime.liKeBootTime]
        sbb edx,dword [SystemTime.liKeBootTime+4]

        invoke FileTimeToLocalFileTime,SystemTime.liKeBootTime,ftSystemBoot
        invoke FileTimeToSystemTime,ftSystemBoot,stSystemBoot

        xor eax,eax

        mov ax,[stSystemBoot.wSecond]
        push eax

        mov ax,[stSystemBoot.wMinute]
        push eax

        mov ax,[stSystemBoot.wHour]
        push eax

        mov ax,[stSystemBoot.wYear]
        push eax

        mov ax,[stSystemBoot.wMonth]
        push eax

        mov ax,[stSystemBoot.wDay]
        push eax

        invoke wsprintf, buff, mask

        invoke MessageBox,0,buff,head,MB_OK

        invoke ExitProcess,0

mask db 'Date: %02d.%02d.%04d',13,10,'Time: %02d:%02d:%02d',0
head db 'System started',0

section '.idata' import data readable writeable

library kernel32,"kernel32.dll",\
        user32,  "user32.dll",\
        ntdll,   "ntdll.dll"

include "apia\kernel32.inc"
include "apia\user32.inc"

import  ntdll,\
        NtQuerySystemInformation,'NtQuerySystemInformation'
