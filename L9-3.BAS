10	REM set A to address of ADC
20	A=0C000H
30	REM use single-ended mode
40	REM set C to channel to read (1-8)
50	C=2
60	XBY(A)=8+C-1
70	VREF=2.5
80	B=XBY(A)
90	T=INT(VREF*B*100/255+.5)
100	PRINT "Temperature = ",T
110	PRINT "Press any key to take another measurement"
120	D=GET : IF D=0 THEN GOTO 120
130	GOTO 60
140	END
 