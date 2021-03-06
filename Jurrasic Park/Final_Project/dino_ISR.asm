    XDEF  dino_ISR,hunger1,hunger2,hunger3,anger1,anger2,anger3
    XREF  emergency_flag,emergency_menu,roar1,roar2,roar3,RTIFLG
    
MY_VARIABLE: SECTION
dino_count:  ds.w  1
hunger1:  ds.b  1
hunger2:  ds.b  1
hunger3:  ds.b  1
anger1:   ds.b  1
anger2:   ds.b  1
anger3:   ds.b  1




MY_CODE:  SECTION

              MOVW  #$0, dino_count          ;initialize count to 0\
              movb  #$8,hunger1
              movb  #$8,hunger2              ;each dino loses hunger value at differnt intervals
              movb  #$8,hunger3
              movb  #$0,anger1
              movb  #$0,anger2
              movb  #$0,anger3


dino_ISR:      ldaa hunger1                       ;check hunger before decrement and hunger should not go below 0 but just incase
               cmpa $00 
               lble set_emergency1
               ldaa hunger2
               cmpa $00
               lble set_emergency2
               ldaa hunger3
               cmpa $00
               lble set_emergency3
               
     
              INC   dino_count               ;increment count
              LDX   dino_count               ;count till 1000 for 1 millisecond
              CPX   #20000              ;20 seconds?
              BNE   check2                ;branch if equal to 1 millisecond, exit
              dec   hunger2
check2:       cpx   #25000               ;25 seconds
              bne   check3
              dec   hunger3
check3:       cpx   #30000             ;30 seconds
              bne   EXIT
              LDX   #0                 ;reset to 0 if = 1s
              STX   dino_count
              dec   hunger1
              lbra  EXIT
             
set_emergency1: movb #$1, emergency_flag
                jsr roar1
               jsr  emergency_menu
                lbra EXIT
set_emergency2: movb #$2, emergency_flag
                jsr roar2
               jsr  emergency_menu                                
                lbra EXIT
set_emergency3: movb #$3, emergency_flag
                jsr roar3
               jsr  emergency_menu                 

EXIT:         BSET  RTIFLG, $80         ;reset RTI flag
              RTI 