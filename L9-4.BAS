10	REM set A to address of ADC
20	A=0C000H
30	REM set C to channel to read (1-8)
40	C=8
50	REM use single-ended mode, select channel, start convert
60	XBY(A)=8+C-1
70	REM FS=full-scale voltage (5V)/full-sun output (4.75V)
80	FS=1.05
90	B=XBY(A)
100	T=INT(FS*B*100/255+.5)
110	PRINT "Solar energy = ",T," percent of full sun"
120	PRINT "press any key to take another measurement"
130	D=GET : IF D=0 THEN GOTO 130
140	GOTO 60
150	END
 