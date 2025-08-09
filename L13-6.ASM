;On external interrupt 1, Port 1, bit 0 is complemented

	org	4013h	;vector for external 
			;interrupt 1
	cpl	p1.0	;complement Port 1, bit 0 
			;(pin 1)
	pop	psw	;push psw was automatic on 
			;interrupt,
			;but pop psw must be added
	reti
	end
