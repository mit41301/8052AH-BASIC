10	PORT1 = PORT1.OR.3 :REM set bits high to use as inputs 	
20	PRINT "Please press switch P1.0 or P1.1"
30	DO
40	A=PORT1.AND.3 :REM look at bits 0 and 1 only
50	UNTIL A<3
60	IF A=1 THEN S=1
70	IF A=2 THEN S=0
80	PRINT "switch P1.",S," pressed"
90	END
