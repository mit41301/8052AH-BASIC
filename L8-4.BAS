10	REM address of 8255, Port A
20	A=0FC00H
30	REM address of 8255, Port C
40	C=A+2
50	REM address of 8255, Control port
60	X=A+3
70	REM Control word for Enable (PC.5)
80	E=0AH
90	REM Control word for RW (PC.6)
100	RW=0CH
110	REM Control word for RS (PC.4)
120	RS=8

130	REM Initialize LCD module
140	REM initial values
150	XBY(X)=80H: REM Ports A,B,&C are outputs
160	XBY(X)=E : REM E=1
170	XBY(X)=RW : REM RW=1
180	XBY(X)=RS : REM RS=1

190	REM function set: 8-bit interface, 3 times
200	REM toggle E after each instruction
210	XBY(A)=30H
220	XBY(X)=E+1:XBY(X)=E
230	XBY(A)=30H
240	XBY(X)=E+1:XBY(X)=E
250	XBY(A)=30H
260	XBY(X)=E+1:XBY(X)=E
270	REM function set to match module
280	XBY(A)=38H
290	XBY(X)=E+1:XBY(X)=E
300	REM display on
310	XBY(A)=0CH
320	XBY(X)=E+1:XBY(X)=E
330	REM clear display
340	XBY(A)=01H
350	XBY(X)=E+1:XBY(X)=E
360	REM entry mode set
370	XBY(A)=06H
380	XBY(X)=E+1:XBY(X)=E
390	REM display "LINE 1", "LINE 2"
400	D=ASC(L):GOSUB 800
410	D=ASC(I):GOSUB 800
420	D=ASC(N):GOSUB 800
430	D=ASC(E):GOSUB 800
440	D=20H:GOSUB 800
450	D=ASC(1):GOSUB 800
460	I=0C0H
470	GOSUB 900
480	D=ASC(L):GOSUB 800
490	D=ASC(I):GOSUB 800
500	D=ASC(N):GOSUB 800
510	D=ASC(E):GOSUB 800
520	D=20H:GOSUB 800
530	D=ASC(2):GOSUB 800
600	END

790	REM write data to the display
800	XBY(X)=RS+1
810	XBY(X)=RW
820	XBY(A)=D
830	XBY(X)=E+1:XBY(X)=E
840	RETURN

890	REM write an instruction to the display
900	XBY(X)=RS
910	XBY(A)=I
920	XBY(X)=E+1:XBY(X)=E
930	RETURN
