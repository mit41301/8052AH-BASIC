REM HEX2RAM.BAS utility program for use with BCI51 and BASIC-52
REM 
REM Your BASIC-52 target card MUST support overlaid code and data memory
REM to use this program! REM Refer to the BCI51 manual, Configuration 
REM Directives, CODE START and DATA START.
REM

new
10 STRING 82, 80 : DIM HI (70) : DIM LOW (70)
15 FOR I=48 TO 57 : HI(I) = (I - 48) * 16 : LOW(I) = I - 48 : NEXT
25 FOR I=65 TO 70 : HI(I) = (I - 55) * 16 : LOW(I) = I - 55 : NEXT

35 PRINT TAB(19),"INTEL HEX FILE TO RAM LOADING PROGRAM V1.1"
45 PRINT TAB(14), "Copyright 1991 Systronix Inc. All rights reserved." : PRINT
55 PRINT tab(8),"This program accepts as input an Intel hex file and stores"
65 PRINT tab(8),"it in external RAM at the addresses specified in the HEX file.":PRINT

75 PRINT tab(8),"Ready to receive the input file one line at a time. Set your"
85 PRINT tab(8),"communication software to send a line when when it receives"
95 PRINT tab(8),"the '>' prompt." : PRINT

100 LINE=LINE+1 : INPUT ">",$(0) : PRINT"Validating and storing...",
105 C = ASC($(0),1) : IF C<>58 THEN GOTO 500

rem Get the byte count and save it in the variable COUNT
115 I = 2 : GOSUB 700 : COUNT = CH

rem Get the starting address for this record's data 
125 FOR I = 4 TO 7 STEP 2 : GOSUB 700 : ADDR = (ADDR * 256) + CH : NEXT
rem Get the record type (we only understand types 0 and 1)
135 I = 8 : GOSUB 700 : IF (CH <> 0 .AND. CH <> 1) THEN GOTO 510
145 RECORD = CH
rem The initial checksum calculation
155 CHECK=(ADDR/256)+(ADDR.AND.0FFH)+COUNT+RECORD

rem Get the individual bytes, accumulate them in the check sum and store
rem them in memory at the appropriate destination
165 FOR I = 10 TO 10 + (COUNT * 2) STEP 2 : GOSUB 700

rem Here we deal with the data bytes (not executed when RECORD is type 1)
175 CHECK=CHECK+CH
185 IF RECORD = 1 THEN GOTO 210

rem Store the data in RAM
195 XBY(ADDR)=CH
205 if CBY (ADDR) <> CH THEN GOTO 550 ELSE ADDR = ADDR + 1 : NEXT

210 CHECK=CHECK.AND.0FFH : IF CHECK<>0 THEN GOTO 520
215 IF RECORD = 1 THEN GOTO 640

rem Reset and continue
225 ADDR = 0 : PRINT CR : GOTO 100

rem Error messages and program termination
500 PRINT  CR, "Line ", LINE, ": Character", I, "unexpected" : goto 600
510 PRINT CR, "Line ", LINE, ": Unknown record type", CH : goto 600
520 PRINT CR, "Line ", LINE, ": Checksum failure. Expected",
525 ph0. abs (CHECK-CH) : goto 600

550 PRINT CR, "Line", LINE, ": Verify error at address", : ph0. addr
555 ph0. "The byte at", addr, " is", cby (addr)
565 ph0. "The byte should be", CH : goto 600

600 PRINT "Stop sending input file. Type a ^C to quit."
605 goto 605

rem Normal program exit point
640 PRINT CR, "Received an End record in line",LINE : END

rem Convert the ASCII text to numbers
700 C = ASC($(0),I) : CH = HI(C) : C = ASC($(0),I + 1) : CH = CH + LOW (C)
705 RETURN
