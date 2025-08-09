10	REM set XTAL to match your crystal's frequency
20	XTAL=12000000
30	REM set and initialize clock
40	GOSUB 200
50	REM increment clock variables once per minute
60	DO 
70	ONTIME 60,500
80	WHILE 1=1
90	END 
200	PRINT "Please enter the current time:"
210	INPUT "AM (0) or PM (1)? ",AP
220	INPUT "Hour (1-12)? ",H
230	INPUT "Minutes (0-59)? ",M
240	INPUT "Seconds (0-59)? ",S
250	REM initialize clock to current seconds
260	TIME=S
270	REM start clock
280	CLOCK 1
290	RETURN 
500	REM increment and display time once per minute
510	REM reset seconds
520	TIME=0
530	REM increment minutes
540	M=M+1
550	IF M=60 THEN GOSUB 700
560	REM display current time
570	PRINT "the time is :"
580	PRINT H,"hours"
590	PRINT M,"minutes"
600	IF AP=0 THEN PRINT " AM" ELSE PRINT " PM"
610	RETI 
700	REM once/hour timekeeping
710	REM reset minutes
720	M=0
730	REM increment hours
740	H=H+1
750	REM at 12:00, toggle am/pm
760	IF H=12 THEN AP=A
770	REM at 1:00, reset hours
780	IF H=13 THEN H=1
790	RETURN
