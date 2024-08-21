format PE GUI 4.0
entry start

include 'INCLUDE\win32a.inc'
include 'INCLUDE\aes\aes.inc'
include 'INCLUDE/aes/aes.asm'

TEXTSIZE equ 3*BLOCK_SIZE

section '.data' data readable writeable

 _caption       db 'Client application',0
 _igang         db 'The client has started very well.',13,10,'It is now going to connect to your own computer',0
 _hostname      db 'Wrong hostname',0

  hostname      db '127.0.0.1',0

  hSock         dd ?

  saddr         sockaddr_in
  sizesaddr     = sizeof.sockaddr_in

  buffer rb 0x3000

  sender db 'This is sent from client',13,10
         rb 0x100

  wsadata WSADATA

    enc_msg   rb TEXTSIZE
  dec_msg   rb TEXTSIZE

  key128    db 0x03, 0x02, 0x01, 0x00, 0x07, 0x06, 0x05, 0x04,\
               0x0b, 0x0a, 0x09, 0x08, 0x0f, 0x0e, 0x0d, 0x0c

  clear_msg db 'Good message from client',\
               0x0d, 0x0a, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

section '.code' code readable executable

  start:
      stdcall encAES, TEXTSIZE, clear_msg, enc_msg, key128
;    stdcall decAES, TEXTSIZE, enc_msg, dec_msg, key256
       invoke WSAStartup,0101h,wsadata  ; initialiserer winsock-bibliotek

       invoke ws_gethostbyname, hostname
       or     eax,eax
       jz     bad_hostname

       virtual at eax
               .host hostent
       end virtual

       mov    eax, [.host.h_addr_list]
       mov    eax, [eax]
       mov    eax, [eax]
       mov    [saddr.sin_addr], eax
;       invoke MessageBox, 0, _igang, _caption, 0

       mov    al, 00
       mov    ah, 210          ; port 10
       mov    [saddr.sin_port],ax
       mov    [saddr.sin_family],AF_INET


       invoke  ws_socket, AF_INET, SOCK_STREAM, IPPROTO_TCP
       mov     [hSock], eax
       xchg    eax, esi
       invoke  ws_connect, esi, saddr, sizesaddr
       mov     ebx, buffer
       invoke  ws_send,esi,enc_msg,0x30,0
;       invoke  ws_send,clear_msg,0x30,0

       invoke  ws_recv, esi, ebx, 300h, 0

       stdcall decAES, TEXTSIZE, buffer, dec_msg, key128

       invoke  MessageBox,0, dec_msg, _caption,0
;       invoke  MessageBox,0, buffer, _caption,0

       invoke  ws_closesocket,esi
       invoke  WSACleanup
       jmp     stopp

  bad_hostname:
        invoke MessageBox,0,_hostname,_caption,0
        jmp stopp

  stopp:
        invoke ExitProcess,0



section '.idata' import data readable writeable

  library kernel,'KERNEL32.DLL',\
          winsock,'WSOCK32.DLL',\
          user,'USER32.DLL'

  import kernel,\
         ExitProcess,'ExitProcess'

  import winsock,\
        WSAStartup,'WSAStartup',\
        ws_socket,'socket',\
        ws_connect,'connect',\
        ws_gethostbyname,'gethostbyname',\
        ws_send,'send',\
        ws_recv,'recv',\
        ws_closesocket,'closesocket',\
        WSACleanup,'WSACleanup'

  import user,\
        MessageBox,'MessageBoxA'

  IPPROTO_TCP  = 6
