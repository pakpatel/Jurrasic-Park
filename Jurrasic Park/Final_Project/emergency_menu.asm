            XDEF emergency_menu
            XREF travel,init_LCD,read_pot,display_string,pot_value,KeyPad,keyval,disp,emergency_flag,hunger1,hunger2,hunger3,anger1,anger2,anger3,button_val
            
            
            
            
            
My_Constant: 	section
port_p equ $258
p_ddr equ $25A
port_t: equ $240 ;input ports
t_ddr:  equ $242
port_s: equ $248
ddr_s:  equ $24A

My_Variable: section
var_1 dc.b $0




MY_CODE:  SECTION

  
emergency_menu:     ldaa port_t                ;makes sure emergency switch is on before printing menu
                    bita #%10000000             ;if switch is off then ends the menu
                    lbne end 
                    ldaa  var_1               
                    orab  #%11111111          ;toggle value for all leds
                    stab  port_s
                     movb #'D',disp
                     movb #'i',disp+1
                     movb #'n',disp+2
                     movb #'o',disp+3
                     movb #' ',disp+4
                     movb #' ',disp+5
                     movb #'l',disp+6
                     movb #'o',disp+7
                     movb #'o',disp+8
                     movb #'s',disp+9
                     movb #'e',disp+10
                     movb #'!',disp+11
                     movb #'!',disp+12
                     movb #' ',disp+13
                     movb #'C',disp+14
                     movb #'a',disp+15
                     movb #'l',disp+16
                     movb #'l',disp+17
                     movb #' ',disp+18
                     movb #'S',disp+19
                     movb #'e',disp+20
                     movb #'c',disp+21
                     movb #'u',disp+22
                     movb #'r',disp+23
                     movb #'i',disp+24
                     movb #'t',disp+25
                     movb #'y',disp+26
                     movb #' ',disp+27
                     movb #' ',disp+28
                     movb #' ',disp+29
                     movb #' ',disp+30
                     movb #' ',disp+31
                     movb #0,disp+32    ;string terminator, acts like '\0'

                     
                     ldd #disp
                     jsr display_string
button_loop:         ldaa button_val             ;button val should be 1 after IRQ is pressed during an emergency
                     cmpa $1
                     bne  button_loop
                     
Password:                           
                     movb #' ',disp
                     movb #'E',disp+1                 ;asks for password
                     movb #'n',disp+2
                     movb #'t',disp+3
                     movb #'e',disp+4
                     movb #'R',disp+5
                     movb #' ',disp+6
                     movb #'P',disp+7
                     movb #'a',disp+8
                     movb #'s',disp+9
                     movb #'s',disp+10
                     movb #'c',disp+11
                     movb #'o',disp+12
                     movb #'d',disp+13
                     movb #'e',disp+14
                     movb #':',disp+15
                     movb #' ',disp+16
                     movb #' ',disp+17
                     movb #' ',disp+18
                     movb #' ',disp+19
                     movb #' ',disp+20
                     movb #' ',disp+21
                     movb #' ',disp+22
                     movb #':',disp+23
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

                     
pass1:               jsr display_string
                     jsr KeyPad     ;gets a keypad value and if it matches checks next key
                     ldaa keyval
                     cmpa #1                        ;if the correct value is entered then displays a X in the first slot and gets the second value
                     bne  pass1
                  
                     movb #'X',disp+17 
                     ldd #disp  
                     jsr display_string
                      
pass2:               jsr  KeyPad
                     jsr display_string
                     ldaa keyval                  ;gets second key and will return here until second key is pressed
                     cmpa #2
                     bne  pass2
                     movb #'X',disp+18
                      ldd #disp 
                      jsr display_string
                      
pass3:               jsr  KeyPad
                     jsr display_string
                     ldaa keyval
                     cmpa #3
                     bne  pass3
                     movb #'X',disp+19
                     ldd #disp
                     jsr display_string
                      
pass4:               jsr  KeyPad
                     jsr display_string
                     ldaa keyval
                     cmpa #4
                     bne  pass4
                     movb #' ',disp
                     movb #'C',disp+1
                     movb #'a',disp+2                   ;Sucessful login screen
                     movb #'l',disp+3
                     movb #'l',disp+4
                     movb #'i',disp+5
                     movb #'n',disp+6
                     movb #'g',disp+7
                     movb #' ',disp+8
                     movb #'S',disp+9
                     movb #'e',disp+10
                     movb #'c',disp+11
                     movb #'u',disp+12
                     movb #'r',disp+13
                     movb #'i',disp+14
                     movb #'t',disp+15
                     movb #'y',disp+16
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
                     
                     
                     
                     
end:                 movb $0,emergency_flag
                     movb  #$8,hunger1
                     movb  #$8,hunger2
                     movb  #$8,hunger3
                     movb  #$0,anger1
                     movb  #$0,anger2
                     movb  #$0,anger3
                     rts