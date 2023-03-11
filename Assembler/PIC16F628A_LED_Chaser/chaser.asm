LIST P=p16f628
#include <p16f628.inc>

; PIC16F84A Configuration Bit Settings

; CONFIG
__CONFIG _XT_OSC & _WDT_OFF & _PWRTE_ON & _CP_OFF & _CPD_OFF & _MCLRE_ON & _BOREN_ON & _LVP_OFF

;------------------------------------------------------------------------------:
; MACROS
;------------------------------------------------------------------------------:
bank0 MACRO
	bcf	STATUS,5
	bcf 	STATUS,6
    ENDM
bank1 MACRO
	bsf 	STATUS,5
	bcf 	STATUS,6
    ENDM
    
;------------------------------------------------------------------------------:
; Variables RAM
;------------------------------------------------------------------------------:
;    ENERAL PURPOSE STATIC RAM REGISTERS
    ; BANK 0	    20-7Fh
    ; BANK 1	    A0h-FF
    ; BANK 2	    20h-14Fh, 170h-17F
    ; BANK 3	    1F0h-1FFh
    
DCounter1   EQU	    0X20
DCounter2   EQU	    0X21
DCounter3   EQU	    0X22
SCounter    EQU	    0X23
S3Counter   EQU	    0X24
;------------------------------------------------------------------------------:
	org	0x00
	goto	MAIN
  
;*********************************************************************
; VECTOR INTERRUP
;*********************************************************************
	org 	4h
	goto	interrupt
	    
;*********************************************************************
; MAIN CODE
;*********************************************************************
	org	10h
MAIN:
	call    INIT
restart:
	movlw   0x01
	movwf   SCounter
	movlw   0x02
	movwf   S3Counter
sequence:
	decfsz  SCounter
	goto    seq3
	goto    seq1
;------------------------------------------------------------------------------:
; Init PIC
;------------------------------------------------------------------------------:
INIT:
	bank0
    
    ;*******deshabilitar comparadores**********
	movlw   0x7
	movwf   CMCON		; Comparators Off CM2:CM0 = 111
    
    ;*******interrupciones**********
	movlw   b'10010000'
	movwf   INTCON		; Enable RB0/INT interruption, able global interruptions and clean INTF flag
	bcf	OPTION_REG,7	; Enable pull-up RES
	bcf	OPTION_REG,6	; Interrupt on falling edge of RB0/INT pin
    
    ;*******control de puertos**********
	clrf    PORTA		; Initialize PORTA by clearing output data latches
	clrf    PORTB		; Initialize PORTB by clearing output data latches
    
	bank1
	clrf    TRISA
	movlw   1h		
	movwf   TRISB		; Set RB<7:1> as outputs ; RB<0> is for interruptions
	
end_init_Pic:
	bank0
	RETURN
;------------------------------------------------------------------------------:
; Interruption manager
;------------------------------------------------------------------------------:
interrupt:
	clrf	PORTB
	SLEEP
	bcf	INTCON,1
	RETFIE
;------------------------------------------------------------------------------:
; Subrutines
;------------------------------------------------------------------------------: 
seq1:
	bsf	    PORTB,1
	call    DELAY_500ms
	bsf	    PORTB,3
	call    DELAY_500ms
	bsf	    PORTB,5
	call    DELAY_500ms
	bsf	    PORTB,7
	call    DELAY_500ms
seq2:
	bsf	    PORTB,2
	call    DELAY_500ms
	bsf	    PORTB,4
	call    DELAY_500ms
	bsf	    PORTB,6
	call    DELAY_500ms
	goto    sequence
seq3:
	clrf    PORTB
	call    DELAY_500ms
	movlw   0xff
	movwf   PORTB
	call    DELAY_500ms
	decfsz  S3Counter
	goto    seq3
	movlw   0x01
	movwf   SCounter
	clrf    PORTB
	goto    restart
	
DELAY_500ms:
	MOVLW 0X54
	MOVWF DCounter1
	MOVLW 0X8a
	MOVWF DCounter2
	MOVLW 0X03
	MOVWF DCounter3
LOOP_500ms:
	DECFSZ DCounter1, 1
	GOTO LOOP_500ms
	DECFSZ DCounter2, 1
	GOTO LOOP_500ms
	DECFSZ DCounter3, 1
	GOTO LOOP_500ms
	NOP
	RETURN
	
	END
