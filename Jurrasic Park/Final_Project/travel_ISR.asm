    XDEF  travel_ISR
    XREF  travel_flag,RTIFLG
    
MY_VARIABLE: SECTION
travel_count:  ds.w  1

MY_CODE:  SECTION

              MOVW  #$0, travel_count          ;initialize count to 0

travel_ISR:   ldaa  travel_flag
              cmpa  #0
              beq EXIT

              INC   travel_count               ;increment count
              LDX   travel_count               ;count till 1000 for 1 millisecond
              CPX   #20000              ;20 seconds
              BNE   EXIT                ;branch if equal to 1 millisecond, exit
              LDX   #0                  ;reset to 0 if = 1s
              STX   travel_count             
              movb #0,travel_flag
                                                 ;travel for 20 seconds then reset travel flag which is set and reset from main menu
              
              
              
EXIT:         BSET  RTIFLG, $80         ;reset RTI flag
              RTI 