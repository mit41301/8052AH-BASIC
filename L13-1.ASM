	org	3000h	;location where program will 
			;load in RAM
	cpl	p1.0	;complement Port 1, bit 0 
			;(pin 1)
	ret		;return to BASIC-52

	end
