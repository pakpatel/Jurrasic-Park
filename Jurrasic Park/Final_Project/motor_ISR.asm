     XDEF  motor_ISR
     XREF  emergency_flag,RTIFLG

 MY_Constant: section
val1 dc.b  $0a,$12,$14,$0C
p_ddr equ $25A
port_p equ $258


MY_VARIABLE:SECTION
second: ds.w 1
seq_count: ds.w 1 
     
My_code: Section

              movw  #$0,second 
              movw  #$0,seq_count             
              ldab  #0

motor_ISR:    ldaa emergency_flag
              cmpa  $0
              bne danger                            ;checks emergency flag and decides speed depending

              inc second
              ldy second
              cpy #1000 ;full speed every second                      ;if emergency is off then ticks every second
              bne EXIT
              ldy #0
              sty second
              ldx #val1
              ldaa  b,x
              staa  port_p
              inc   seq_count
              ldab  seq_count
              cmpb  #4
              bne   EXIT
              ldab  #0
              lbra EXIT
              
danger:       inc second
              ldy second
              cpy #500   ;double speed every half second
              bne EXIT
              ldy #0
              sty second
              ldx #val1                                           ;if emergency on then ticks every half second
              ldaa  b,x
              staa  port_p
              incb
              cmpb  #4
              bne   EXIT
              ldab  #0
               
              
              
EXIT:         BSET  RTIFLG, $80         ;reset RTI flag
              RTI               