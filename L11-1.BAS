10	REM A=base address of 82C55
20	A=0FC00H
30	REM configure 8255 for all outputs
40	XBY(A+3)=80H
50	REM bring MT8808's Reset low (off)
60	XBY(A+3)=0EH
70	XBY(A)=0
80	DO
90	INPUT "Open (0), close (1), or reset all (2)? ",Z
100	IF Z=2 THEN GOSUB 300
110	IF Z THEN GOSUB 400
120	WHILE 1=1
130	END
290	REM reset all switches by toggling Reset
300	XBY(A+3)=0FH
310	XBY(A+3)=0EH
320	RETURN
400	PRINT "Enter inputs to connect or open: "
410	INPUT "X (0-7)? ",X
420	INPUT "Y (0-7)? ",Y
430	REM write to MT8808 to open or close selected switch
440	B=X+Y*8+Z*40H
450	XBY(A)=B
460	XBY(A)=B+80H
470	XBY(A)=B
480	RETURN
