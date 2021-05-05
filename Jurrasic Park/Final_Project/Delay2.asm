
    XDEF  Delay2             
    
Delay2:  pshy
        ldy     #1000
loop:   dey                
        bne     loop           
        puly    
        rts    