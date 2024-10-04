Option Explicit
Dim s, d, addr  ' Определение переменных
WScript.StdOut.Write( "Last four symbols: ")
s = WScript.StdIn.Read(4)

d=0
addr=0

    d=asc(Mid(s,1,1))
	d=(d-asc("A"))*26*26*26*4
	addr=d
	d=asc(Mid(s,2,1)) 
	d=(d-asc("a"))*26*26*4
	addr=addr+d
	d=asc(Mid(s,3,1))
	d=(d-asc("a"))*26*4
	addr=addr+d

	d=asc(Mid(s,4,1))
	d=(d-asc("a"))*4
	addr=(addr+d)
	
WScript.Echo addr
