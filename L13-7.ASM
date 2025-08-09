;example program for creating custom commands and instructions in BASIC-52
;system must contain code memory from 2000h-2079h

tokentable	equ	2100h	;start address, token table
vectortable	equ	2200h	;start address, vector table

	org	2002h	;5Ah at 2002h tells BASIC-52 
	db	 5ah	;to call 2048h (see below)

	org	2048h	;Set bit 45 to tell BASIC-52 
			;that custom commands or 
	setb	45	;instructions have been
	ret		;added

	org	2078h	;stores starting address of 
	mov	dptr,#tokentable	token table
	ret

	org	2070h	;stores starting address of 
	mov	dptr,#vectortable	vector table
	ret

	org	tokentable	;token table start address
	db	10h	;first user-defined token
	db	 "TGGP10"	;command or instruction name
			;(must use all capital
			;letters, beginning
			;combination of letters
			;must be unique)

	db	 0	;end of token indicator

	db	 11h	;2nd user-defined token
	db	 "SETP10"	;command or instruction name
	db	 0	;end of token indicator

	db	 12h	;final user-defined token
	db	 "CLRP10"	;command or instruction name
	db	 0ffh	;end of list indicator
	;can add up to 1Fh tokens
	;final token must end with 0ffh

	org	vectortable	;vector table address
	dw	 tggp10	;label to branch to on 
			;TGGP10 command
	dw	 setp10	;label to branch to on 
			;SETP10 command
	dw	 clrp10	;label to branch to on 
			;CLRP10 command

tggp10 org	3000h ;use any available address
	cpl	p1.0	;complement Port 1, bit 0 
			;(pin 1)
	ret		;return to BASIC-52

setp10 org	3010h ;use any available address 
	setb	p1.0	;set Port 1, bit 0 (pin 1)
	ret		;return to BASIC-52

clrp10 org	3020h ;use any available address
	clr	p1.0	;clear Port 1, bit 0 (pin 1)
	ret		;return to BASIC-52

	end
