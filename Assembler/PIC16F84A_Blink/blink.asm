LIST P=p16f84
#include <p16f84.inc>

; PIC16F84A Configuration Bit Settings

; CONFIG
__CONFIG _XT_OSC & _WDT_OFF & _PWRTE_ON &_CP_OFF
				; Oscillator Selection bits (XT
				; oscillator) Watchdog Timer (WDT
				; disabled) Power-up Timer Enable bit
				; (Power-up Timer is enabled) Code
				; Protection bit (Code protection
				; disabled)
;------------------------------------------------------------------------------:
; Variables
DCounter1 EQU 0X0C
DCounter2 EQU 0X0D
DCounter3 EQU 0X0E

;---------------p--------------------------------------------------------------:
; Code
	org	0x00
MAIN:
	bcf	STATUS,6		; Salir del bank0
	bsf	STATUS,5		; Entrar al bank1
	clrf    PORTB		; Puerta B es salida
	movlw   0xFF		; Mover al registro W 0xFF
	movwf   PORTA		; Pueta A es entrada
	bcf	STATUS,6
	bcf	STATUS,5
LOOP:
	movfw   PORTA		; La entrada se guarda en W
	movwf   PORTB		; Muestro W
	bsf	PORTB,0		; Coloca Pin 0 de PORTB en 1    call    DELAY_200ms
	call	DELAY_200ms
	bcf	PORTB,0		; Coloca Pin 0 de PORTB en 0
	call    DELAY_200ms
	goto	LOOP
;------------------------------------------------------------------------------:
; Subrutine
DELAY_200ms:
	movlw 0Xb9
	movwf DCounter1
	movlw 0X04
	movwf DCounter2
	movlw 0X02
	movwf DCounter3
DECREMENT:
	decfsz DCounter1, 1
	goto DECREMENT
	decfsz DCounter2, 1
	goto DECREMENT
	decfsz DCounter3, 1
	goto DECREMENT
	RETURN
	
	END
