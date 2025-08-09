10	A=0E000H: REM address of LEDs
20	L=0FFH: REM initial control value for LEDs
20	XBY(A)=L: REM turn off all LEDs
30	DO
40	INPUT "Select an LED (0-7): ",B
50	INPUT "Turn on or off (0=off, 1=on)? ",C
60	IF C=0 THEN L=L.AND.(0FFH-2**B)
70	IF C=1 THEN L=L.OR.2**B
90	XBY(A)=L
80	WHILE 1=1
90	END
