10	REM A=address of output port
20	A=0E400H
30	DO
40	INPUT "Speed (1-15)? ",S
50	INPUT "Mode (1=wave, 2=2-phase, 3=1/2-step, 4=stop)?",M
60	INPUT "Direction (0=Clockwise, 1=Counterclockwise)? ",D
70	IF M=1 THEN X=4
80	IF M=2 THEN X=0
90	IF M=3 THEN X=2
100	IF M=4 THEN X=6
110	XBY(A)=S+(X+D)*10H
120	WHILE 1=1
130	END
