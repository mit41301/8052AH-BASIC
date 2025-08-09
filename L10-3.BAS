10	REM set WT to match address of DS1286 watchdog timer
20	WT=0A000H
30	DO 
40	PRINT 
50	PRINT "Select function:"
60	PRINT "Initialize and start clock 1"
70	PRINT "Display time and day 2"
80	PRINT "Set alarm 3"
90	INPUT A
100	IF A=1 THEN GOSUB 200
110	IF A=2 THEN GOSUB 1000
120	IF A=3 THEN GOSUB 2000
130	WHILE 1=1
140	END 

200	REM initialize and start clock
210	REM stop clock while initializing
220	XBY(WT+9)=XBY(WT+9).OR.80H
230	REM get time and date, convert each value to BCD and store
240	INPUT "year (0-99)? ",X
250	GOSUB 3000
260	XBY(WT+0AH)=X
270	INPUT "month (1-12)? ",X
280	GOSUB 3000
290	XBY(WT+9)=(XBY(WT+9).AND.0E0H)+X
300	INPUT "day of month (1-31)? ",X
310	GOSUB 3000
320	XBY(WT+8)=X
330	INPUT "day of week (1-7)? ",X
340	GOSUB 3000
350	XBY(WT+6)=X
360	INPUT "24-hr (0) or 12-hr (1) clock? ",TT
370	IF TT=0 THEN GOSUB 3000 ELSE GOSUB 600
380	INPUT "minutes (0-59)? ",X
390	GOSUB 3000
400	XBY(WT+2)=X
410	INPUT "seconds (0-59)? ",X
420	GOSUB 3000
430	XBY(WT+1)=X
440	XBY(WT)=0
450	PRINT "Press any key when ready to start the clock"
460	A=GET : IF A=0 THEN GOTO 460
470	XBY(WT+9)=(XBY(WT+9)).AND.7FH
480	RETURN 

500	INPUT "hour (0-23)? ",X
510	GOSUB 3000
520	XBY(WT+4)=X
530	RETURN 

590	REM set up 12-hour clock
600	INPUT "hour (1-12)? ",X
610	INPUT "AM (0) or PM (1)? ",AP
620	GOSUB 3000
630	XBY(WT+4)=X+AP*20H+TT*40H
640	RETURN 

1000	REM display current time and date
1010	REM clear TE for error-free reads
1020	XBY(WT+0BH)=XBY(WT+0BH).OR.80H
1030	REM get hours
1040	X=XBY(WT+4).AND.1FH
1050	GOSUB 3100
1060	PRINT "Time = ",X,":",
1070	REM get minutes
1080	X=XBY(WT+2)
1090	GOSUB 3100
1100	PRINT X,":",
1110	REM get seconds
1120	X=XBY(WT+1)
1130	GOSUB 3100
1140	PRINT X,
1150	IF TT=0 THEN 1220
1160	IF AP=1 THEN 1190
1170	PRINT "am"
1180	GOTO 1220
1190	PRINT "pm"
1200	PRINT 
1210	REM get month
1220	X=XBY(WT+9).AND.3FH
1230	GOSUB 3100
1240	PRINT "Date = ",X,"/",
1250	REM get day of month
1260	X=XBY(WT+8)
1270	GOSUB 3100
1280	PRINT X,"/",
1290	REM get year
1300	X=XBY(WT+0AH)
1310	GOSUB 3100
1320	PRINT X
1330	REM get day of week
1340	X=XBY(WT+6)
1350	GOSUB 3100
1360	PRINT "Day of week = ",X
1370	REM set TE when reads are done
1380	XBY(WT+0BH)=XBY(WT+0BH.OR.80H)
1390	RETURN 

2000	REM set alarm
2010	PRINT "Select alarm type:"
2020	PRINT "Once per minute (1)"
2030	PRINT "When minutes match (2)"
2040	PRINT "When hours and minutes match (3)"
2050	PRINT "When hours, minutes, and days match (4)"
2060	INPUT AF
2070	REM clear all 3 alarm mask bits
2080	XBY(WT+3)=XBY(WT+3).AND.7FH
2090	XBY(WT+5)=XBY(WT+5).AND.7FH
2100	XBY(WT+7)=XBY(WT+7).AND.7FH
2110	REM set alarm mask bits as needed
2120	IF AF<4 THEN XBY(WT+7)=XBY(WT+7).OR.80H
2130	IF AF<3 THEN XBY(WT+5)=XBY(WT+5).OR.80H
2140	IF AF=1 THEN XBY(WT+3)=XBY(WT+3).OR.80H
2150	IF AF>1 THEN INPUT "Minute? ",M
2160	IF AF>2 THEN INPUT "Hour? ",H
2170	IF AF=4 THEN INPUT "Day? ",D
2180	REM store alarm settings
2190	IF AF1 THEN X=M : GOSUB 3000 : XBY(WT+3)=80H+X
2200	IF AF2 THEN X=H : GOSUB 3000 : XBY(WT+5)=80H+X
2210	IF AF=4 THEN X=D : GOSUB 3000 : XBY(WT+7)=80H+X
2220	REM turn on alarm
2230	REM time-of-day alarm is edge-triggered, low-going, INTA
2240	XBY(WT+0BH)=0D8H
2250	DO 
2260	ONEX1 3200
2270	WHILE 1=1
2280	RETURN 

3000	REM convert decimal to BCD
3010	X=INT(X/10)*16+X-INT(X/10)*10
3020	RETURN 

3100	REM convert BCD to decimal
3110	X=INT(X/16)*10+(X/16-INT(X/16))*16
3120	RETURN 

3200	REM alarm interrupt routine
3210	PRINT "ALARM"
3220	GOSUB 1000
3230	RETI
 