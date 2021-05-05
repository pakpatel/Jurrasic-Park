   XDEF roar3
   XREF SendsChr,PlayTone


MY_CODE:  SECTION

roar3:
               
             ldx 5,sp ;puts data in X
		         ldy 3,sp	;puts the counter in Y
nextval:     ldaa 1,x+; gets a value from the array one at a time
		         psha ;pushes the current value from the array to stack
		         call	SendsChr
		         call PlayTone  
		         leas -1,sp
		         dey
		         bne nextval  
             rts  