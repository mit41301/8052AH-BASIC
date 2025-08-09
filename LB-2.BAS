REM HEXLOAD.BAS utility program for use with BCI51 and BASIC-52
REM 
REM Your BASIC-52 target card MUST support overlaid code and data memory
REM to use this program! REM Refer to the BCI51 manual, Configuration 
REM Directives, CODE START and DATA START.
REM
REM If you will be loading into RAM, use HEX2RAM.BAS instead.  It is
REM considerably smaller and faster.
REM

new
1 STRING 82, 80
2 PRINT TAB(22),"HEX FILE LOADING PROGRAM 1.2"
3 PRINT TAB(14), "(C) 1990,1991 Systronix Inc. All rights reserved." : PRINT
4 PRINT "This program accepts as input, an Intel format hex file and stores"
5 PRINT "it in RAM, EPROM, or EEPROM at the addresses specified." : PRINT
6 PRINT : PRINT "Select the destination device type:" : PRINT
7 PRINT TAB(10), "[1] RAM" : PRINT TAB(10), "[2] Timed EEPROM"
8 PRINT TAB(10), "[3] EPROM (Intelligent algorithm)"
9 PRINT TAB(10), "[4] EPROM (50mS algorithm)"
10 PRINT TAB(10), "[5] EEPROM (RDY/BUSY type)"
11 INPUT "Select Device Type (1, 2, 3, 4, 5) >> ", TYPE
12 IF (TYPE < 1) .OR. (TYPE > 5) THEN PRINT CHR(7) : GOTO 11
20 TYPE=TYPE-1 : IF TYPE = 0 THEN GOTO 1300
21 if type = 1 then goto 22 else goto 30
22 INPUT "Delay between writes >> ", delay : goto 1300
30 ON (TYPE) GOSUB 2100, 2100, 2110, 2120, 2100
40 IF TYPE = 2 THEN DBY(38) = DBY(38) .OR. 8 ELSE DBY(38) = DBY(38) .AND. 0f7H
rem Calculate and store pulse width
50 WAIT = 65536-WAIT*XTAL/12 : DBY(40H) = WAIT/256 : DBY(41H) = WAIT.AND.0ffH

1300 PRINT "Ready to receive the input file one line at a time. Set your"
1310 PRINT "communication software to send a line when when it receives"
1320 PRINT "the '>' prompt." : PRINT

1330 SOURCE = MTOP - FREE + 1
1340 LINE = LINE + 1 : INPUT">", $(0) : PRINT "Validating input buffer ...",
1350 I = 1 : C = ASC($(0),1) : IF C<>58 THEN GOTO 3000 : REM if not ":"

rem Get the byte count and save it in the variable COUNT
1360 I = 2 : GOSUB 2000 : COUNT = CH

rem Get the starting address for this record's data 
1370 FOR I = 4 TO 7 STEP 2 : GOSUB 2000 : ADDR = (ADDR * 256) + CH : NEXT
rem Get the record type (we only understand types 0 and 1)
1380 I = 8 : GOSUB 2000 : IF (CH <> 0 .AND. CH <> 1) THEN GOTO 3010
1385 IF TYPE <> 0 .AND. ADDR < 8000H .AND. CH = 0 THEN GOTO 3040
1390 RECORD = CH

rem Get the individual bytes, accumulate them in the check sum and store
rem them in memory
1400 INDEX = SOURCE : FOR I = 10 TO 10 + (COUNT * 2) STEP 2 : GOSUB 2000

rem Here we deal with the data bytes (not executed when RECORD is type 1)
1410 CHECK=CHECK+CH
1420 IF RECORD = 1 THEN GOTO 1440
1430 XBY(INDEX)=CH : INDEX = INDEX + 1 : NEXT

rem Calculate the checksum
1440 CHECK=(CHECK+(ADDR/256)+(ADDR.AND.0FFH)+COUNT+RECORD).AND.0FFH
1450 IF CHECK<>0 THEN GOTO 3020

1460 IF RECORD = 1 THEN GOTO 3030
1470 PRINT CR, "Storing a Data record of", COUNT, "bytes at", : PH0. ADDR

rem Retreive the data from memory and store them in the proper addresses
1480 on type gosub 1500, 1570, 1520, 1520, 1520

rem Restore our variables and continue
1490 ADDR = 0 : CHECK=0 : GOTO 1340

rem Store the data in RAM
1500 FOR I=SOURCE TO SOURCE + COUNT-1 : XBY(ADDR)=XBY(I) 
rem Now verify that stored data is readable as code
1505 if XBY(I) <> CBY(ADDR) THEN GOTO 3130
1508 ADDR = ADDR+1 : NEXT 
1510 RETURN

rem Store the data in EPROM or RDY/BUSY EEPROM
rem First load the source address registers
1520 DBY (1BH) = SOURCE/256 : DBY (19H) = SOURCE .AND. 0FFH

rem Now load the destination address registers
1530 DBY (1AH) = (ADDR-1)/256 : DBY (18H) = (ADDR - 1) .AND. 0FFH

rem Now load the number of bytes to program
1540 DBY (1Fh) = COUNT/256 : DBY (1Eh) = COUNT .AND. 0FFh

rem Program the data into the part
1550 PGM : IF DBY (1Fh) .OR. DBY (1Eh) <> 0 THEN GOTO 3060
1560 RETURN

1570 FOR I=SOURCE TO SOURCE + COUNT-1 : XBY (ADDR) = XBY (I) 
1580 time = 0 : dby (47h) = 0 : clock1 : do : until time >= delay
1590 if xby (addr) <> xby (i) goto 3100
1600 addr = addr + 1: clock0 : next : clock0 : return

rem Convert the ASCII text to numbers
2000 C = ASC($(0),I) : IF (C<=70 .AND. C>=65) THEN C = C - 55 ELSE C = C - 48
2020 CH = C * 16 : C = ASC($(0),I + 1)
2040 IF (C<=70 .AND. C>=65) THEN C = C - 55 ELSE C = C - 48
2050 CH = CH + C : RETURN

rem Here when we are going to load the data into EEPROM.
2100 WAIT = 0.0005 : RETURN
rem Here for Intelligent programming
2110 WAIT = 0.001 : RETURN
rem Here for un-Intelligent programming
2120 WAIT = 0.05 : RETURN

rem Error messages and program termination
3000 PRINT  CR ,"Line ",LINE," EXPECTED ':', FOUND '",CHR(C),"'" :  END 
3010 PRINT CR, "Line ", LINE, ": Unknown record type", CH : END
3020 PRINT CR, "Line ", LINE, ": Checksum failure. Expected",
3025 ph0. abs (check - ch) : END
rem Normal program exit point
3030 PRINT CR, "Received an End record in line",LINE : END
3040 print cr, "Line", LINE, ": Illegal EPROM/EEPROM address :",
3050 ph0. ADDR : end
3060 print CR, "Line", LINE, ": PGM error at address",
3070 addr = dby (1ah) * 256 + dby (18h) : ph0. addr
3080 ph0. "The byte at", address, " is", xby(address)
3090 ph0. "The byte should be",dby (28) : end
3100 ph0. CR, "Line", LINE, ": Error writing at address", addr
3110 ph0. "The byte at", addr, " is", xby(addr)
3120 ph0. "The byte should be", xby (i) : end
3130 ph0. "The byte at",addr," failed a verify with CBY" : END
