
            XDEF Pen3
            XREF travel,init_LCD,read_pot,display_string,pot_value,KeyPad,feed3,roar3,hunger3,keyval,disp,traveling
          
My_Constant: 	section
port_p equ $258
p_ddr equ $25A
port_t: equ $240 ;input ports
port_s: equ $248
ddr_s:  equ $24A


MY_EXTENDED_RAM: SECTION
seq1  dc.b  $0,$1,$3,$7,$F,$1F,$3F,$7F,$FF

MY_CODE:  SECTION

Pen3:      ldab hunger3           ;gets hunger val and an array with the leds that match index of hunger val
           ldx  #seq1
           ldaa b,x                 ;loads a with the one led value that matches hunger that displays it
           staa port_s       
           jsr  read_pot                  ;uses pot to scroll menu and after it is maxed will read an input same as main menu
           ldab pot_value 
           cmpb #$33
           lbge  option2
           movb #'N',disp
           movb #'a',disp+1
           movb #'m',disp+2
           movb #'e',disp+3
           movb #':',disp+4
           movb #' ',disp+5
           movb #'C',disp+6
           movb #'e',disp+7
           movb #'r',disp+8
           movb #'a',disp+9
           movb #' ',disp+10
           movb #' ',disp+11
           movb #'T',disp+12
           movb #'Y',disp+13
           movb #'p',disp+14
           movb #'e',disp+15
           movb #':',disp+16
           movb #' ',disp+17
           movb #'T',disp+18
           movb #'r',disp+19
           movb #'i',disp+20
           movb #'c',disp+21
           movb #'e',disp+22
           movb #'r',disp+23
           movb #'a',disp+24
           movb #'t',disp+25
           movb #'o',disp+26
           movb #'p',disp+27
           movb #'s',disp+28
           movb #' ',disp+29
           movb #' ',disp+30
           movb #' ',disp+31
           movb #0,disp+32    ;string terminator, acts like '\0'
           ldd #disp
            jsr display_string
           lbra  Pen3
           
option2:   cmpb #$66
           lbge  option3
           movb #'D',disp
           movb #'i',disp+1
           movb #'e',disp+2
           movb #'t',disp+3
           movb #':',disp+4
           movb #' ',disp+5
           movb #'H',disp+6
           movb #'e',disp+7
           movb #'r',disp+8
           movb #'b',disp+9
           movb #'i',disp+10
           movb #'v',disp+11
           movb #'o',disp+12
           movb #'r',disp+13
           movb #'e',disp+14
           movb #' ',disp+15
           movb #' ',disp+16
           movb #' ',disp+17
           movb #'1',disp+18
           movb #'.',disp+19
           movb #'F',disp+20
           movb #'e',disp+21
           movb #'e',disp+22
           movb #'d',disp+23
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
           lbra  Pen3
           
option3:   cmpb #$99
           lbge  option4
           movb #'2',disp
           movb #'.',disp+1
           movb #'H',disp+2
           movb #'e',disp+3
           movb #'a',disp+4
           movb #'r',disp+5
           movb #' ',disp+6
           movb #'r',disp+7
           movb #'o',disp+8
           movb #'a',disp+9
           movb #'r',disp+10
           movb #' ',disp+11
           movb #' ',disp+12
           movb #'3',disp+13
           movb #'.',disp+14
           movb #'R',disp+15
           movb #'e',disp+16
           movb #'t',disp+17
           movb #'u',disp+18
           movb #'r',disp+19
           movb #'n',disp+20
           movb #' ',disp+21
           movb #'t',disp+22
           movb #'o',disp+23
           movb #' ',disp+24
           movb #'g',disp+25
           movb #'a',disp+26
           movb #'t',disp+27
           movb #'e',disp+28
           movb #' ',disp+29
           movb #' ',disp+30
           movb #' ',disp+31
           movb #0,disp+32    ;string terminator, acts like '\0'
            ldd #disp
           jsr display_string
           lbra  Pen3
           
option4:   jsr  KeyPad                                         ;after maxed
           ldaa keyval
           cmpa #1                                              
           bne check2
           jsr  feed3
           
check2:    cmpa #2
           bne  check3
           jsr  roar3
           
check3:    cmpa #3
           bne check4
           movb #4,travel
           jsr  traveling
           rts
check4:    lbra Pen3
