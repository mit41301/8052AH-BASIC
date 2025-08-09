10	PORT1=0FBH
20	T=1
30	INPUT "Direction (0 or 1)? ",D
40	INPUT "High (on) pulse width (25 to 0FFFFh)? ",H
50	INPUT "Low (off time) pulse width (25 to 0FFFFh)? ",L
60	IF D=0 THEN PORT1=PORT1.AND.0FEH ELSE PORT1=PORT1.OR.1
70	PRINT "Press any key to end program"
80	DO 
90	PWM H,L,T
100	G=GET
110	UNTIL G<>0
120	PORT1=PORT1.AND.0FBH
130	END
 