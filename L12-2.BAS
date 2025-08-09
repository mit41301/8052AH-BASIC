10	REM 8255 mode set: Ports A,C = output; Port B = input
20	XBY(0FC03H)=82H
30	REM A=decoder address (0-15)
40	A=2
50	REM Write address to Port C, turn TE (PC.7) off (high)
60	XBY(0FC02H)=80H+A.OR.XBY(0FC02H)
70	REM Use edge-triggered interrupt
80	TCON=TCON.OR.4
90	DO
100	REM Wait for interrupt
110	ONEX1 500
120	WHILE 1=1
130	END

480	REM On interrupt 1, print received data
490	REM Data is at Port B, bits 4-7
500	PH0.(XBY(0FC01H).AND.0F0H)/10H
510	RETI
