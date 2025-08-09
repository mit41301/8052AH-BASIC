10	REM A=base address of 82C55
20	A=0FC00H
30	REM configure 8255 for all outputs
40	XBY(A+3)=80H
50	INPUT "Direction (0 or 1)? ",D
60	IF D=0 THEN XBY(A+3)=0EH ELSE XBY(A+3)=0FH
70	INPUT "Speed (0-15)? ",S
80	XBY(A)=S
90	REM bring 555's Reset (PC.6) high (off)
100	XBY(A+3)=0DH
110	XBY(A)=S
120	G=GET
130	DO : G=GET : UNTIL G<>0
140	REM Remove 555's Reset
150	XBY(A+3)=0CH
160	END
 