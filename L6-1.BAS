10	A=XBY(0E000H)
20	PRINT "Bit 0 = ",(A.AND.1)
30	PRINT "Bit 1 = ",(A.AND.2)/2
40	PRINT "Bit 2 = ",(A.AND.4)/4
50	PRINT "Bit 3 = ",(A.AND.8)/8
60	PRINT "Bit 4 = ",(A.AND.10H)/10H
70	PRINT "Bit 5 = ",(A.AND.20H)/20H
80	PRINT "Bit 6 = ",(A.AND.40H)/40H
90	PRINT "Bit 7 = ",(A.AND.80H)/80H
100	END
 