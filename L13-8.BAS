10	PRINT "enter device type: "
20	PRINT "EPROM 50-msec 1"
30	PRINT "EPROM Intelligent 2"
40	PRINT "EEPROM or NV RAM 3"
50	PRINT "quit 4"
60	INPUT T

70	REM set pulse width for device type
80	REM W = pulse width in milliseconds
90	IF T=1 THEN W=.05
100	IF T=2 THEN W=.001
110	IF T=3 THEN W=.0005
120	IF T=4 THEN GOTO 470

130	REM calculate and store pulse width
140	B=(65536-(W*XTAL/12)) : GOSUB 500
150	DBY(40H)=BH : DBY(41H)=BL

160	REM set up for intelligent programming or not
170	I=DBY(26H)
180	IF W=.001 THEN DBY(26H)=I.OR.8 ELSE DBY(26H)=I.AND.0F7H

190	INPUT "starting address of data to copy (source)? ",S
200	IF S<200H OR S>0FFFFH THEN GOTO 190

210	INPUT "ending address of data to copy (source)? ",E
220	IF E<S OR E>0FFFFH THEN GOTO 210

230	INPUT "starting address to program (destination)? ",P
240	IF P<MTOP OR P>0FFFFH THEN GOTO 230

250	REM calculate and store number of bytes to program
260	B=(E-S)+1 : GOSUB 500 : DBY(1FH)=BH : DBY(1EH)=BL

270	REM store starting address of destination-1
280	B=P-1 : GOSUB 500 : DBY(1AH)=BH : DBY(18H)=BL
290	PH0. "eprom low = ",BL
300	PH0. "eprom high = ",BH

310	REM store starting address of source
320	B=S : GOSUB 500 : DBY(1BH)=BH : DBY(19H)=BL
330	PH0. "ram low = ",BL
340	PH0. "ram high = ",BH

350	PRINT "press ENTER to begin programming"
360	X=GET : IF X<>0DH THEN 360

370	REM program the EPROM
380	PRINT "programming in progress..."
390	PGM 

400	REM check for errors
410	IF (DBY(1EH).OR.DBY(1FH))=0 THEN PRINT "programming OK" : GOTO 470
420	REM on error, calculate address that failed to program
430	DC=DBY(19H)+256*DBY(1BH)-1
440	PH0. "ERROR: Source address ",DC," = ",XBY(DC)
450	DP=DBY(18H)+256*DBY(1AH)
460	PH0. " Destination address ",DP," = ",XBY(DP)
470	END

500	REM separate B into high (BH) and low (BL) bytes
510	BL=(B.AND.0FFH)
520	BH=INT(B/256)
530	RETURN
 