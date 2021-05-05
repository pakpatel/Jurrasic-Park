;**************************************************************
;* This stationery serves as the framework for a              *
;* user application. For a more comprehensive program that    *
;* demonstrates the more advanced functionality of this       *
;* processor, please see the demonstration applications       *
;* located in the examples subdirectory of the                *
;* Freescale CodeWarrior for the HC12 Program directory       *
;**************************************************************
; Include derivative-specific definitions
            INCLUDE 'derivative.inc'

; export symbols
            XDEF Entry, _Startup, main, keyval,travel,disp,emergency_flag,RTIFLG,IRQCR
            ; we use export 'Entry' as symbol. This allows us to
            ; reference 'Entry' either in the linker .prm file
            ; or from C/C++ later on

            XREF __SEG_END_SSTACK,init_LCD,read_pot,display_string,pot_value,KeyPad,traveling,second,seq_count,travel_count,dino_count,hunger1,hunger2,hunger3,anger1,anger2,anger3,lockdown,RTI_ISR     ; symbol defined by the linker for the end of the stack




; variable/data section
MY_EXTENDED_RAM: SECTION
; Insert here your data definition.
keyval:     ds.b 1
disp:     ds.b 33
travel:    ds.b  1
emergency_flag ds.b 1
MY_CONTSANT: SECTION
RTIENA  EQU  $0038     ;location to initialize the interrupt enable regiter
RTICNT  EQU  $003B     ;RTI interval control register location
RTIFLG  EQU  $0037     ;RTI flag register
IRQCR   EQU  $001E     ;IRQ


; code section
MyCode:     SECTION
main:
_Startup:
Entry:
            LDS  #__SEG_END_SSTACK     ; initialize the stack pointer
            MOVB    #$80, RTIENA              ; turn on bit 7 of RTIENA to enable RTI
            MOVB    #$40, RTICNT              ; set the RTI interval to 1ms
            movb    #$C0, IRQCR
            movb  $0,emergency_flag
            movb  $0,travel
              movw  #$0,second 
              movw  #$0,seq_count             
              ldab  #0
              MOVW  #$0, travel_count          ;initialize count to 0
              MOVW  #$0, dino_count          ;initialize count to 0\
              movb  #$8,hunger1
              movb  #$8,hunger2              ;each dino loses hunger value at differnt intervals
              movb  #$8,hunger3
              movb  #$0,anger1
              movb  #$0,anger2
              movb  #$0,anger3 
              movw  #$0,lockdown                          
                          CLI                     ; enable interrupts
            jsr init_LCD
            
            
            
           movb #0, keyval               
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

           
pass1:     jsr display_string
           jsr KeyPad     ;gets a keypad value and if it matches checks next key
           ldaa keyval
           cmpa #1                        ;if the correct value is entered then displays a X in the first slot and gets the second value
           bne  pass1
        
           movb #'X',disp+17 
           ldd #disp  
           jsr display_string
            
pass2:     jsr  KeyPad
           jsr display_string
           ldaa keyval                  ;gets second key and will return here until second key is pressed
           cmpa #2
           bne  pass2
           
           movb #'X',disp+18
            ldd #disp 
            jsr display_string
            
pass3:     jsr  KeyPad
           jsr display_string
           ldaa keyval
           cmpa #3
           bne  pass3
           movb #'X',disp+19
            ldd #disp
            jsr display_string
            
pass4:     jsr  KeyPad
           jsr display_string
           ldaa keyval
           cmpa #4
           bne  pass4
           movb #' ',disp
           movb #'W',disp+1
           movb #'e',disp+2                   ;Sucessful login screen
           movb #'l',disp+3
           movb #'c',disp+4
           movb #'o',disp+5
           movb #'m',disp+6
           movb #'e',disp+7
           movb #' ',disp+8
           movb #'b',disp+9
           movb #'a',disp+10
           movb #'c',disp+11
           movb #'k',disp+12
           movb #' ',disp+13
           movb #'D',disp+14
           movb #'r',disp+15
           movb #'.',disp+16
           movb #' ',disp+17
           movb #'M',disp+18
           movb #'a',disp+19
           movb #'l',disp+20
           movb #'c',disp+21
           movb #'o',disp+22
           movb #'l',disp+23
           movb #'m',disp+24
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
            
           
MainMenu:  jsr  read_pot                  ;uses pot to scroll menu and after it is maxed will read an input
           ldab pot_value                 ;if lower third then display first option
           cmpb #$33
           lbge  option2
           movb #'V',disp
           movb #'i',disp+1
           movb #'s',disp+2
           movb #'i',disp+3
           movb #'t',disp+4
           movb #' ',disp+5
           movb #'P',disp+6
           movb #'e',disp+7
           movb #'n',disp+8
           movb #'1',disp+9
           movb #' ',disp+10
           movb #' ',disp+11
           movb #' ',disp+12
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
           lbra  MainMenu
           
option2:   cmpb #$66                         ;if middle third display second option
           bge  option3
        
           movb #'2',disp+9
            ldd #disp
            jsr display_string
           lbra  MainMenu
           
option3:   cmpb #$99                              ;if higher third then display last option
           bge  option4                           ;if the highest value then and only then get a keypad value
                                                  ;this makes sure the strings are all printed and that they are printed for enough time
           movb #'3',disp+9
            ldd #disp
           jsr display_string
           lbra  MainMenu
           
option4:   jsr  KeyPad                                 ;gets a keypad value and makes sure it is a valid entry
           ldaa keyval                                 ;if valid sets that flag and if not valid rechecks the menu
           cmpa #1
           bne check2
           movb #1,travel
           jsr  traveling
           
check2:    cmpa #2
           bne  check3
           movb #2,travel
           jsr  traveling
           
check3:    cmpa #3
           bne check4
           movb #3,travel
           jsr  traveling
check4:    lbra MainMenu 

           
                      

                   
