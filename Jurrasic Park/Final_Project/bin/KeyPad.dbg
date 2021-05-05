
            XDEF KeyPad
            XREF Delay2, keyval
          

MY_VAR: SECTION
value   ds.b  1


MY_CONSTANT: SECTION
port_u  equ   $268
ddr_u   equ   $26A
psr_u   equ   $26D
per_u   equ   $26C
lut:    dc.b  $eb,$77,$7b,$7d,$b7,$bb,$bd,$d7,$db,$dd,$e7,$ed,$7e,$be,$de,$ee 
seq:    dc.b  $70,$b0,$d0,$e0 

KeyPad:     pshx
            pshy
            pshd
            movb    #$F0, ddr_u           ;set ddr for u
            movb    #$F0, psr_u           ;set polarity select reg
            movb    #$0F, per_u           ;set polarity enable reg
            
st:         ldx     #seq
Scan:       cpx     #seq+4
            beq     st
            ldaa    1,x+
            staa    port_u   
            jsr     Delay2
            ldaa    port_u
            staa    value
            anda    #$0F 
            cmpa    #$0F
            beq     Scan                    ;if not presssed go back to main routine 
            ldab    #0
            ldy     #lut
lutloop:    ldaa    1,y+
            cmpa    value
            beq     store                  ;if something is pressed store value of b on stack and then return to main
            incb
            bra     lutloop                           
store:      stab    keyval
pwm:        puld
            puly
            pulx
            rts       



