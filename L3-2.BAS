10	INPUT "Enter a bit to set or clear (0-2, 4-7) :",X
20	IF X=3 THEN PRINT "Do not change bit 3!" : GOTO 10
30	INPUT "Enter 1 to set, 0 to clear :",Y
40	IF Y=1 THEN PORT1=PORT1.OR.2**X
50	IF Y=0 THEN PORT1=PORT1.AND.0FFH-2**X
60	END
