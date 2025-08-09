10	REM configure all ports as outputs
20	XBY(0FC03H)=80H
30	REM write each value to the display in sequence
40	FOR I=0 TO 9
50	XBY (0FC00H)=I
60	REM delay after each write
70	FOR J=1 TO 500:NEXT J
80	NEXT I
90	END
