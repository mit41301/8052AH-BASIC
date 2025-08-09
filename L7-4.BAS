1	REM lookup table stores the numeric value of each key
10	XBY(1F00H)=1 : REM 1
11	XBY(1F01H)=2 : REM 2
12	XBY(1F02H)=3 : REM 3
13	XBY(1F03H)=0CH :REM C
14	XBY(1F04H)=4 : REM 4
15	XBY(1F05H)=5 : REM 5
16	XBY(1F06H)=6 : REM 6
17	XBY(1F07H)=0DH :REM D
18	XBY(1F08H)=7 : REM 7
19	XBY(1F09H)=8 : REM 8
20	XBY(1F0AH)=9 : REM 9
21	XBY(1F0BH)=0EH :REM E
22	XBY(1F0CH)=0AH :REM A
23	XBY(1F0DH)=0 : REM 0
24	XBY(1F0EH)=0BH :REM B
25	XBY(1F0FH)=0FH :REM F
30	A=0
40	COUNT=3
50	PRINT "Please enter a 4-digit hex address to read: "
60	DO 
70	ONEX1 100
80	WHILE 1=1
90	END 
100	KEY=XBY(0E000H).AND.0FH: REM read the key
110	DAT=XBY(1F00H+KEY): REM find its value
120	A=A+(DAT*(16**COUNT)): REM add to the total
130	COUNT=COUNT-1: REM keep track of # of digits read
140	PH0. DAT,
150	IF COUNT=-1 THEN GOSUB 200: wait for 4 digits
160	RETI 
200	PRINT : PH0. XBY(A)," is stored at address ",A
210	PRINT "Please enter another 4-digit address to read: "
220	COUNT=3
230	A=0
240	RETI
