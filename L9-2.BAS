10	REM use single-ended mode
20	REM set A to address of ADC
30	A=0C000H
40	FOR I=1 TO 8
50	XBY(A)=8+I-1
60	PRINT "Channel ",I," = ", : PH0. XBY(A)
70	NEXT I
80	END
 