LIST P=p16f877
#include <p16f877.inc>

; PIC16F84A Configuration Bit Settings

; CONFIG
__CONFIG _HS_OSC & _WDTE_OFF & _PWRTE_ON & _CP_OFF & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _WRT_OFF

;-------Definicion de variables de RAM--------

;////////// BANCO 0 ///////////////
;libre		equ 0x20

;libre		equ 0x6F

;////////// BANCO 0/1/2/3 ///////////////
;libre		equ 0x70

;libre		equ 0x7F

;////////// BANCO 1 ///////////////
;libre		equ 0xA0

;libre		equ 0xEF

;////////// BANCO 2 ///////////////
;libre		equ 0x110

;libre		equ 0x16F

;////////// BANCO 3 ///////////////
;libre		equ 0x190

;libre		equ 0x1EF
;------------------------------------------------------------------------------:
	org	0x00
	goto 	MAIN
;---------------------------------------------------------------------
;*********************************************************************
; VECTOR INTERRUP
;*********************************************************************
	org 	0x04
;*********************************************************************
	org	10h
MAIN:
	call    init_Pic
LOOP:
	btfsc   PORTB,0
	goto    LOOP
PRESSED:
	btfss   PORTB,0
	goto    PRESSED
	btfsc   PORTA,0
	goto    CLEAR
	bsf	    PORTA,0
	goto    LOOP
CLEAR:
	bcf	PORTA,0
	goto    LOOP
;------------------------------------------------------------------------------:
; Inicicializacion del PIC
;------------------------------------------------------------------------------:
init_Pic:
	clrf	STATUS	;BANK0
	
    ;*******interrupciones**********
	clrf    INTCON 	;DISABLE INTERRUPTIONS & CLEAN FLAGS
	clrf    PIE1
	clrf    PIE2
	
    ;*******control de puertos**********
	clrf    PORTA       ; Initialize PORTA by clearing output data latches
	bsf	STATUS,5	; Select Bank 1
    
	clrf    TRISA       ; Set RA<5:0> as outputs ; TRISA<7:6>are always; read as '0'
	bsf	TRISB,0		; Set RB<0> as input
    
	movlw   0x06        ; Configure all pins as digital inputs
	movwf   ADCON1

	bcf	    ADCON0,0	;DISABLE A/D (JUST IN CASE)
end_init_Pic:
	bcf	    STATUS,RP0
	
	clrf    PORTA
	clrf    PORTB
	clrf    PORTC
	clrf    PORTD
	clrf    PORTE
	RETURN

	END
