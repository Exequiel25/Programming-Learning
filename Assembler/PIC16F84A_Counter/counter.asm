LIST P=p16f84
#include <p16f84.inc>

; PIC16F84A Configuration Bit Settings

; CONFIG
__CONFIG _HS_OSC & _WDT_OFF & _PWRTE_ON &_CP_OFF
				; Oscillator Selection bits (HS
				; oscillator) Watchdog Timer (WDT
				; disabled) Power-up Timer Enable bit
				; (Power-up Timer is enabled) Code
				; Protection bit (Code protection
				; disabled)

; Variables
DCounter1   EQU	    0X0C
DCounter2   EQU	    0X0D
DCounter3   EQU	    0X0E
Counter	    EQU	    0x0F
;------------------------------------------------------------------------------:
; Code
	org	0x00
MAIN:
	bcf	STATUS,6
	bsf	STATUS,5
	clrf	PORTB
	movlw   0xFF
	movwf   PORTA
	bcf	STATUS,6
	bcf	STATUS,5
FIRST_Counter:
	movlw   0x0F
	movwf   Counter
LOOP:
	clrf    PORTB
	btfss   PORTA,4
	goto    LOOP
	call    DISPLAY
	goto    LOOP
;------------------------------------------------------------------------------:
; Subrutine
DISPLAY:
	movfw   Counter
	call    SEVEN_SEG
	movwf   PORTB
	call    DELAY
	decfsz  Counter,F
	goto    DISPLAY
	goto    FIRST_Counter
DELAY:
	movlw   0Xac
	movwf   DCounter1
	movlw   0X13
	movwf   DCounter2	    
	movlw   0X06
	movwf   DCounter3
DECREMENT:
	decfsz  DCounter1, 1
	goto    DECREMENT
	decfsz  DCounter2, 1
	goto    DECREMENT
	decfsz  DCounter3, 1
	goto    DECREMENT
	NOP

	RETURN
    
SEVEN_SEG:
	addwf   PCL,F
	retlw   0x3F	    ;0
	retlw   0x06	    ;1
	retlw   0x5B	    ;2
	retlw   0x4F	    ;3
	retlw   0x66	    ;4
	retlw   0x6D	    ;5
	retlw   0x7D	    ;6
	retlw   0x07	    ;7
	retlw   0x7F	    ;8
	retlw   0x6F	    ;9
	retlw   0x77	    ;A
	retlw   0x7C	    ;b
	retlw   0x39	    ;C
	retlw   0x5E	    ;d
	retlw   0x79	    ;E
	retlw   0x71	    ;F
	RETURN

	END
