1 REM You must add lines 5-380 from Listing 8-4 to this
2 REM program.
400 REM R1-R8 store row patterns for custom character
401 R1=4
402 R2=0
403 R3=4
404 R4=8
405 R5=10H
406 R6=11H
407 R7=0BH
408 R8=0

410	REM custom character number
420	CC=0
430	XBY(X)=RS
440	XBY(X)=RW
450	REM display clear
460	XBY(A)=1
470	XBY(X)=E+1:XBY(X)=E
480	REM set CG RAM address to 0
490	XBY(A)=40H
500	XBY(X)=E+1:XBY(X)=E

510	REM store R1-R8 in CG RAM
520	D=(CC)+R1
530	GOSUB 800
540	D=(CC)+R2
550	GOSUB 800
560	D=(CC)+R3
570	GOSUB 800
580	D=(CC)+R4
590	GOSUB 800
600	D=(CC)+R5
610	GOSUB 800
620	D=(CC)+R6
630	GOSUB 800
640	D=(CC)+R7
650	GOSUB 800
660	D=(CC)+R8
670	GOSUB 800
680	XBY(X)=RS
690	XBY(X)=RW

700	REM set DD RAM address to 0
710	XBY(A)=80H
720	XBY(X)=E+1:XBY(X)=E
730	XBY(X)=RS+1
740	REM write custom character 0 to display
750	XBY(A)=0
760	XBY(X)=E+1:XBY(X)=E
770	END

790	REM write data to display
800	XBY(X)=RS+1
805	XBY(X)=RW
810	XBY(A)=D
820	XBY(X)=E+1:XBY(X)=E
840	RETURN

890	REM write an instruction to the display
900	XBY(X)=RS
910	XBY(A)=I
920	XBY(X)=E+1:XBY(X)=E
930	RETURN
