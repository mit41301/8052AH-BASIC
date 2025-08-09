10	REM address of 8255 Port A
20	A=0FC00H
30	REM address of 8255 control word
40	X=A+3
50	REM set 8255 for all outputs
60	XBY(X)=80H
70	REM set WR
80	XBY(X)=9
90	REM write to each digit
100	FOR M=0 TO 7
110	REM step through all numbers at each digit
120	FOR I=0 TO 8
130	REM add 10h to turn off decimal point
140	D=I+10H+M*20H
150	GOSUB 500
160	REM delay to display each digit
170	K=500
180	FOR J=1 TO K : NEXT J
190	NEXT I
200	NEXT M
210	END 

490	REM write data to port A and toggle W (PC.4)
500	XBY(A)=D
510	XBY(X)=8H
520	XBY(X)=9
530	RETURN 