10	PRINT "copying BASIC-52 from ROM to RAM at 8000h..." 
20	FOR I=0 TO 1FFFH 
30	XBY(I+8000H)=CBY(I) 
40	NEXT I 
50	PRINT "verifying..." 
60	X=0 
70	FOR I=0 TO 1FFFH 
80	IF XBY(I+8000H)<>CBY(I) THEN GOSUB 120 
90	NEXT I 
100	IF X=0 THEN PRINT "Copy successful" 
110	END 
120	PH0. "Error at location ",I 
130	X=1 
140	RETURN
 