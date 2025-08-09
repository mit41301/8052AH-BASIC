10	REM clear flip-flop
20	XBY(0E400H)=0
30	XBY(0E400H)=1
40	DO 
50	REM read port
60	A=XBY(0E000H)
70	REM see if bit 0 is set
80	IF A.AND.1=1 THEN GOSUB 200
90	WHILE 1=1
100	END 
200	PRINT "vibration alarm
"210	REM clear flip-flop
220	XBY(0E400H)=0
230	XBY(0E400H)=1
240	RETI
 