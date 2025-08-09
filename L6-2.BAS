5	REM variable A contains the last data written to 0E400h
10	INPUT "Enter a bit to set or clear (0-7) :",X
20	INPUT "Enter 1 to set, 0 to clear :",Y
30	IF Y=1 THEN A=A.OR.2**X
40	IF Y=0 THEN A=A.AND.0FFH-2**X
50	XBY(0E400H)=A
60	END
