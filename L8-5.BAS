1	REM reserve space for 1 string variable,
2	REM 1 character in length
3	STRING 3,1
4	REM You must add lines 10 through 380 of listing 8-4 
5	REM to this program

400	Z=0
410	DO
420	INPUT "Press a key: ",$(0)
430	PRINT $(0)
440	REM reset display after 8 characters
450	IF Z=8 THEN Z=0:RW=0:I=1:GOSUB 900
460	REM keep track of how many characters are displayed
470	Z=Z+1
480	REM display the character matching the key press
490	D=ASC($(0),1):GOSUB 800
500	WHILE 1=1
600	END

790	REM write data to the display
800	XBY(X)=RS+1
810	XBY(X)=RW
820	XBY(A)=D
830	XBY(X)=E+1:XBY(X)=E
840	RETURN

890	REM write an instruction to the display
900	XBY(X)=RS
910	XBY(A)=I
920	XBY(X)=E+1:XBY(X)=E
930	RETURN
