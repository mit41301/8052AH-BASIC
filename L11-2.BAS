10	REM A=address of output port
20	A=0E400H
30	DO 
40	FOR I=0 TO 7
50	XBY(A)=I
60	PRINT "Gain = ",I
70	PRINT "Press any key to continue...
"80	G=GET
90	DO : G=GET : UNTIL G<>0
100	NEXT I
110	WHILE 1=1
120	END
 