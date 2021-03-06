     XDEF  RTI_ISR,hunger1,hunger2,hunger3,anger1,anger2,anger3,dino_count,lockdown,travel_count,second,seq_count
     XREF  emergency_flag,travel_flag,emergency_menu,roar1,roar2,roar3,display_string,disp,Gameover,RTIFLG

 MY_Constant: section
val1 dc.b  $0a,$12,$14,$0C
p_ddr equ $25A
port_p equ $258


MY_VARIABLE:SECTION
second: ds.w 1
seq_count: ds.w 1
travel_count:  ds.w  1
dino_count:  ds.w  1
hunger1:  ds.b  1
hunger2:  ds.b  1
hunger3:  ds.b  1
anger1:   ds.b  1
anger2:   ds.b  1
anger3:   ds.b  1
lockdown: ds.w 1
 
     
My_code: Section

            
               
RTI_ISR:      ldaa emergency_flag
              cmpa  $0
              bne danger                            ;checks emergency flag and decides speed depending

              inc second
              ldy second
              cpy #1000 ;full speed every second                      ;if emergency is off then ticks every second
              bne travel_ISR
              ldy #0
              sty second
              ldx #val1
              ldaa  b,x
              staa  port_p
              inc   seq_count
              ldab  seq_count
              cmpb  #4
              bne   travel_ISR
              ldab  #0
              stab  seq_count
              lbra travel_ISR
              
danger:       inc second
              ldy second
              cpy #500   ;double speed every half second
              lbne emergency_ISR
              ldy #0
              sty second
              ldx #val1                                           ;if emergency on then ticks every half second
              ldaa  b,x
              staa  port_p
              incb
              cmpb  #4
              lbne   emergency_ISR
              ldab  #0
              stab  seq_count
               
              
              
              
              
travel_ISR:   ldaa  travel_flag
              cmpa  #0
              beq dino_ISR

              INC   travel_count               ;increment count
              LDX   travel_count               ;count till 1000 for 1 millisecond
              CPX   #20000              ;20 seconds
              BNE   dino_ISR                ;branch if equal to 1 millisecond, exit
              LDX   #0                  ;reset to 0 if = 1s
              STX   travel_count             
              movb #0,travel_flag
                                                 ;travel for 20 seconds then reset travel flag which is set and reset from main menu              
              
              
              
              
dino_ISR:      ldaa hunger1                       ;check hunger before decrement and hunger should not go below 0 but just incase
               cmpa $00 
               lble set_emergency1
               ldaa hunger2
               cmpa $00
               lble set_emergency2
               ldaa hunger3
               cmpa $00
               lble set_emergency3
               
               ldaa anger1                       ;check hunger before decrement and hunger should not go below 0 but just incase
               cmpa $03 
               lble set_emergency1
               ldaa anger2
               cmpa $03
               lble set_emergency2
               ldaa anger2
               cmpa $03
               lble set_emergency3
               
     
              INC   dino_count               ;increment count
              LDX   dino_count               ;count till 1000 for 1 millisecond
              CPX   #20000              ;20 seconds
              BNE   check2                ;branch if equal to 1 millisecond, exit
              dec   hunger2
check2:       cpx   #25000               ;25 seconds
              bne   check3
              dec   hunger3
check3:       cpx   #30000             ;30 seconds
              lbne   EXIT
              LDX   #0                 ;reset to 0 if = 1s
              STX   dino_count
              dec   hunger1
              lbra  emergency_ISR
             
set_emergency1: movb #$1, emergency_flag
                jsr roar1
               jsr  emergency_menu
                lbra emergency_ISR
set_emergency2: movb #$1, emergency_flag
                jsr roar2
               jsr  emergency_menu                                
                lbra emergency_ISR
set_emergency3: movb #$1, emergency_flag
                jsr roar3
               jsr  emergency_menu              
                
              
emergency_ISR:ldaa emergency_flag
              cmpa  $1
              lbne EXIT                            ;checks emergency flag and decides speed depending

              inc lockdown
              ldy lockdown
              cpy #35000        ;35 seconds 
              lbne EXIT
              ldy #0
              sty lockdown
              jsr Gameover
             

              
EXIT:         BSET  RTIFLG, $80         ;reset RTI flag
              RTI               