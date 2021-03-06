     XDEF  emergency_ISR
    XREF  emergency_flag,display_string,disp,roar1,roar2,roar3,RTIFLG

 MY_Constant: section
val1 dc.b  $0a,$12,$14,$0C
p_ddr equ $25A
port_p equ $258
lockdown: ds.w 1

      
My_code: Section

              movw  #$0,lockdown              
              ldab  #0

emergency_ISR:    ldaa emergency_flag
              cmpa  $1
              lbne EXIT                            ;checks emergency flag and decides speed depending

              inc lockdown
              ldy lockdown
              cpy #35000        ;35 seconds 
              lbne EXIT
              ldy #0
              sty lockdown
              
              movb #'G',disp
              movb #'a',disp+1
              movb #'m',disp+2
              movb #'e',disp+3
              movb #' ',disp+4
              movb #'O',disp+5
              movb #'v',disp+6
              movb #'e',disp+7
              movb #'r',disp+8
              movb #' ',disp+9
              movb #'D',disp+10
              movb #'i',disp+11
              movb #'n',disp+12
              movb #'o',disp+13
              movb #'s',disp+14
              movb #' ',disp+15
              movb #'W',disp+16
              movb #'i',disp+17
              movb #'n',disp+18
              movb #'!',disp+19
              movb #'!',disp+20
              movb #' ',disp+21
              movb #' ',disp+22
              movb #' ',disp+23
              movb #' ',disp+24
              movb #' ',disp+25
              movb #' ',disp+26
              movb #' ',disp+27
              movb #' ',disp+28
              movb #' ',disp+29
              movb #' ',disp+30
              movb #' ',disp+31
              movb #0,disp+32    ;string terminator, acts like '\0'
              ldd #disp
              jsr display_string
              jsr roar1
              jsr roar2
              jsr roar3
              bne   EXIT
              ldab  #0

               
              
              
EXIT:         BSET  RTIFLG, $80         ;reset RTI flag
              RTI               