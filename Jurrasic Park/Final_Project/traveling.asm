
            XDEF traveling,travel_flag
            XREF travel,init_LCD,read_pot,display_string,pot_value,KeyPad, Pen1, Pen2, Pen3,disp
          
My_Constant: 	section
port_p equ $258
p_ddr equ $25A
port_t: equ $240 ;input ports
bitmask1:  equ $7F        ;01111111 all switches other then emergency need to be on
ddr_t   EQU  $242      ;data direction register of DC motor

MY_EXTENDED_RAM: SECTION
; Insert here your data definition.
travel_flag:     ds.b 1


MY_CODE:  SECTION


traveling:movb  #$1E,p_ddr
          MOVB    #08,ddr_t                 ; set ddr t to output
          movb #'T',disp
           movb #'u',disp+1
           movb #'r',disp+2
           movb #'n',disp+3
           movb #' ',disp+4
           movb #'O',disp+5
           movb #'f',disp+6
           movb #'f',disp+7
           movb #' ',disp+8
           movb #'P',disp+9
           movb #'a',disp+10
           movb #'r',disp+11
           movb #'k',disp+12
           movb #'i',disp+13
           movb #'n',disp+14
           movb #'g',disp+15
           movb #' ',disp+16
           movb #'B',disp+17
           movb #'r',disp+18
           movb #'e',disp+19
           movb #'a',disp+20
           movb #'k',disp+21
           movb #'!',disp+22
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
start:    ldaa port_t
          bita #bitmask1 ;checks switches aginst brake value
          bne start ;will only break out once the sequence is matched                         
          
           movb #1,travel_flag ;starts the travel flag for the interrupt
           movb #'T',disp
           movb #'h',disp+1
           movb #'e',disp+2
           movb #' ',disp+3
           movb #'c',disp+4
           movb #'u',disp+5
           movb #'r',disp+6
           movb #'r',disp+7
           movb #'e',disp+8
           movb #'n',disp+9
           movb #'t',disp+10
           movb #' ',disp+11
           movb #'s',disp+12
           movb #'p',disp+13
           movb #'e',disp+14
           movb #'e',disp+15
           movb #'d',disp+16
           movb #' ',disp+17
           movb #'i',disp+18
           movb #'s',disp+19
           movb #':',disp+20
           movb #' ',disp+21
           movb #' ',disp+22
           movb #' ',disp+23
           movb #' ',disp+24
           movb #'m',disp+25
           movb #'p',disp+26
           movb #'h',disp+27
           movb #' ',disp+28
           movb #' ',disp+29
           movb #' ',disp+30
           movb #' ',disp+31
           movb #0,disp+32  



          jsr read_pot
          ldd pot_value
          MOVB  #$08, port_t  ;set bit 3 of DC motor register to rotate
          ldab  #$30
          ldx #100
          idiv ;D/X q in x remainder in d
          ldab  #$30
          abx
          tfr x,a
          staa disp+21
          
          ldx #10
          idiv ; q in x reaminder in d
          ldab  #$30
          abx
          tfr x,a
          staa  disp+22
          addd  #$30
          std disp+23
          
          ldd #disp
          jsr display_string                  ;displays pot value into lcd one digit at a time 
          ldaa travel_flag                    ;travel flag stays on while traveling and the interrupt will turn it off after a set time
          cmpa  #0
          beq pen_select
          lbra traveling
pen_select: movb  #$00,port_t           ;stops the dc motor
            ldab  travel                 ;after travel time is done will get the travel value from main menu and jump to that pen
            cmpb  #1
            beq pen1
            cmpb  #2
            beq pen2
            cmpb #3
            beq pen3                             ;travel will be 4 when returning so that it will just leave the subroutine instead of visiting another pen
            bra end
pen1:     jsr Pen1


pen2:     jsr Pen2

pen3:     jsr Pen3

end: rts            
