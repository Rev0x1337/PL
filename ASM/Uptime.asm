format PE GUI 4.0
entry start

include 'c:\fasm\include\win32ax.inc'


section '.code' code readable executable

start:

        invoke  GetTickCount,0
        invoke  ExitProcess,0

section '.idata' import data readable writeable

library kernel32,"kernel32.dll",\
        user32,  "user32.dll",\
        ntdll,   "ntdll.dll"

include "c:\fasm\INCLUDE\api\kernel32.inc"
include "c:\fasm\INCLUDE\api\user32.inc"

import  ntdll,\
        NtQuerySystemInformation,'NtQuerySystemInformation'
