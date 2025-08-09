;Reads and copies values in sequence from locations 3000h ;to 30FFh to E400h. A DAC0832 generates a sine wave from ;the values.
;A keypress terminates the routine and returns to BASIC-52.

org	3100h		;load routine above the 
			;stored values
OutputPort	equ	0e400h	;address of port to write 
			;sine values to

;Begin generating the sine wave:
nextcycle	mov	20h,#0ffh	;store initial count at 20h 
			;in internal 
			;data memory
nextvalue	mov	dph,#30h	;put high byte of sine wave 
			;address (30h) 
			;in dptr
	mov	dpl,20h	;copy low byte of sine wave 
			;address from 20h to dptr
	movx	a,@dptr	;place sine wave value in 
			;acc.
	mov	dptr,#OutputPort	;copy port address 
			;to dptr
	movx	@dptr,a	;copy sine wave value to 
			;output port
	djnz	20h,nextvalue	;do another if count > 0
	jb	ri,return	;after writing one complete 
			;cycle, check serial receive
			;flag and quit if set
	sjmp	nextcycle	;if serial flag not set, 
			;begin another cycle

;Return to BASIC-52:
return	clr	ri	;clear serial receive flag
	ret		;return to BASIC

	end
