10	DO
20	INPUT "Enter 0 (read), 1 (write), or 2 (quit): ",RW
30	IF RW=0 THEN GOSUB 70
40	IF RW=1 THEN GOSUB 120
50	WHILE RW<>2
60	END
70	PH0."External RAM ranges from 0 to ",MTOP
80	INPUT "Enter an address to read : ",A
90	B=XBY(A)
100	PH0.B," is stored in address ",A
110	RETURN
120	PH0."Free memory ranges from ",LEN+512," to ",MTOP
130	INPUT "Enter an address to write to :",A
140	INPUT "Enter data to be written :",B
150	XBY(A)=B
160	PH0.B," has been written to address ",A
170	RETURN
