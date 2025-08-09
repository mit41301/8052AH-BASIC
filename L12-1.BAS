10	REM 8255 mode set: Ports A,C = output, Port B = input
20	XBY(0FC03H)=82H
30	DO
40	INPUT "Enter the decoder's address (0-15): ",A
50	INPUT "Enter the data to send (0-15): ",D
60	REM Write the address and data information to Port A
70	XBY(0FC00H)=(D*10H+A)
80	REM Toggle TE (Port C, bit 7)
90	XBY(0FC03H)=0EH
100	XBY(0FC03H)=0FH
110	WHILE 1=1
120	END
