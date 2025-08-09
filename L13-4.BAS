10	REM Begins by calculating and storing sine values
20	REM for 256 locations along a sine wave.
30	REM Line 100 converts a position in the sine wave
40	REM (0-255) to the radians required by the sine
50	REM operator: (0.0246 = 2*PI/256). Adding 1 to the 
60	REM sines makes all values positive, from 0 to +2.
70	REM Multiplying by 127.5 results in values that 
80	REM range from 0 to 255.
90	FOR I=0 TO 255
100	XBY(3000H+I)=INT((SIN(I*.0246)+1)*127.5+.5)
110	NEXT I
120	PRINT "Sine values are stored in RAM (3000h-30FFh)"
130	PRINT "Press Control+C to quit"
140	REM Write the values in sequence to E400h
150	DO 
160	FOR I=3000H TO 30FFH
170	XBY(0E400H)=XBY(I)
180	NEXT I
190	WHILE 1=1
200	END 
