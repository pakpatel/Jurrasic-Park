
            XDEF feed2
            XREF travel,init_LCD,read_pot,display_string,pot_value,KeyPad,Pen2,hunger2,anger2,disp,keyval
          
My_Constant: 	section
port_p equ $258
p_ddr equ $25A
port_t: equ $240 ;input ports



MY_CODE:  SECTION

feed2:      jsr  read_pot                  ;uses pot to scroll menu and after it is maxed will read an input
           ldab pot_value 
           cmpb #$33
           lbge  option2
           movb #'1',disp
           movb #'.',disp+1
           movb #'L',disp+2
           movb #'i',disp+3
           movb #'o',disp+4
           movb #'n',disp+5
           movb #' ',disp+6
           movb #'(',disp+7
           movb #'M',disp+8
           movb #'e',disp+9
           movb #'a',disp+10
           movb #'t',disp+11
           movb #')',disp+12
           movb #' ',disp+13
           movb #' ',disp+14
           movb #' ',disp+15
           movb #' ',disp+16
           movb #' ',disp+17
           movb #' ',disp+18
           movb #' ',disp+19
           movb #' ',disp+20
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
           lbra  feed2
           
option2:   cmpb #$66
           lbge  option3
           movb #'2',disp
           movb #'.',disp+1
           movb #'M',disp+2
           movb #'e',disp+3
           movb #'g',disp+4
           movb #'a',disp+5
           movb #'-',disp+6
           movb #'S',disp+7
           movb #'a',disp+8
           movb #'l',disp+9
           movb #'a',disp+10
           movb #'d',disp+11
           movb #' ',disp+12
           movb #'(',disp+13
           movb #'V',disp+14
           movb #'e',disp+15
           movb #'g',disp+16
           movb #'a',disp+17
           movb #'t',disp+18
           movb #'a',disp+19
           movb #'r',disp+20
           movb #'i',disp+21
           movb #'a',disp+22
           movb #'n',disp+23
           movb #')',disp+24
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
           lbra  feed2
           
option3:   cmpb #$99
           lbge  option4
           movb #'3',disp
           movb #'.',disp+1
           movb #'C',disp+2
           movb #'a',disp+3
           movb #'k',disp+4
           movb #'e',disp+5
           movb #' ',disp+6
           movb #'D',disp+7
           movb #'e',disp+8
           movb #'s',disp+9
           movb #'e',disp+10
           movb #'r',disp+11
           movb #'t',disp+12
           movb #' ',disp+13
           movb #'.',disp+14
           movb #'4',disp+15
           movb #'.',disp+16
           movb #'R',disp+17
           movb #'e',disp+18
           movb #'r',disp+19
           movb #'n',disp+20
           movb #' ',disp+21
           movb #'t',disp+22
           movb #'o',disp+23
           movb #' ',disp+24
           movb #'p',disp+25
           movb #'e',disp+26
           movb #'n',disp+27
           movb #'2',disp+28
           movb #' ',disp+29
           movb #' ',disp+30
           movb #' ',disp+31
           movb #0,disp+32    ;string terminator, acts like '\0'
            ldd #disp
           jsr display_string
           lbra  feed2
           
option4:   jsr  KeyPad
           ldaa keyval
           cmpa #1
           bne  check2
           inc  hunger2
           lbra feed2
           
           
check2:    cmpa #2
           bne  check3
           inc  anger2
           lbra feed2
           
check3:    cmpa #3
           bne check4
           dec anger2
           inc  hunger2
           lbra feed2
           
check4:    rts
